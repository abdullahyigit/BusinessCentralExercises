table 70106 "Seminar Journal Line"
{
    Caption = 'Seminar Journal Line';
    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Seminar No."; Code[20])
        {
            TableRelation = Seminar;
            Caption = 'Seminar No.';
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            trigger OnValidate()
            begin
                VALIDATE("Document Date", "Posting Date");
            end;
        }
        field(5; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(6; "Entry Type"; Option)
        {
            OptionCaption = 'Registration,Cancelation';
            OptionMembers = "Registration","Cancelation";
            Caption = 'Entry Type';
        }
        field(7; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(8; "Description"; Text[50])
        {
            Caption = 'Description';
        }
        field(9; "Bill-to Customer No."; Code[20])
        {
            TableRelation = Customer;
            Caption = 'Bill-to Customer No.';
        }
        field(10; "Charge Type"; Option)
        {
            OptionCaption = 'Instructor,Room,Participant,Charge';
            OptionMembers = "Instructor","Room","Participant","Charge";
            Caption = 'Charge Type';
        }
        field(11; "Type"; Option)
        {
            OptionCaption = 'Resource,G/L Account';
            OptionMembers = "Resource","G/L Account";
            Caption = 'Type';
        }
        field(12; "Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Caption = 'Quantity';
        }
        field(13; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price';
        }
        field(14; "Total Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price';
        }
        field(15; "Participant Contact No."; Code[20])
        {
            TableRelation = Contact;
            Caption = 'Participant Contact No.';
        }
        field(16; "Participant Name"; Text[50])
        {
            Caption = 'Participant Name';
        }
        field(17; "Chargeable"; Boolean)
        {
            Caption = 'Chargeable';
        }
        field(18; "Room Resource No."; Code[20])
        {
            TableRelation = Resource WHERE(Type = CONST(Machine));
            Caption = 'Room Resource No.';
        }
        field(19; "Instructor Resource No."; Code[20])
        {
            TableRelation = Resource WHERE(Type = CONST(Person));
            Caption = 'Instructor Resource No.';
        }
        field(20; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(21; "Seminar Registration No."; Code[20])
        {
            Caption = 'Seminar Registration No.';
        }
        field(22; "Res. Ledger Entry No."; Integer)
        {
            TableRelation = "Res. Ledger Entry";
            Caption = 'Res. Ledger Entry No.';
        }
        field(23; "Source Type"; Option)
        {
            OptionCaption = ' ,Seminar';
            OptionMembers = " ","Seminar";
            Caption = 'Source Type';
        }
        field(24; "Source No."; Code[20])
        {
            TableRelation = IF ("Source Type" = CONST(Seminar)) "Seminar";
            Caption = 'Source No.';
        }
        field(25; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
        }
        field(26; "Source Code"; Code[10])
        {
            TableRelation = "Source Code";
            Editable = false;
            Caption = 'Source Code';
        }
        field(27; "Reason Code"; Code[10])
        {
            TableRelation = "Reason Code";
            Caption = 'Reason Code';
        }
        field(28; "Posting No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            Caption = 'Posting No. Series';
        }

        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value"."Code" where("Global Dimension No." = const(1));
            Caption = 'Shortcut Dimension 1 Code';
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value"."Code" where("Global Dimension No." = const(2));
            Caption = 'Shortcut Dimension 2 Code';
        }
        field(31; "Dimension Set ID"; Integer)
        {
            Editable = false;
            Caption = 'Dimension Set ID';
            TableRelation = "Dimension Set Entry"."Dimension Set ID";
        }
    }


    keys
    {
        key(Key1; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
        }
    }

    procedure EmptyLine(): Boolean
    begin
        EXIT(
            ("Seminar No." = '')
            AND (Quantity = 0))
    end;
}