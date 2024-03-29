page 70107 "Seminar Registration List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Seminar Registration Header";
    Editable = false;
    CardPageId = "Seminar Registration";
    Caption = 'Seminar Registration List';

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
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Starting Date field.';
                }
                field("Seminar No."; Rec."Seminar No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seminar No. field.';
                }
                field("Seminar Name"; Rec."Seminar Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seminar Name field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Duration"; Rec."Duration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Duration field.';
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum Participants field.';
                }
                field("Room Resource No."; Rec."Room Resource No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Room No. field.';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(RecordLinks; Links)
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
        area(Navigation)
        {
            action("Comments")
            {
                ApplicationArea = All;
                RunObject = page "Seminar Comment Sheet";
                RunPageView = WHERE("Document Type" = const(0));
                RunPageLink = "No." = field("No.");
                Image = Comment;
                ToolTip = 'Executes the Comments action.';
            }
            action("Charges")
            {
                ApplicationArea = All;
                RunObject = page "Seminar Charges";
                RunPageLink = "No." = field("No.");
                Image = Costs;
                ToolTip = 'Executes the Charges action.';
            }

            action(Dimensions)
            {
                Image = Dimensions;
                ApplicationArea = all;
                ShortcutKey = "Shift + Ctrl + D";
                ToolTip = 'Executes the Dimensions action.';
                trigger OnAction()
                begin
                    Rec.ShowDocDim;
                end;
            }
        }
        area(Processing)
        {
            group("P&osting")
            {
                action("P&ost")
                {
                    ApplicationArea = all;
                    Image = PostDocument;
                    Caption = 'P&ost';
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortcutKey = F9;
                    RunObject = codeunit "Seminar-Post (Yes/No)";
                    ToolTip = 'Executes the P&ost action.';
                }
                action("Show My Report")
                {
                    ApplicationArea = all;
                    Image = PostDocument;
                    Caption = 'Show My Report';
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Show My Report action.';
                    trigger OnAction()
                    begin
                        MyReport.Run();
                    end;
                }
            }
        }

    }
    var
        MyReport: Report "Seminar Reg.-Participant List";
}