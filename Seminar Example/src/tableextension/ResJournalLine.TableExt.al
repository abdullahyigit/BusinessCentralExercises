tableextension 70003 "ResJournalLine" extends "Res. Journal Line"
{
    fields
    {
        field(50; "Seminar No."; Code[20])
        {
            TableRelation = Seminar;
            Caption = 'Seminar No.';
        }
        field(51; "Seminar Registration No."; Code[20])
        {
            TableRelation = "Posted Seminar Reg. Header";
            Caption = 'Seminar Registration No.';
        }
    }
}