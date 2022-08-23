codeunit 70009 "Seminar Registration-Printed"
{
    TableNo = "Seminar Registration Header";

    trigger OnRun()
    begin
        Rec.FIND;
        Rec."No. Printed" := Rec."No. Printed" + 1;
        Rec.MODIFY;
        COMMIT;

    end;
}