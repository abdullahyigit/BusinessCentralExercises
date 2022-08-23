page 70110 "Seminar Details FactBox"
{
    PageType = CardPart;
    SourceTable = Seminar;
    Caption = 'Seminar Details FactBox';

    layout
    {
        area(Content)
        {
            field("No."; Rec."No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the No. field.';
            }
            field(Name; Rec.Name)
            {
                ToolTip = 'Specifies the value of the Name field.';
                ApplicationArea = All;
            }
            field("Seminar Duration"; Rec."Seminar Duration")
            {
                ToolTip = 'Specifies the value of the Seminar Duration field.';
                ApplicationArea = All;
            }
            field("Maximum Participants"; Rec."Maximum Participants")
            {
                ToolTip = 'Specifies the value of the Maximum Participants field.';
                ApplicationArea = All;
            }
            field("Minimum Participants"; Rec."Minimum Participants")
            {
                ToolTip = 'Specifies the value of the Minimum Participants field.';
                ApplicationArea = All;
            }
            field("Seminar Price"; Rec."Seminar Price")
            {
                ToolTip = 'Specifies the value of the Seminar Price field.';
                ApplicationArea = All;
            }
        }
    }
}