table 70103 "Seminar Registration Header"
{
    Caption = 'Seminar Registration Header';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    SeminarSetup.GET;
                    NoSeriesMgt.TestManual(SeminarSetup."Seminar Registration Nos.");
                    "No. Series" := '';
                END;
            end;

        }
        field(2; "Starting Date"; Date)
        {
            Caption = 'Starting Date';

            trigger OnValidate()
            begin
                IF "Starting Date" <> xRec."Starting Date" THEN
                    TESTFIELD(Status, Status::Planning);
            end;

        }
        field(3; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
            TableRelation = Seminar;

            trigger OnValidate()
            begin
                IF "Seminar No." <> xRec."Seminar No." THEN BEGIN
                    SeminarRegLine.RESET;
                    SeminarRegLine.SETRANGE("Document No.", "No.");
                    SeminarRegLine.SETRANGE(Registered, TRUE);
                    IF NOT SeminarRegLine.ISEMPTY THEN
                        ERROR(
                          Text002,
                          FIELDCAPTION("Seminar No."),
                          SeminarRegLine.TABLECAPTION,
                          SeminarRegLine.FIELDCAPTION(Registered),
                          TRUE);

                    Seminar.GET("Seminar No.");
                    Seminar.TESTFIELD(Blocked, FALSE);
                    Seminar.TESTFIELD("Gen. Prod. Posting Group");
                    Seminar.TESTFIELD("Vat. Prod. Posting Group");
                    "Seminar Name" := Seminar.Name;
                    "Duration" := Seminar."Seminar Duration";
                    "Seminar Price" := Seminar."Seminar Price";
                    "Gen. Prod. Posting Group" := Seminar."Gen. Prod. Posting Group";
                    "VAT Prod. Posting Group" := Seminar."Vat. Prod. Posting Group";
                    "Minimum Participants" := Seminar."Minimum Participants";
                    "Maximum Participants" := Seminar."Maximum Participants";
                END;
            end;
        }
        field(4; "Seminar Name"; Text[50])
        {
            Caption = 'Seminar Name';


        }
        field(5; "Instructor Resource No."; Code[20])
        {
            Caption = 'Instructor No.';
            TableRelation = Resource WHERE(Type = CONST(Person));
            trigger OnValidate()
            begin
                CALCFIELDS("Instructor Name");
            end;

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
            trigger OnValidate()
            begin
                IF "Room Resource No." = '' THEN BEGIN
                    "Room Name" := '';
                    "Room Address" := '';
                    "Room Address 2" := '';
                    "Room Post Code" := '';
                    "Room City" := '';
                    "Room County" := '';
                    "Room Country/Reg. Code" := '';
                END ELSE BEGIN
                    SeminarRoom.GET("Room Resource No.");
                    "Room Name" := SeminarRoom.Name;
                    "Room Address" := SeminarRoom.Address;
                    "Room Address 2" := SeminarRoom."Address 2";
                    "Room Post Code" := SeminarRoom."Post Code";
                    "Room City" := SeminarRoom.City;
                    "Room County" := SeminarRoom.County;
                    "Room Country/Reg. Code" := SeminarRoom."Country/Region Code";

                    IF (CurrFieldNo <> 0) THEN BEGIN
                        IF (SeminarRoom."Maximum Participants" <> 0) AND
                           (SeminarRoom."Maximum Participants" < "Maximum Participants")
                        THEN BEGIN
                            IF CONFIRM(Text004, TRUE,
                                 "Maximum Participants",
                                 SeminarRoom."Maximum Participants",
                                 FIELDCAPTION("Maximum Participants"),
                                 "Maximum Participants",
                                 SeminarRoom."Maximum Participants")
                            THEN
                                "Maximum Participants" := SeminarRoom."Maximum Participants";
                        END;
                    END;
                END;
            end;
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
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode("Room City", "Room Post Code", "Room County", "Room Country/Reg. Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;


        }
        field(18; "Room City"; Text[30])
        {
            Caption = 'Room City';

            trigger OnValidate()
            begin
                PostCode.ValidateCity("Room City", "Room Post Code", "Room County", "Room Country/Reg. Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;

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
            AutoFormatType = 1;
            trigger OnValidate()
            begin
                IF ("Seminar Price" <> xRec."Seminar Price") AND
                    (Status <> Status::Canceled)
                    THEN BEGIN
                    SeminarRegLine.RESET;
                    SeminarRegLine.SETRANGE("Document No.", "No.");
                    SeminarRegLine.SETRANGE(Registered, FALSE);
                    IF SeminarRegLine.FINDSET(FALSE, FALSE) THEN
                        IF CONFIRM(Text005, FALSE,
                             FIELDCAPTION("Seminar Price"),
                             SeminarRegLine.TABLECAPTION)
                        THEN BEGIN
                            REPEAT
                                SeminarRegLine.VALIDATE("Seminar Price", "Seminar Price");
                                SeminarRegLine.MODIFY;
                            UNTIL SeminarRegLine.NEXT = 0;
                            MODIFY;
                        END;
                END;
            end;

        }
        field(24; "Comment"; Boolean)
        {
            Caption = 'Comment';
            FieldClass = FlowField;
            CalcFormula = Exist("Seminar Comment Line" WHERE("Document Type" = CONST("Seminar Registration"),
                                                                                                   "No." = FIELD("No.")));
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
        field(27; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series"."Code";
            trigger OnValidate()
            begin
                IF "Posting No. Series" <> '' THEN BEGIN
                    SeminarSetup.GET;
                    SeminarSetup.TESTFIELD("Seminar Registration Nos.");
                    SeminarSetup.TESTFIELD("Posted Seminar Reg. Nos.");
                    NoSeriesMgt.TestSeries(SeminarSetup."Posted Seminar Reg. Nos.", "Posting No. Series");
                END;
                TESTFIELD("Posting No.", '');
            end;

            trigger OnLookup()
            begin
                SeminarRegHeader := Rec;
                SeminarSetup.GET;
                SeminarSetup.TESTFIELD("Seminar Registration Nos.");
                SeminarSetup.TESTFIELD("Posted Seminar Reg. Nos.");
                IF NoSeriesMgt.LookupSeries(SeminarSetup."Posted Seminar Reg. Nos.", SeminarRegHeader."Posting No. Series")
                THEN BEGIN
                    SeminarRegHeader.VALIDATE("Posting No. Series");
                END;
                Rec := SeminarRegHeader;
            end;

        }
        field(31; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
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
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    var
        SeminarSetup: Record "Seminar Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SeminarRegLine: Record "Seminar Registration Line";

        PostCode: Record 225;
        Seminar: Record Seminar;
        SeminarCommentLine: Record "Seminar Comment Line";
        SeminarCharge: Record "Seminar Charge";
        SeminarRegHeader: Record "Seminar Registration Header";
        SeminarRoom: Record 156;
        Text001: Label 'You cannot delete the Seminar Registration, because there is at least one %1 where %2=%3.';
        Text002: Label 'You cannot change the %1, because there is at least one %2 with %3=%4.';
        Text004: Label 'This Seminar is for %1 participants. \The selected Room has a maximum of %2 participants \Do you want to change %3 for the Seminar from %4 to %5?';
        Text005: Label 'Should the new %1 be copied to all %2 that are not yet invoiced?';
        Text006: Label 'You cannot delete the Seminar Registration, because there is at least one %1.';

    //koda bakS
    trigger OnInsert()
    begin
        if "No." = '' then begin
            SeminarSetup.GET;
            SeminarSetup.TESTFIELD("Seminar Registration Nos.");
            NoSeriesMgt.InitSeries(SeminarSetup."Seminar Registration Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        InitRecord();

        IF GETFILTER("Seminar No.") <> '' THEN
            IF GETRANGEMIN("Seminar No.") = GETRANGEMAX("Seminar No.") THEN
                VALIDATE("Seminar No.", GETRANGEMIN("Seminar No."));
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin
        TESTFIELD(Status, Status::Canceled);
        BEGIN
            SeminarRegLine.RESET;
            SeminarRegLine.SETRANGE("Document No.", "No.");
            SeminarRegLine.SETRANGE(Registered, TRUE);
            IF SeminarRegLine.FIND('-') THEN
                ERROR(
                  Text001,
                  SeminarRegLine.TABLECAPTION,
                  SeminarRegLine.FIELDCAPTION(Registered),
                  TRUE);
            SeminarRegLine.SETRANGE(Registered);
            SeminarRegLine.DELETEALL(TRUE);

            SeminarCharge.RESET;
            SeminarCharge.SETRANGE("Document No.", "No.");
            IF NOT SeminarCharge.ISEMPTY THEN
                ERROR(Text006, SeminarCharge.TABLECAPTION);

            SeminarCommentLine.RESET;
            SeminarCommentLine.SETRANGE("Document Type", SeminarCommentLine."Document Type"::"Seminar Registration");
            SeminarCommentLine.SETRANGE("No.", "No.");
            SeminarCommentLine.DELETEALL;
        END;
    end;

    trigger OnRename()
    begin

    end;

    local procedure InitRecord()
    begin
        IF "Posting Date" = 0D THEN
            "Posting Date" := WORKDATE;
        "Document Date" := WORKDATE;
        SeminarSetup.GET;
        NoSeriesMgt.SetDefaultSeries("Posting No. Series", SeminarSetup."Posted Seminar Reg. Nos.");
    end;

}