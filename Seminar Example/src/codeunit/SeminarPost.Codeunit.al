codeunit 70004 "Seminar-Post"
{
    TableNo = "Seminar Registration Header";

    trigger OnRun()
    begin
        CLEARALL;
        SeminarRegHeader := Rec;

        SeminarRegHeader.TESTFIELD("Posting Date");
        SeminarRegHeader.TESTFIELD("Document Date");
        SeminarRegHeader.TESTFIELD("Seminar No.");
        SeminarRegHeader.TESTFIELD("Duration");
        SeminarRegHeader.TESTFIELD("Instructor Resource No.");
        SeminarRegHeader.TESTFIELD("Room Resource No.");
        SeminarRegHeader.TESTFIELD(Status, SeminarRegHeader.Status::Closed);

        CheckDim();

        SeminarRegLine.RESET;
        SeminarRegLine.SETRANGE("Document No.", SeminarRegHeader."No.");

        IF SeminarRegLine.ISEMPTY THEN
            ERROR(Text001);
        Window.OPEN(
        '#1#################################\\' +
        Text002);
        Window.UPDATE(1, STRSUBSTNO('%1 %2', Text003, SeminarRegHeader."No."));
        IF SeminarRegHeader."Posting No." = '' THEN BEGIN
            SeminarRegHeader.TESTFIELD("Posting No. Series");
            SeminarRegHeader."Posting No." := NoSeriesMgt.GetNextNo(SeminarRegHeader."Posting No. Series", SeminarRegHeader."Posting Date", TRUE);
            SeminarRegHeader.MODIFY;
            COMMIT;
        END;
        SeminarRegLine.LOCKTABLE;
        SourceCodeSetup.GET;
        SourceCode := SourceCodeSetup.Seminar;
        PstdSeminarRegHeader.INIT;
        PstdSeminarRegHeader.TRANSFERFIELDS(SeminarRegHeader);
        PstdSeminarRegHeader."No." := SeminarRegHeader."Posting No.";
        PstdSeminarRegHeader."No. Series" := SeminarRegHeader."Posting No. Series";
        PstdSeminarRegHeader."Source Code" := SourceCode;
        PstdSeminarRegHeader."User ID" := USERID;
        PstdSeminarRegHeader.INSERT;

        Window.UPDATE(1, STRSUBSTNO(Text004, SeminarRegHeader."No.",
         PstdSeminarRegHeader."No."));

        CopyCommentLines(
        SeminarCommentLine."Document Type"::"Seminar Registration",
        SeminarCommentLine."Document Type"::"Posted Seminar Registration",
        SeminarRegHeader."No.", PstdSeminarRegHeader."No.");
        CopyCharges(SeminarRegHeader."No.", PstdSeminarRegHeader."No.");

        LineCount := 0;
        SeminarRegLine.RESET;
        SeminarRegLine.SETRANGE("Document No.", SeminarRegHeader."No.");

        IF SeminarRegLine.FINDSET THEN BEGIN
            REPEAT
                LineCount := LineCount + 1;
                Window.UPDATE(2, LineCount);
                SeminarRegLine.TESTFIELD("Bill-to Customer No.");
                SeminarRegLine.TESTFIELD("Participant Contact No.");
                IF NOT SeminarRegLine."To Invoice" THEN BEGIN
                    SeminarRegLine."Seminar Price" := 0;
                    SeminarRegLine."Line Discount %" := 0;
                    SeminarRegLine."Line Discount Amount" := 0;
                    SeminarRegLine.Amount := 0;
                END;
                // Post seminar entry
                PostSeminarJnlLine(2); // Participant
                // Insert posted seminar registration line
                PstdSeminarRegLine.INIT;
                PstdSeminarRegLine.TRANSFERFIELDS(SeminarRegLine);
                PstdSeminarRegLine."Document No." := PstdSeminarRegHeader."No.";
                PstdSeminarRegLine.INSERT;
            UNTIL SeminarRegLine.NEXT = 0;
            // Post charges to seminar ledger
            PostCharges;
            // Post instructor to seminar ledger
            PostSeminarJnlLine(0); // Instructor
            // Post seminar room to seminar ledger
            PostSeminarJnlLine(1); // Room
        END;

        SeminarRegHeader.DELETE;
        SeminarRegLine.DELETEALL;
        SeminarCommentLine.SETRANGE("Document Type",
        SeminarCommentLine."Document Type"::"Seminar Registration");
        SeminarCommentLine.SETRANGE("No.", SeminarRegHeader."No.");
        SeminarCommentLine.DELETEALL;
        SeminarCharge.SETRANGE(Description);
        SeminarCharge.DELETEALL;
        Rec := SeminarRegHeader;

    end;

    var
        Text001: Label 'There is no participant to post.';
        Text002: Label 'Posting lines              #2######\';
        Text003: Label 'Registration';
        Text004: Label 'Registration %1  -> Posted Reg. %2';
        Text005: Label 'The combination of dimensions used in %1 is blocked. %2';
        Text006: Label 'The combination of dimensions used in %1,  line no. %2 is blocked. %3';
        Text007: Label 'The dimensions used in %1 are invalid. %2';
        Text008: Label 'The dimensions used in %1, line no. %2 are invalid. %3';
        ResJnlPostLine: Codeunit "Res. Jnl.-Post Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimMgt: Codeunit DimensionManagement;
        SeminarJnlPostLine: Codeunit "Seminar Jnl.-Post Line";
        SeminarRegHeader: Record "Seminar Registration Header";
        SeminarRegLine: Record "Seminar Registration Line";
        PstdSeminarRegHeader: Record "Posted Seminar Reg. Header";
        PstdSeminarRegLine: Record "Posted Seminar Reg. Line";
        SeminarCommentLine: Record "Seminar Comment Line";
        SeminarCommentLine2: Record "Seminar Comment Line";
        SeminarCharge: Record "Seminar Charge";
        PstdSeminarCharge: Record "Posted Seminar Charge";
        Room: Record Resource;
        Instructor: Record Resource;
        Customer: Record Customer;
        ResLedgEntry: Record "Res. Ledger Entry";
        SeminarJnlLine: Record "Seminar Journal Line";
        SourceCodeSetup: Record "Source Code Setup";
        ResJnlLine: Record "Res. Journal Line";
        Window: Dialog;
        SourceCode: Code[10];
        LineCount: Integer;

    LOCAL PROCEDURE CopyCommentLines(FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20]);
    BEGIN
        SeminarCommentLine.RESET;
        SeminarCommentLine.SETRANGE("Document Type", FromDocumentType);
        SeminarCommentLine.SETRANGE("No.", FromNumber);
        IF SeminarCommentLine.FINDSET(FALSE, FALSE) THEN BEGIN
            REPEAT
                SeminarCommentLine2 := SeminarCommentLine;
                SeminarCommentLine2."Document Type" := ToDocumentType;
                SeminarCommentLine2."No." := ToNumber;
                SeminarCommentLine2.INSERT;
            UNTIL SeminarCommentLine.NEXT = 0;
        END;
    END;

    LOCAL PROCEDURE CopyCharges(FromNumber: Code[20]; ToNumber: Code[20]);
    BEGIN
        SeminarCharge.RESET;
        SeminarCharge.SETRANGE("Document No.", FromNumber);
        IF SeminarCharge.FINDSET(FALSE, FALSE) THEN BEGIN
            REPEAT
                PstdSeminarCharge.TRANSFERFIELDS(SeminarCharge);
                PstdSeminarCharge."Document No." := ToNumber;
                PstdSeminarCharge.INSERT;
            UNTIL SeminarCharge.NEXT = 0;
        END;
    END;

    LOCAL PROCEDURE PostResJnlLine(Resource: Record Resource): Integer;
    BEGIN
        Resource.TESTFIELD("Quantity Per Day");
        ResJnlLine.INIT;
        ResJnlLine."Entry Type" := ResJnlLine."Entry Type"::Usage;
        ResJnlLine."Document No." := PstdSeminarRegHeader."No.";
        ResJnlLine."Resource No." := Resource."No.";
        ResJnlLine."Posting Date" := SeminarRegHeader."Posting Date";
        ResJnlLine."Reason Code" := SeminarRegHeader."Reason Code";
        ResJnlLine.Description := SeminarRegHeader."Seminar Name";
        ResJnlLine."Gen. Prod. Posting Group" := SeminarRegHeader."Gen. Prod. Posting Group";
        ResJnlLine."Posting No. Series" := SeminarRegHeader."Posting No. Series";
        ResJnlLine."Source Code" := SourceCode;
        ResJnlLine."Resource No." := Resource."No.";
        ResJnlLine."Unit of Measure Code" := Resource."Base Unit of Measure";
        ResJnlLine."Unit Cost" := Resource."Unit Cost";
        ResJnlLine."Qty. per Unit of Measure" := 1;
        ResJnlLine.Quantity := SeminarRegHeader."Duration" * Resource."Quantity Per Day";
        ResJnlLine."Total Cost" := ResJnlLine."Unit Cost" * ResJnlLine.Quantity;
        ResJnlLine."Seminar No." := SeminarRegHeader."Seminar No.";
        ResJnlLine."Seminar Registration No." := PstdSeminarRegHeader."No.";
        ResJnlLine."Shortcut Dimension 1 Code" := SeminarRegHeader."Shortcut Dimension 1 Code";
        ResJnlLine."Shortcut Dimension 2 Code" := SeminarRegHeader."Shortcut Dimension 2 Code";
        ResJnlLine."Dimension Set ID" := SeminarRegHeader."Dimension Set ID";
        ResJnlPostLine.RunWithCheck(ResJnlLine);
        ResLedgEntry.FINDLAST;
        EXIT(ResLedgEntry."Entry No.");
    END;

    LOCAL PROCEDURE PostSeminarJnlLine(ChargeType: Option Instructor,Room,Participant,Charge);
    BEGIN

        SeminarJnlLine.INIT;
        SeminarJnlLine."Seminar No." := SeminarRegHeader."Seminar No.";
        SeminarJnlLine."Posting Date" := SeminarRegHeader."Posting Date";
        SeminarJnlLine."Document Date" := SeminarRegHeader."Document Date";
        SeminarJnlLine."Document No." := PstdSeminarRegHeader."No.";
        SeminarJnlLine."Charge Type" := ChargeType;
        SeminarJnlLine."Instructor Resource No." := SeminarRegHeader."Instructor Resource No.";
        SeminarJnlLine."Starting Date" := SeminarRegHeader."Starting Date";
        SeminarJnlLine."Seminar Registration No." := PstdSeminarRegHeader."No.";
        SeminarJnlLine."Room Resource No." := SeminarRegHeader."Room Resource No.";
        SeminarJnlLine."Source Type" := SeminarJnlLine."Source Type"::Seminar;
        SeminarJnlLine."Source No." := SeminarRegHeader."Seminar No.";
        SeminarJnlLine."Source Code" := SourceCode;
        SeminarJnlLine."Reason Code" := SeminarRegHeader."Reason Code";
        SeminarJnlLine."Posting No. Series" := SeminarRegHeader."Posting No. Series";
        SeminarJnlLine."Shortcut Dimension 1 Code" := SeminarRegHeader."Shortcut Dimension 1 Code";
        SeminarJnlLine."Shortcut Dimension 2 Code" := SeminarRegHeader."Shortcut Dimension 2 Code";
        SeminarJnlLine."Dimension Set ID" := SeminarRegHeader."Dimension Set ID";

        CASE ChargeType OF
            ChargeType::Instructor:
                BEGIN
                    Instructor.GET(SeminarRegHeader."Instructor Resource No.");
                    SeminarJnlLine.Description := Instructor.Name;
                    SeminarJnlLine."Type" := SeminarJnlLine."Type"::Resource;
                    SeminarJnlLine.Chargeable := FALSE;
                    SeminarJnlLine.Quantity := SeminarRegHeader."Duration";
                    SeminarJnlLine."Res. Ledger Entry No." := PostResJnlLine(Instructor);
                END;
            ChargeType::Room:
                BEGIN
                    Room.GET(SeminarRegHeader."Room Resource No.");
                    SeminarJnlLine.Description := Room.Name;
                    SeminarJnlLine."Type" := SeminarJnlLine."Type"::Resource;
                    SeminarJnlLine.Chargeable := FALSE;
                    SeminarJnlLine.Quantity := SeminarRegHeader."Duration";
                    // Post to resource ledger
                    SeminarJnlLine."Res. Ledger Entry No." := PostResJnlLine(Room);
                END;
            ChargeType::Participant:
                BEGIN
                    SeminarRegLine.CalcFields("Participant Name");
                    SeminarJnlLine."Bill-to Customer No." := SeminarRegLine."Bill-to Customer No.";
                    SeminarJnlLine."Participant Contact No." := SeminarRegLine."Participant Contact No.";
                    SeminarJnlLine."Participant Name" := SeminarRegLine."Participant Name";
                    SeminarJnlLine.Description := SeminarRegLine."Participant Name";
                    SeminarJnlLine."Type" := SeminarJnlLine."Type"::Resource;
                    SeminarJnlLine.Chargeable := SeminarRegLine."To Invoice";
                    SeminarJnlLine.Quantity := 1;
                    SeminarJnlLine."Unit Price" := SeminarRegLine.Amount;
                    SeminarJnlLine."Total Price" := SeminarRegLine.Amount;
                END;
            ChargeType::Charge:
                BEGIN
                    SeminarJnlLine.Description := SeminarCharge.Description;
                    SeminarJnlLine."Bill-to Customer No." := SeminarCharge."Bill-to Customer No.";
                    SeminarJnlLine.Type := SeminarCharge.Type;
                    SeminarJnlLine.Quantity := SeminarCharge.Quantity;
                    SeminarJnlLine."Unit Price" := SeminarCharge."Unit Price";
                    SeminarJnlLine."Total Price" := SeminarCharge."Total Price";
                    SeminarJnlLine.Chargeable := SeminarCharge."To Invoice";
                END;
        END;
        SeminarJnlPostLine.RunWithCheck(SeminarJnlLine);
    END;

    LOCAL PROCEDURE PostCharges();
    BEGIN
        SeminarCharge.RESET;
        SeminarCharge.SETRANGE("Document No.", SeminarRegHeader."No.");
        IF SeminarCharge.FINDSET(FALSE, FALSE) THEN BEGIN
            REPEAT
                PostSeminarJnlLine(3); // Charge
            UNTIL SeminarCharge.NEXT = 0;
        END;
    END;

    LOCAL PROCEDURE CheckDim();
    VAR
        SeminarRegLine: Record "Seminar Registration Line";
    BEGIN
        SeminarRegLine."Line No." := 0;
        CheckDimValuePosting(SeminarRegLine);
        CheckDimComb(SeminarRegLine);

        SeminarRegLine.SETRANGE("Document No.", SeminarRegHeader."No.");
        IF SeminarRegLine.FINDSET THEN
            REPEAT
                CheckDimComb(SeminarRegLine);
                CheckDimValuePosting(SeminarRegLine);
            UNTIL SeminarRegLine.NEXT = 0;
    END;

    LOCAL PROCEDURE CheckDimComb(SeminarRegLine: Record "Seminar Registration Line");
    BEGIN
        IF SeminarRegLine."Line No." = 0 THEN
            IF NOT DimMgt.CheckDimIDComb(SeminarRegHeader."Dimension Set ID") THEN
                ERROR(
                  Text005,
                  SeminarRegHeader."No.", DimMgt.GetDimCombErr);

        IF SeminarRegLine."Line No." <> 0 THEN
            IF NOT DimMgt.CheckDimIDComb(SeminarRegLine."Dimension Set ID") THEN
                ERROR(
                  Text006,
                  SeminarRegHeader."No.", SeminarRegLine."Line No.", DimMgt.GetDimCombErr);
    END;

    LOCAL PROCEDURE CheckDimValuePosting(VAR SeminarRegLine: Record "Seminar Registration Line");
    VAR
        TableIDArr: ARRAY[10] OF Integer;
        NumberArr: ARRAY[10] OF Code[20];

    BEGIN
        IF SeminarRegLine."Line No." = 0 THEN BEGIN
            TableIDArr[1] := DATABASE::Seminar;
            NumberArr[1] := SeminarRegHeader."Seminar No.";
            TableIDArr[2] := DATABASE::Resource;
            NumberArr[2] := SeminarRegHeader."Instructor Resource No.";
            TableIDArr[3] := DATABASE::Resource;
            NumberArr[3] := SeminarRegHeader."Room Resource No.";
            IF NOT DimMgt.CheckDimValuePosting(
              TableIDArr,
              NumberArr,
              SeminarRegHeader."Dimension Set ID")
            THEN
                ERROR(
                  Text007,
                  SeminarRegHeader."No.",
                  DimMgt.GetDimValuePostingErr);
        END ELSE BEGIN
            TableIDArr[1] := DATABASE::Customer;
            NumberArr[1] := SeminarRegLine."Bill-to Customer No.";
            IF NOT DimMgt.CheckDimValuePosting(
              TableIDArr,
              NumberArr,
              SeminarRegLine."Dimension Set ID")
            THEN
                ERROR(
                  Text008,
                  SeminarRegHeader."No.", SeminarRegLine."Line No.", DimMgt.GetDimValuePostingErr);
        END;
    END;
}