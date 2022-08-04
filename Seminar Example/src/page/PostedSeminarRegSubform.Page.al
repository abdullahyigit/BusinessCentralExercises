page 70112 "Posted Seminar Reg. Subform"
{
    PageType = ListPart;
    SourceTable = "Posted Seminar Reg. Line";
    DelayedInsert = true;
    Caption = 'Posted Lines';
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater("Group")
            {
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bill-to Customer No. field.';
                }
                field("Participant Contact No."; Rec."Participant Contact No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Participant Contact No. field.';
                }
                field("Participant Name"; Rec."Participant Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Participant Name field.';
                }
                field(Participated; Rec.Participated)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Participated field.';
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Registration Date field.';
                }
                field("Confirmation Date"; Rec."Confirmation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Confirmation Date field.';
                }
                field("To Invoice"; Rec."To Invoice")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the To Invoice field.';
                }
                field(Registered; Rec.Registered)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Registered field.';
                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seminar Price field.';
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line Discount field.';
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line Discount Amount field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Dimensions")
            {
                ApplicationArea = all;
                Image = Dimensions;
                Caption = 'Dimensions';
                trigger OnAction()
                begin
                    Rec.ShowDimensions();
                end;
            }
        }
    }
}