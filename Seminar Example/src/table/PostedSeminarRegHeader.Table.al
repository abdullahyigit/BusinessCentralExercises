table 70109 "Posted Seminar Reg. Header"
{
    Caption = 'Posted Seminar Reg. Header';
    LookupPageId = "Posted Seminar Registration";
    DrillDownPageId = "Posted Seminar Registration";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(3; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
            TableRelation = Seminar;
        }
        field(4; "Seminar Name"; Text[50])
        {
            Caption = 'Seminar Name';
        }
        field(5; "Instructor Resource No."; Code[20])
        {
            Caption = 'Instructor No.';
            TableRelation = Resource WHERE(Type = CONST(Person));
        }
        field(6; "Instructor Name"; Text[100])
        {
            Caption = 'Instructor Name';
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource.Name WHERE("No." = FIELD("Instructor Resource No."), Type = CONST(Person)));
        }
        field(7; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(8; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(9; Status; Option)
        {
            OptionCaption = 'Planning,Registration,Closed,Canceled';
            OptionMembers = "Planning","Registration","Closed","Canceled";
            Caption = 'Status';
        }
        field(10; "Duration"; Decimal)
        {
            Caption = 'Duration';
            DecimalPlaces = 0 : 1;
        }
        field(11; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
        }
        field(12; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
        }
        field(13; "Room Resource No."; Code[20])
        {
            Caption = 'Room No.';
            TableRelation = Resource WHERE(Type = CONST(Machine));
        }
        field(14; "Room Name"; Text[30])
        {
            Caption = 'Room Name';
        }
        field(15; "Room Address"; Text[30])
        {
            Caption = 'Room Address';
        }
        field(16; "Room Address 2"; Text[30])
        {
            Caption = 'Room Address 2';
        }
        field(17; "Room Post Code"; Code[20])
        {
            Caption = 'Room Post Code';
            TableRelation = "Post Code"."Code";
        }
        field(18; "Room City"; Text[30])
        {
            Caption = 'Room City';
        }
        field(19; "Room Country/Reg. Code"; Code[10])
        {
            Caption = 'Room Country/Reg. Code';
            TableRelation = "Country/Region";
        }
        field(20; "Room County"; Text[30])
        {
            Caption = 'Room County';
        }
        field(21; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group"."Code";
        }
        field(22; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group"."Code";
        }
        field(23; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
        }
        field(24; "Comment"; Boolean)
        {
            Caption = 'Comment';
            FieldClass = FlowField;
            CalcFormula = Exist("Seminar Comment Line" WHERE("Document Type" = CONST("Posted Seminar Registration"), "No." = FIELD("No.")));
            Editable = false;
        }
        field(25; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code"."Code";
        }
        field(26; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series"."Code";
        }
        field(27; "Registration No. Series"; Code[10])
        {
            Caption = 'Registration No. Series';
        }
        field(28; "User ID"; Code[20])
        {
            Caption = 'User ID';
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
        field(29; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(30; "No. Printed"; Integer)
        {
            Editable = false;
            Caption = 'No. Printed';
        }
        field(31; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value"."Code" where("Global Dimension No." = const(1));
            Caption = 'Shortcut Dimension 1 Code';
        }
        field(32; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value"."Code" where("Global Dimension No." = const(2));
            Caption = 'Shortcut Dimension 2 Code';
        }
        field(33; "Dimension Set ID"; Integer)
        {
            Editable = false;
            Caption = 'Dimension Set ID';
            TableRelation = "Dimension Set Entry"."Dimension Set ID";
            trigger OnLookup()
            begin
                ShowDimensions();
            end;
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Room Resource No.")
        {
            SumIndexFields = Duration;
        }
    }

    var
        DimMgt: Codeunit DimensionManagement;

    procedure ShowDimensions()
    begin
        DimMgt.ShowDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', TableCaption, "No."));
    end;
}