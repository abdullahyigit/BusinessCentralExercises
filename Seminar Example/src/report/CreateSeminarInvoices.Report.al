report 70001 "Create Seminar Invoices"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(SemiarLedgerEntry; "Seminar Ledger Entry")
        {
            DataItemTableView = sorting("Bill-to Customer No.", "Document No.", "Charge Type", "Participant Contact No.");

            trigger OnPreDataItem()
            begin
                if PostingDateReq = 0D then
                    Error(Text000);
                if DocDateReq = 0D then
                    Error(Text001);
                Window.Open(Text002 + Text003 + Text004);
            end;

            trigger OnAfterGetRecord()
            begin
                if "Bill-to Customer No." <> Customer."No." then
                    Customer.Get("Bill-to Customer No.");
                if Customer.Blocked in [Customer.Blocked::All, Customer.Blocked::Invoice] then begin
                    NoOfSalesInvErrors += 1;
                end else begin
                    if SemiarLedgerEntry."Bill-to Customer No." <> SalesHeader."Bill-to Customer No." then begin
                        Window.Update(1, "Bill-to Customer No.");
                        if (SalesHeader."No." <> '') then
                            FinalizeSalesInvoiceHeader();
                        InsertSalesInvoiceHeader();
                    end;
                    Window.UPDATE(2, "Seminar Registration No.");
                    case "Type" of
                        Type::Resource:
                            begin
                                SalesLine.Type := SalesLine.Type::Resource;
                                case "Charge Type" of
                                    "Charge Type"::Instructor:
                                        SalesLine."No." := "Instructor Resource No.";
                                    "Charge Type"::Room:
                                        SalesLine."No." := "Room Resource No.";
                                    "Charge Type"::Participant:
                                        SalesLine."No." := "Instructor Resource No.";
                                end;
                            end;
                    end;
                    SalesLine."Document Type" := SalesHeader."Document Type";
                    SalesLine."Document No." := SalesHeader."No.";
                    SalesLine."Line No." := NextLineNo;
                    SalesLine.Validate("No.");
                    Seminar.Get("Seminar No.");
                    if SemiarLedgerEntry.Description <> '' then
                        SalesLine.Description := SemiarLedgerEntry.Description
                    else
                        SalesLine.Description := Seminar.Name;


                    SalesLine."Unit Price" := "Unit Price";
                    if SalesHeader."Currency Code" <> '' then begin
                        SalesHeader.TestField("Currency Factor");
                        SalesLine."Unit Price" := Round(CurrencyExchRate.ExchangeAmtLCYToFCY(
                            WORKDATE, SalesHeader."Currency Code", SalesLine."Unit Price", SalesHeader."Currency Factor"));
                    end;
                    SalesLine.Validate(Quantity, Quantity);
                    SalesLine.Insert();
                    NextLineNo := NextLineNo + 10000;
                end;
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
        layout
        {
            area(Content)
            {
                group("Option")
                {
                    field(PostingDateReq; PostingDateReq)
                    {
                        ApplicationArea = all;
                    }
                    field(DocDateReq; DocDateReq)
                    {
                        ApplicationArea = all;
                    }
                    field(CalcInvoiceDiscount; CalcInvoiceDiscount)
                    {
                        ApplicationArea = all;
                    }
                    field(PostInvoices; PostInvoices)
                    {
                        ApplicationArea = all;
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
        if CalcInvoiceDiscount = true then
            SalesCalcDiscount.Run(SalesLine);
        SalesHeader.Get(SalesHeader."Document Type", SalesHeader."No.");
        Commit();
        Clear(SalesCalcDiscount);
        Clear(SalesPost);
        NoOfSalesInv += 1;
        if PostInvoices then
            NoOfSalesInvErrors += 1;
    end;

    local procedure InsertSalesInvoiceHeader()
    begin
        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
        SalesHeader."No." := '';
        SalesHeader.Insert(true);
        SalesHeader.Validate("Sell-to Customer No.", SemiarLedgerEntry."Bill-to Customer No.");
        if SemiarLedgerEntry."Bill-to Customer No." <> SalesHeader."Sell-to Customer No." then
            SalesHeader.Validate("Bill-to Customer No.", SemiarLedgerEntry."Bill-to Customer No.");
        SalesHeader.Validate("Posting Date", PostingDateReq);
        SalesHeader.Validate("Document Date", DocDateReq);
        SalesHeader.Validate("Currency Code", '');
        SalesHeader.Modify();
        Commit();
        NextLineNo := 10000;
    end;
}