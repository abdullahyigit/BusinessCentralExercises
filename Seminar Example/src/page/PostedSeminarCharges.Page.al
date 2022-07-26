page 70114 "Posted Seminar Charges"
{
    PageType = List;
    AutoSplitKey = true;
    SourceTable = "Posted Seminar Charge";
    Caption = 'Seminar Charges';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater("Group")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Quantitiy; Rec.Quantitiy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantitiy field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bill-to Customer No. field.';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price field.';
                }
                field("Total Price"; Rec."Total Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Price field.';
                }
                field("To Invoice"; Rec."To Invoice")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the To Invoice field.';
                }
            }
        }
    }
}