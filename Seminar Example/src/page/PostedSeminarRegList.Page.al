page 70113 "Posted Seminar Reg. List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Posted Seminar Reg. Header";
    Editable = false;
    CardPageId = "Posted Seminar Registration";
    Caption = 'Posted Seminar Reg. List';

    layout
    {
        area(Content)
        {
            repeater("Group")
            {
                Caption = 'Group';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                    Caption = 'No.';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Starting Date field.';
                    Caption = 'Starting Date';
                }
                field("Seminar No."; Rec."Seminar No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seminar No. field.';
                    Caption = 'Seminar No.';
                }
                field("Seminar Name"; Rec."Seminar Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seminar Name field.';
                    Caption = 'Seminar Name';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                    Caption = 'Status';
                }
                field("Duration"; Rec."Duration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Duration field.';
                    Caption = 'Duration';
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum Participants field.';
                    Caption = 'Maximum Participants';
                }
                field("Room Resource No."; Rec."Room Resource No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Room No. field.';
                    Caption = 'Room No.';
                }
            }
        }
        area(FactBoxes)
        {
            part("Details FactBox"; "Seminar Details FactBox")
            {
                SubPageLink = "No." = field("Seminar No.");
                Caption = 'Seminar Details FactBox';
                ApplicationArea = All;
            }
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
                Caption = 'Comments';
                ApplicationArea = All;
                RunObject = page "Seminar Comment Sheet";
                RunPageView = WHERE("Document Type" = const(1));
                RunPageLink = "No." = field("No.");
                Image = Comment;
                ToolTip = 'Executes the Comments action.';
            }
            action("Charges")
            {
                Caption = 'Charges';
                ApplicationArea = All;
                RunObject = page "Posted Seminar Charges";
                RunPageLink = "No." = field("No.");
                Image = Costs;
                ToolTip = 'Executes the Charges action.';
            }
            action("Dimensions")
            {
                ApplicationArea = all;
                Image = Dimensions;
                Caption = 'Dimensions';
                trigger OnAction()
                begin
                    Rec.ShowDimensions();
                end;
            }
        }
        area(Processing)
        {
            action("&Navigate")
            {
                ApplicationArea = all;
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."No.");
                    Navigate.RUN;
                end;
            }

        }
    }
    var
        Navigate: Page Navigate;
}