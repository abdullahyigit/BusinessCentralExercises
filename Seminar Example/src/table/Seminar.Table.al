table 70101 "Seminar"
{
    Caption = 'Seminar';
    LookupPageId = "Seminar List";
    DrillDownPageId = "Seminar List";
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    SeminarSetup.GET;
                    NoSeriesMgt.TestManual(SeminarSetup."Seminar Nos.");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; "Name"; Text[50])
        {
            Caption = 'Name';
            trigger OnValidate()
            begin
                if ("Search Name" = UPPERCASE(xRec.Name)) OR ("Search Name" = '') THEN BEGIN
                    "Search Name" := Name;
                END;
            end;
        }
        field(3; "Seminar Duration"; Decimal)
        {
            DecimalPlaces = 0 : 1;
            Caption = 'Seminar Duration';
        }
        field(4; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
        }
        field(5; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
        }
        field(6; "Search Name"; Code[50])
        {
            Caption = 'Search';
        }
        field(7; "Blocked"; Boolean)
        {
            Caption = 'Blocked';
        }
        field(8; "Last Date Modified"; Date)
        {
            Editable = false;
            Caption = 'Last Date Modified';
        }
        field(9; "Comment"; Boolean)
        {
            Editable = false;
            Caption = 'Comment';
            FieldClass = FlowField;
            CalcFormula = exist("Comment Line"
            where("Table Name" = const(Seminar),
            "No." = field("No.")
            ));
        }
        field(10; "Seminar Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Seminar Price';
        }
        field(11; "Gen. Prod. Posting Group"; Code[10])
        {
            TableRelation = "Gen. Product Posting Group";
            Caption = 'Gen. Prod. Posting Group';
            trigger OnValidate()
            begin
                IF xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" THEN BEGIN
                    IF
                   GenProdPostingGroup.ValidateVatProdPostingGroup(GenProdPostingGroup, "Vat. Prod. Posting Group") THEN BEGIN
                        VALIDATE("Vat. Prod. Posting Group", GenProdPostingGroup."Def. VAT Prod. Posting Group");
                    END;
                END;
            end;
        }
        field(12; "Vat. Prod. Posting Group"; Code[10])
        {
            TableRelation = "VAT Product Posting Group";
            Caption = 'Vat. Prod. Posting Group';
        }
        field(13; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            Caption = 'No. Series';
        }
        field(14; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(15; "Charge Type Filter"; Option)
        {
            OptionCaption = 'Instructor, Room, Participant, Charge';
            OptionMembers = Instructor,Room,Participant,Charge;
            FieldClass = FlowFilter;
        }
        field(16; "Total Price"; Decimal)
        {
            Editable = false;
            AutoFormatType = 1;
            FieldClass = FlowField;
            CalcFormula = sum("Seminar Ledger Entry"."Total Price"
            where("Seminar No." = field("No."),
            "Posting Date" = field("Date Filter"),
            "Charge Type" = field("Charge Type Filter")
            ));
        }
        field(17; "Total Price (Chargeable)"; Decimal)
        {
            Editable = false;
            AutoFormatType = 1;
            FieldClass = FlowField;
            CalcFormula = sum("Seminar Ledger Entry"."Total Price"
            where("Seminar No." = field("No."),
            "Posting Date" = field("Date Filter"),
            "Charge Type" = field("Charge Type Filter"),
            Chargeable = const(true)
            ));

        }
        field(18; "Total Price (Not Chargeable)"; Decimal)
        {
            Editable = false;
            AutoFormatType = 1;
            FieldClass = FlowField;
            CalcFormula = sum("Seminar Ledger Entry"."Total Price"
            where("Seminar No." = field("No."),
            "Posting Date" = field("Date Filter"),
            "Charge Type" = field("Charge Type Filter"),
            Chargeable = const(false)
            ));
        }
        field(19; "Global Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value"."Code" where("Global Dimension No." = const(1));
            CaptionClass = '1,1,1';
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(20; "Global Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value"."Code" where("Global Dimension No." = const(2));
            CaptionClass = '1,1,2';
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Search Name")
        {
        }
    }

    var
        SeminarSetup: Record "Seminar Setup";
        CommentLine: Record "Comment Line";
        GenProdPostingGroup: Record "Gen. Product Posting Group";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Seminar: Record Seminar;
        DimMgt: Codeunit DimensionManagement;

    trigger OnInsert()
    begin
        IF "No." = '' THEN begin
            SeminarSetup.GET;
            SeminarSetup.TESTFIELD("Seminar Nos.");
            NoSeriesMgt.InitSeries(SeminarSetup."Seminar Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        DimMgt.UpdateDefaultDim(DATABASE::Seminar, "No.", "Global Dimension 1 Code", "Global Dimension 2 Code");
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := TODAY;
    end;

    trigger OnDelete()
    begin
        CommentLine.RESET;
        CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::Seminar);
        CommentLine.SETRANGE("No.", "No.");
        CommentLine.DELETEALL;
        DimMgt.DeleteDefaultDim(DATABASE::Seminar, "No.");
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := TODAY;
    end;


    procedure AssistEdit(): Boolean
    begin
        Seminar := Rec;
        SeminarSetup.GET;
        SeminarSetup.TESTFIELD("Seminar Nos.");
        IF NoSeriesMgt.SelectSeries(SeminarSetup."Seminar Nos.", xRec."No. Series", Seminar."No. Series") THEN BEGIN
            NoSeriesMgt.SetSeries(Seminar."No.");
            Rec := Seminar;
            EXIT(TRUE);
        END;

    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::Customer, "No.", FieldNumber, ShortcutDimCode);
        Modify();
    end;
}