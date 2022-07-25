pageextension 70000 "SourceCodeSetup" extends "Source Code Setup"
{
    layout
    {
        addlast("Cost Accounting")
        {
            group("Seminar Management")
            {
                field(Seminar; Rec.Seminar)
                {
                    ToolTip = 'Specifies the value of the Seminar field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}