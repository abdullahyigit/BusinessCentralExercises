table 70104 "Seminar Comment Line"
{
    CaptionML = ENU = 'Seminar Comment Line';
    LookupPageId = "Seminar Comment List";
    DrillDownPageId = "Seminar Comment List";


    fields
    {
        field(1; "Document Type"; Option)
        {
            CaptionML = ENU = 'Document Type';
            OptionCaptionML = ENU = 'Seminar Registration, Posted Seminar Registration';
            OptionMembers = "Seminar Registration","Posted Seminar Registration";
        }
        field(2; "No."; Code[20])
        {
            CaptionML = ENU = 'No.';
        }
        field(3; "Line No."; Integer)
        {
            CaptionML = ENU = 'Line No.';
        }
        field(4; "Date"; Date)
        {
            CaptionML = ENU = 'Date';
        }
        field(5; "Code"; Code[20])
        {
            CaptionML = ENU = 'Code';
        }
        field(6; "Comment"; Text[80])
        {
            CaptionML = ENU = 'Comment';
        }
        field(7; "Document Line No."; Integer)
        {
            CaptionML = ENU = 'Document Line No.';
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.", "Document Line No.", "Line No.")
        {
            Clustered = true;
        }
    }

    PROCEDURE SetUpNewLine();
    VAR
        SeminarCommentLine: Record "Sales Comment Line";
    BEGIN
        SeminarCommentLine.SETRANGE("Document Type", "Document Type");
        SeminarCommentLine.SETRANGE("No.", "No.");
        SeminarCommentLine.SETRANGE("Document Line No.", "Document Line No.");
        SeminarCommentLine.SETRANGE(Date, WORKDATE);
        IF NOT SeminarCommentLine.FIND('-') THEN
            Date := WORKDATE;
    END;
}