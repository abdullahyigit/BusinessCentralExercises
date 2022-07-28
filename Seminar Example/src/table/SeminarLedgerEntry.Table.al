table 70108 "Seminar Ledger Entry"
{
    Caption = 'Seminar Ledger Entry';
    DrillDownPageId = "Seminar Ledger Entries";
    LookupPageId = "Seminar Ledger Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';

        }
        field(2; "Seminar No."; Code[20])
        {
            TableRelation = Seminar;
            Caption = 'Seminar No.';

        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';

        }
        field(4; "Document Date"; Date)
        {
            Caption = 'Document Date';

        }
        field(5; "Entry Type"; Option)
        {
            OptionMembers = "Registration","Cancelation";
            OptionCaption = 'Registration,Cancelation';
            Caption = 'Entry Type';
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';

        }
        field(7; "Description"; Text[50])
        {
            Caption = 'Description';

        }
        field(8; "Bill-to Customer No."; Code[20])
        {
            TableRelation = Customer;
            Caption = 'Bill-to Customer No.';

        }
        field(9; "Charge Type"; Option)
        {
            OptionMembers = "Instructor","Room","Participant","Charge";
            OptionCaption = 'Instructor,Room,Participant,Charge';
            Caption = 'Charge Type';
        }
        field(10; "Type"; Option)
        {
            OptionMembers = "Resource","G/L Account";
            OptionCaption = 'Resource,G/L Account';
            Caption = 'Type';

        }
        field(11; "Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Caption = 'Quantity';

        }
        field(12; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price';

        }
        field(13; "Total Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price';

        }
        field(14; "Participant Contact No."; Code[20])
        {
            TableRelation = Contact;
            Caption = 'Participant Contact No.';

        }
        field(15; "Participant Name"; Text[50])
        {
            Caption = 'Participant Name';

        }
        field(16; "Chargeable"; Boolean)
        {
            InitValue = true;
            Caption = 'Chargeable';

        }
        field(17; "Room Resource No."; Code[20])
        {
            TableRelation = Resource WHERE(Type = CONST(Machine));
            Caption = 'Room Resource No.';

        }
        field(18; "Instructor Resource No."; Code[20])
        {
            TableRelation = Resource WHERE(Type = CONST(Person));
            Caption = 'Instructor Resource No.';

        }
        field(19; "Starting Date"; Date)
        {
            Caption = 'Starting Date';

        }
        field(20; "Seminar Registration No."; Code[20])
        {
            Caption = 'Seminar Registration No.';

        }
        field(21; "Res. Ledger Entry No."; Integer)
        {
            TableRelation = "Res. Ledger Entry";
            Caption = 'Res. Ledger Entry No.';

        }
        field(22; "Source Type"; Option)
        {
            OptionMembers = " ","Seminar";
            OptionCaption = ' ,Seminar';
            Caption = 'Source Type';

        }
        field(23; "Source No."; Code[20])
        {
            TableRelation = IF ("Source Type" = CONST(Seminar)) Seminar;
            Caption = 'Source No.';

        }
        field(24; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';

        }
        field(25; "Source Code"; Code[10])
        {
            TableRelation = "Source Code";
            Editable = false;
            Caption = 'Source Code';

        }
        field(26; "Reason Code"; Code[10])
        {
            TableRelation = "Reason Code";
            Caption = 'Reason Code';

        }
        field(27; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            Caption = 'No. Series';

        }
        field(28; "User ID"; Code[20])
        {
            TableRelation = User."User Name";
            DataClassification = ToBeClassified;
            Caption = 'User ID';
        }

    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Document No.", "Posting Date")
        {
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}