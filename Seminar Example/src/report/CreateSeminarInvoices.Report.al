report 70001 "Create Seminar Invoices"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(SemiarLedgerEntry; "Seminar Ledger Entry")
        {
            RequestFilterFields = "Bill-to Customer No.", "Seminar No.", "Posting Date";
            DataItemTableView = sorting("Bill-to Customer No.", "Document No.", "Charge Type", "Participant Contact No.");

            trigger OnPreDataItem()
            begin
                if PostingDateReq = 0D then begin
                    Error(Text000);
                end;
                if DocDateReq = 0D then
                    Error(Text001);
                Window.Open(Text002 + Text003 + Text004);
            end;

            trigger OnAfterGetRecord()
            begin
                IF "Bill-to Customer No." <> Customer."No." THEN
                    Customer.GET("Bill-to Customer No.");

                IF Customer.Blocked IN [Customer.Blocked::All, Customer.Blocked::Invoice] THEN BEGIN
                    NoOfSalesInvErrors := NoOfSalesInvErrors + 1;
                END ELSE BEGIN
                    IF SemiarLedgerEntry."Bill-to Customer No." <> SalesHeader."Bill-to Customer No." THEN BEGIN
                        Window.UPDATE(1, "Bill-to Customer No.");
                        IF SalesHeader."No." <> '' THEN
                            FinalizeSalesInvoiceHeader();
                        InsertSalesInvoiceHeader();
                    END;
                    Window.UPDATE(2, "Seminar Registration No.");
                    CASE Type OF
                        Type::Resource:
                            BEGIN
                                SalesLine.Type := SalesLine.Type::Resource;
                                CASE "Charge Type" OF
                                    "Charge Type"::Instructor:
                                        SalesLine."No." := "Instructor Resource No.";
                                    "Charge Type"::Room:
                                        SalesLine."No." := "Room Resource No.";
                                    "Charge Type"::Participant:
                                        SalesLine."No." := "Instructor Resource No.";
                                END;
                            END;
                    END;

                    SalesLine."Document Type" := SalesHeader."Document Type";
                    SalesLine."Document No." := SalesHeader."No.";
                    SalesLine."Line No." := NextLineNo;
                    SalesLine.VALIDATE("No.");
                    Seminar.GET("Seminar No.");

                    IF SemiarLedgerEntry.Description <> '' THEN
                        SalesLine.Description := SemiarLedgerEntry.Description
                    ELSE
                        SalesLine.Description := Seminar.Name;
                    SalesLine."Unit Price" := "Unit Price";
                    IF SalesHeader."Currency Code" <> '' THEN BEGIN
                        SalesHeader.TESTFIELD("Currency Factor");
                        SalesLine."Unit Price" :=
                        ROUND(
                        CurrencyExchRate.ExchangeAmtLCYToFCY(
                        WORKDATE, SalesHeader."Currency Code",
                        SalesLine."Unit Price", SalesHeader."Currency Factor"));
                    END;
                    SalesLine.VALIDATE(Quantity, Quantity);
                    SalesLine.INSERT;
                    NextLineNo := NextLineNo + 10000;
                END;

            end;

            trigger OnPostDataItem()
            begin
                Window.Close();
                if SalesHeader."No." = '' then begin
                    MESSAGE(Text007);
                end else begin
                    FinalizeSalesInvoiceHeader();
                    if NoOfSalesInvErrors = 0 then
                        Message(Text005, NoOfSalesInv)
                    else
                        Message(Text006, NoOfSalesInvErrors);
                end;

            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group("Option")
                {
                    field(PostingDateReq; PostingDateReq)
                    {
                        ApplicationArea = all;
                        Caption = 'Posting Date';
                    }
                    field(DocDateReq; DocDateReq)
                    {
                        ApplicationArea = all;
                        Caption = 'Document Date';
                    }
                    field(CalcInvoiceDiscount; CalcInvoiceDiscount)
                    {
                        ApplicationArea = all;
                        Caption = 'Calc. Inv. Discount';
                    }
                    field(PostInvoices; PostInvoices)
                    {
                        ApplicationArea = all;
                        Caption = 'Post Invoices';
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            if PostingDateReq = 0D then
                PostingDateReq := WorkDate();
            if DocDateReq = 0D then
                DocDateReq := WorkDate();
            SalesSetup.Get();
            CalcInvoiceDiscount := SalesSetup."Calc. Inv. Discount";
        end;
    }

    var
        CurrencyExchRate: Record 330;
        Customer: Record 18;
        GLSetup: Record 98;
        SalesHeader: Record 36;
        SalesLine: Record 37;
        SalesSetup: Record 311;
        SalesCalcDiscount: Codeunit 60;
        SalesPost: Codeunit 80;
        CalcInvoiceDiscount: Boolean;
        PostInvoices: Boolean;
        NextLineNo: Integer;
        NoOfSalesInvErrors: Integer;
        NoOfSalesInv: Integer;
        PostingDateReq: Date;
        DocDateReq: Date;
        Window: Dialog;
        Text000: Label 'Please enter the posting date.';
        Text001: Label 'Please enter the document date.';
        Text002: Label 'Creating Seminar Invoices...\\';
        Text003: Label 'Customer No.      #1##########\';
        Text004: Label 'Registration No.   #2##########\';
        Text005: Label 'The number of invoice(s) created is %1.';
        Text006: Label 'Not all the invoices were posted. A total of %1 invoices were not posted.';
        Text007: Label 'There is nothing to invoice.';
        Seminar: Record Seminar;

    local procedure FinalizeSalesInvoiceHeader()
    begin
        IF CalcInvoiceDiscount THEN
            SalesCalcDiscount.RUN(SalesLine);
        SalesHeader.GET(SalesHeader."Document Type", SalesHeader."No.");
        COMMIT;
        CLEAR(SalesCalcDiscount);
        CLEAR(SalesPost);
        NoOfSalesInv := NoOfSalesInv + 1;
        IF PostInvoices THEN BEGIN
            CLEAR(SalesPost);
            IF NOT SalesPost.RUN(SalesHeader) THEN
                NoOfSalesInvErrors := NoOfSalesInvErrors + 1;
        END;

    end;

    local procedure InsertSalesInvoiceHeader()
    begin
        SalesHeader.INIT;
        SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
        SalesHeader."No." := '';
        SalesHeader.INSERT(TRUE);
        SalesHeader.VALIDATE("Sell-to Customer No.", SemiarLedgerEntry."Bill-to Customer No.");
        IF SalesHeader."Bill-to Customer No." <> SalesHeader."Sell-to Customer No." THEN
            SalesHeader.VALIDATE("Bill-to Customer No.", SemiarLedgerEntry."Bill-to Customer No.");
        SalesHeader.VALIDATE("Posting Date", PostingDateReq);
        SalesHeader.VALIDATE("Document Date", DocDateReq);
        SalesHeader.VALIDATE("Currency Code", '');
        SalesHeader.MODIFY;
        COMMIT;
        NextLineNo := 10000;
    end;
}