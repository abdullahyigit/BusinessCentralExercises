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
        }
    }
}