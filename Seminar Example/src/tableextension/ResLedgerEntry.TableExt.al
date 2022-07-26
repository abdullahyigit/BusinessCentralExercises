tableextension 70002 "ResLedgerEntry" extends "Res. Ledger Entry"
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