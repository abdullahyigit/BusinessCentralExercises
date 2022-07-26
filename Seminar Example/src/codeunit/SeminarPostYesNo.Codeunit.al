codeunit 70005 "Seminar-Post (Yes/No)"
{
    TableNo = "Seminar Registration Header";

    trigger OnRun()
    begin
        SeminarRegHeader.COPY(Rec);
        Code;
        Rec := SeminarRegHeader;
    end;

    var
        SeminarRegHeader: Record "Seminar Registration Header";
        SeminarPost: Codeunit "Seminar-Post";
        Text001: Label 'Do you want to post the Registration?';

    LOCAL PROCEDURE Code();
    BEGIN
        IF NOT CONFIRM(Text001, FALSE) THEN
            EXIT;
        SeminarPost.RUN(SeminarRegHeader);
        COMMIT;
    END;
}