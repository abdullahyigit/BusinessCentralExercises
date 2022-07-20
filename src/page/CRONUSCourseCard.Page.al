page 50100 "CRONUS Course Card"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "CRONUS Course";
    Caption = 'Course Card';
    Editable = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field("Name"; Rec."Name")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                }
            }

            group(Details)
            {
                Caption = 'Details';
                field("Duration"; Rec."Duration")
                {
                    ApplicationArea = All;
                }
                field("Price"; Rec."Price")
                {
                    ApplicationArea = All;
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                }
                field("Active"; Rec."Active")
                {
                    ApplicationArea = All;
                }
                field("Insturcor Code"; Rec."Instructor Code")
                {
                    ApplicationArea = All;
                }
                field("Insturcor Name"; Rec."Instructor Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Resource Card")
            {
                Caption = 'Resource';
                ToolTip = 'Open the Resource Card.';
                RunObject = Page "Resource Card";
                RunPageLink = "No." = field("Instructor Code");
                Image = Relationship;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
            }
        }
    }
}