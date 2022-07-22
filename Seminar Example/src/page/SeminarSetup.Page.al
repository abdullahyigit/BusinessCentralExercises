page 70101 "Seminar Setup"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Seminar Setup";
    Caption = 'Seminar Setup';
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(Numbering)
            {
                field("Seminar Nos."; Rec."Seminar Nos.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Seminar Nos. field.';
                }
                field("Seminar Registration Nos."; Rec."Seminar Registration Nos.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Seminar Registration Nos. field.';
                }
                field("Posted Seminar Reg. Nos."; Rec."Posted Seminar Reg. Nos.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Posted Seminar Reg. Nos. field.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        IF NOT Rec.FINDFIRST THEN
            Rec.INSERT;
    end;
}