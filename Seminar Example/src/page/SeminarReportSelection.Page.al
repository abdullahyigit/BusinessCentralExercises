page 70116 "Seminar Report Selection"
{
    PageType = Worksheet;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Seminar Report Selections";
    SaveValues = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = all;
                }
                field("Report ID"; Rec."Report ID")
                {
                    ApplicationArea = all;
                }
                field("Report Name"; Rec."Report Name")
                {
                    ApplicationArea = all;
                    DrillDown = false;
                }
            }
        }
        area(FactBoxes)
        {
            systempart(RecordLinks; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        ReportUsage: Label 'Registration';

    trigger OnOpenPage()
    begin
        SetUsageFilter();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.NewRecord();
    end;

    local procedure SetUsageFilter()
    begin
        if ReportUsage = 'Registration' then
            Rec.SetRange(Usage, Rec.Usage::Registration);
    end;

    local procedure ReportUsageOnAfterValidate()
    begin
        CurrPage.Update();
    end;
}