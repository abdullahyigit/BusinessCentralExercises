table 70107 "Seminar Register"
{
    Caption = 'Seminar Register';
    LookupPageId = "Seminar Registers";
    DrillDownPageId = "Seminar Registers";
    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "From Entry No."; Integer)
        {
            Caption = 'From Entry No.';
            TableRelation = "Seminar Ledger Entry";
        }
        field(3; "To Entry No."; Integer)
        {
            Caption = 'To Entry No.';
            TableRelation = "Seminar Ledger Entry";
        }
        field(4; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
        }
        field(5; "Source Code"; Code[10])
        {
            TableRelation = "Source Code";
            Caption = 'Source Code';
        }
        field(6; "User ID"; Code[20])
        {
            TableRelation = User."User Name";
            Caption = 'User ID';
        }
        field(7; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Creation Date")
        { }
        key(Key3; "Source Code", "Creation Date")
        { }
    }
}