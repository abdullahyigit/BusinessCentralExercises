table 70100 "Seminar Setup"
{
    Caption = 'Seminar Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Seminar Nos."; Code[10])
        {
            TableRelation = "No. Series";
            Caption = 'Seminar Nos.';
        }
        field(3; "Seminar Registration Nos."; Code[10])
        {
            TableRelation = "No. Series";
            Caption = 'Seminar Registration Nos.';
        }
        field(4; "Posted Seminar Reg. Nos."; Code[10])
        {
            TableRelation = "No. Series";
            Caption = 'Posted Seminar Reg. Nos.';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
}