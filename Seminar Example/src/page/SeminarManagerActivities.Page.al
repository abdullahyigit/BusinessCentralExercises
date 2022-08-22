page 70117 "Seminar Manager Activities"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Seminar Cue";

    layout
    {
        area(Content)
        {
            cuegroup("Registrations")
            {
                field(Planned; Rec.Planned)
                {
                    DrillDownPageId = "Seminar Registration List";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Planned field.';
                }
                field(Registered; Rec.Registered)
                {
                    DrillDownPageId = "Seminar Registration List";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Registered field.';
                }
            }
            cuegroup("For Posting")
            {
                field(Closed; Rec.Closed)
                {
                    DrillDownPageId = "Seminar Registration List";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Closed field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Create)
            {
                Caption = 'Create';
                ApplicationArea = All;
                RunPageMode = Create;
                RunObject = page "Seminar Registration";
                ToolTip = 'Executes the Create action.';
            }
        }
    }

    var
        myInt: Integer;

    trigger OnOpenPage()
    begin
        Rec.RESET;
        IF NOT Rec.GET THEN BEGIN
            Rec.INIT;
            Rec.INSERT;
        END;
    end;
}