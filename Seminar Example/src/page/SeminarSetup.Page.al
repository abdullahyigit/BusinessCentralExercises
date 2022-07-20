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
                }
                field("Seminar Registration Nos."; Rec."Seminar Registration Nos.")
                {
                    ApplicationArea = all;
                }
                field("Posted Seminar Reg. Nos."; Rec."Posted Seminar Reg. Nos.")
                {
                    ApplicationArea = all;
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