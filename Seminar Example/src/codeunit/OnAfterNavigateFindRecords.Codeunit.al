codeunit 70007 "OnAfterNavigateFindRecords"
{
    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateFindRecords', '', false, false)]
    procedure PageNavigateOnAfterNavigateFindRecords(var DocumentEntry: Record "Document Entry"; DocNoFilter: Text; PostingDateFilter: Text; var NewSourceRecVar: Variant)
    var
        SeminarLedgEntry: Record "Seminar Ledger Entry";
    begin
        IF SeminarLedgEntry.READPERMISSION THEN BEGIN
            SeminarLedgEntry.RESET;
            SeminarLedgEntry.SETCURRENTKEY("Document No.", "Posting Date");
            SeminarLedgEntry.SETFILTER("Document No.", DocNoFilter);
            SeminarLedgEntry.SETFILTER("Posting Date", PostingDateFilter);

            if SeminarLedgEntry.Count = 0 then
                exit;

            DocumentEntry.Init();
            DocumentEntry."Entry No." := DocumentEntry."Entry No." + 1;
            DocumentEntry."Table ID" := DATABASE::"Seminar Ledger Entry";
            DocumentEntry."Document Type" := "Document Entry Document Type".FromInteger(0);
            DocumentEntry."Table Name" := CopyStr(SeminarLedgEntry.TableCaption, 1, MaxStrLen(DocumentEntry."Table Name"));
            DocumentEntry."No. of Records" := SeminarLedgEntry.Count;
            DocumentEntry.Insert();

        END;
    end;
}