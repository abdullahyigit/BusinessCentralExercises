page 70118 "My Seminars"
{
    PageType = ListPart;
    SourceTable = "My Seminar";
    UsageCategory = Administration;
    ApplicationArea = all;
    Caption = 'My Seminars';


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Seminar No."; Rec."Seminar No.")
                {
                    ApplicationArea = All;
                    Caption = 'Seminar No.';
                    ToolTip = 'Specifies the value of the Seminar No. field.';
                    trigger OnValidate()
                    begin
                        GetSeminar();
                    end;
                }
                field(Control4; Seminar.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Control5; Seminar."Seminar Duration")
                {
                    ApplicationArea = All;
                    Caption = 'Duration';
                    ToolTip = 'Specifies the value of the Duration field.';
                }
                field(Control6; Seminar."Seminar Price")
                {
                    ApplicationArea = All;
                    Caption = 'Price';
                    ToolTip = 'Specifies the value of the Price field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Edit Seminar")
            {
                ApplicationArea = All;
                Image = Edit;
                ShortcutKey = 'Return';
                ToolTip = 'Executes the Edit Seminar action.';
                trigger OnAction()
                begin
                    OpenSeminarCard();
                end;
            }
        }
    }

    var
        Seminar: Record Seminar;


    trigger OnOpenPage()
    begin
        Rec.SETRANGE("User ID", USERID);
    end;

    trigger OnAfterGetRecord()
    begin
        GetSeminar();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Clear(Seminar);
    end;


    local procedure GetSeminar()
    begin
        Clear(Seminar);
        if Seminar.Get(Rec."Seminar No.") then
            if not Seminar.Get(Rec."Seminar No.") then
                Message('ERRER ABICIM');
    end;

    local procedure OpenSeminarCard()
    begin
        if Seminar.Get(Rec."Seminar No.") then
            Page.Run(Page::"Seminar Card", Seminar);
    end;
}