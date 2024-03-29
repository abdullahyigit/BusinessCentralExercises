page 70108 "Seminar Ledger Entries"
{
    PageType = List;
    UsageCategory = History;
    SourceTable = "Seminar Ledger Entry";
    Editable = false;
    Caption = 'Seminar Ledger Entries';
    ApplicationArea = all;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Document Date field.';
                    ApplicationArea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ToolTip = 'Specifies the value of the Entry Type field.';
                    ApplicationArea = All;
                }
                field("Seminar No."; Rec."Seminar No.")
                {
                    ToolTip = 'Specifies the value of the Seminar No. field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Bill-to Customer No. field.';
                    ApplicationArea = All;
                }
                field("Charge Type"; Rec."Charge Type")
                {
                    ToolTip = 'Specifies the value of the Charge Type field.';
                    ApplicationArea = All;
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the value of the Unit Price field.';
                    ApplicationArea = All;
                }
                field("Total Price"; Rec."Total Price")
                {
                    ToolTip = 'Specifies the value of the Total Price field.';
                    ApplicationArea = All;
                }
                field(Chargeable; Rec.Chargeable)
                {
                    ToolTip = 'Specifies the value of the Chargeable field.';
                    ApplicationArea = All;
                }
                field("Participant Contact No."; Rec."Participant Contact No.")
                {
                    ToolTip = 'Specifies the value of the Participant Contact No. field.';
                    ApplicationArea = All;
                }
                field("Participant Name"; Rec."Participant Name")
                {
                    ToolTip = 'Specifies the value of the Participant Name field.';
                    ApplicationArea = All;
                }
                field("Instructor Resource No."; Rec."Instructor Resource No.")
                {
                    ToolTip = 'Specifies the value of the Instructor Resource No. field.';
                    ApplicationArea = All;
                }
                field("Room Resource No."; Rec."Room Resource No.")
                {
                    ToolTip = 'Specifies the value of the Room Resource No. field.';
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the value of the Starting Date field.';
                    ApplicationArea = All;
                }
                field("Seminar Registration No."; Rec."Seminar Registration No.")
                {
                    ToolTip = 'Specifies the value of the Seminar Registration No. field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                    ApplicationArea = All;
                }
            }
        }

        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;

            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("&Navigate")
            {
                ApplicationArea = all;
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Navigate action.';
                trigger OnAction()
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                    Navigate.RUN;
                end;
            }

            action("Dimensions")
            {
                ApplicationArea = all;
                Image = Dimensions;
                Caption = 'Dimensions';
                ToolTip = 'Executes the Dimensions action.';
                trigger OnAction()
                begin
                    Rec.ShowDimensions();
                end;
            }
        }

    }

    var
        Navigate: Page Navigate;
}