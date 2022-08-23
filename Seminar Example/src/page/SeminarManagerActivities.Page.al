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

                actions
                {
                    action(New)
                    {
                        Caption = 'New';
                        ApplicationArea = All;
                        RunPageMode = Create;
                        RunObject = page "Seminar Registration";
                        ToolTip = 'Executes the Create action.';
                    }
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