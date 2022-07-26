pageextension 70403 "ResourceLedgerEntries" extends "Resource Ledger Entries"
{
    layout
    {
        addafter("Job No.")
        {
            field("Seminar No."; Rec."Seminar No.")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Seminar No. field.';
            }
            field("Seminar Registration No."; Rec."Seminar Registration No.")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Seminar Registration No. field.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}