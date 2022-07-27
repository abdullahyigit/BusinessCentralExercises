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

    trigger OnInsert()
    begin
        IF "No." = '' THEN begin
            SeminarSetup.GET;
            SeminarSetup.TESTFIELD("Seminar Nos.");
            NoSeriesMgt.InitSeries(SeminarSetup."Seminar Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
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
}