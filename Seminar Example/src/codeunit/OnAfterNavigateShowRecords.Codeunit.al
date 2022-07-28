codeunit 70008 "OnAfterNavigateShowRecords"
{
    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateShowRecords', '', false, false)]
    local procedure OnBeforeNavigateShowRecords(TableID: Integer; DocNoFilter: Text; PostingDateFilter: Text; ItemTrackingSearch: Boolean; var TempDocumentEntry: Record "Document Entry" temporary; SalesInvoiceHeader: Record "Sales Invoice Header"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; PurchInvHeader: Record "Purch. Inv. Header"; PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; ServiceInvoiceHeader: Record "Service Invoice Header"; ServiceCrMemoHeader: Record "Service Cr.Memo Header"; ContactType: Enum "Navigate Contact Type"; ContactNo: Code[250]; ExtDocNo: Code[250])
    var
        PostedSeminarRegHeader: Record "Posted Seminar Reg. Header";
        SeminarLedgEntry: Record "Seminar Ledger Entry";

    begin
        IF PostedSeminarRegHeader.READPERMISSION THEN BEGIN
            PostedSeminarRegHeader.RESET;
            PostedSeminarRegHeader.SETFILTER("No.", DocNoFilter);
            PostedSeminarRegHeader.SETFILTER("Posting Date", PostingDateFilter);

            if PostedSeminarRegHeader.Count = 0 then
                exit;
        end;

        IF SeminarLedgEntry.READPERMISSION THEN BEGIN
            SeminarLedgEntry.RESET;
            SeminarLedgEntry.SETCURRENTKEY("Document No.", "Posting Date");
            SeminarLedgEntry.SETFILTER("Document No.", DocNoFilter);
            SeminarLedgEntry.SETFILTER("Posting Date", PostingDateFilter);

            if SeminarLedgEntry.Count = 0 then
                exit;
        end;

        case TempDocumentEntry."Table ID" of
            DATABASE::"Posted Seminar Reg. Header":
                PAGE.RUN(0, PostedSeminarRegHeader);
            DATABASE::"Seminar Ledger Entry":
                PAGE.RUN(0, SeminarLedgEntry);
        end;
    end;
}