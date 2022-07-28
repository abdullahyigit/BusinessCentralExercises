codeunit 70006 "OnAfterNavigateFindRecordsPost"
{
    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateFindRecords', '', false, false)]
    procedure PageNavigateOnAfterNavigateFindRecords(var DocumentEntry: Record "Document Entry"; DocNoFilter: Text; PostingDateFilter: Text; var NewSourceRecVar: Variant)
    var
        PostedSeminarRegHeader: Record "Posted Seminar Reg. Header";
    begin
        IF PostedSeminarRegHeader.READPERMISSION THEN BEGIN
            PostedSeminarRegHeader.RESET;
            PostedSeminarRegHeader.SETFILTER("No.", DocNoFilter);
            PostedSeminarRegHeader.SETFILTER("Posting Date", PostingDateFilter);

            if PostedSeminarRegHeader.Count = 0 then
                exit;

            DocumentEntry.Init();
            DocumentEntry."Entry No." := DocumentEntry."Entry No." + 1;
            DocumentEntry."Table ID" := DATABASE::"Posted Seminar Reg. Header";
            DocumentEntry."Document Type" := "Document Entry Document Type".FromInteger(0);
            DocumentEntry."Table Name" := CopyStr(PostedSeminarRegHeader.TableCaption, 1, MaxStrLen(DocumentEntry."Table Name"));
            DocumentEntry."No. of Records" := PostedSeminarRegHeader.Count;
            DocumentEntry.Insert();

        END;
    end;
}