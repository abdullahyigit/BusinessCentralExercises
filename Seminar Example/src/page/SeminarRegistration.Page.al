page 70105 "Seminar Registration"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Seminar Registration Header";
    Caption = 'Seminar Registration';

    layout
    {
        area(Content)
        {
            group(General)
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
                field("Instructor Resource No."; Rec."Instructor Resource No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Instructor No. field.';
                }
                field("Instructor Name"; Rec."Instructor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Instructor Name field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.';
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
                field("Minimum Participants"; Rec."Minimum Participants")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minimum Participants field.';
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum Participants field.';
                }
                group("Seminar Room")
                {
                    field("Room Resource No."; Rec."Room Resource No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Room No. field.';
                    }
                    field("Room Name"; Rec."Room Name")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Room Name field.';
                    }
                    field("Room Address"; Rec."Room Address")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Room Address field.';
                    }
                    field("Room Address 2"; Rec."Room Address 2")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Room Address 2 field.';
                    }
                    field("Room Post Code"; Rec."Room Post Code")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Room Post Code field.';
                    }
                    field("Room Country/Reg. Code"; Rec."Room Country/Reg. Code")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Room Country/Reg. Code field.';
                    }
                    field("Room County"; Rec."Room County")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Room County field.';
                    }
                }

                group("Invoicing")
                {
                    field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.';
                    }
                    field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the VAT Prod. Posting Group field.';
                    }
                    field("Seminar Price"; Rec."Seminar Price")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Seminar Price field.';
                    }
                }
            }
        }

        area(FactBoxes)
        {
            part(MyArea; "Customer Details FactBox")
            {
                ApplicationArea = All;
            }
            systempart(Links; Links)
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
                RunObject = page "Comment Sheet";
                //RunPageView = WHERE("No." = const(0));
                //RunPageLink = field2 = field(field1);
                Image = Comment;
                ToolTip = 'Executes the Comments action.';
            }
            action("Charges")
            {
                ApplicationArea = All;
                RunObject = page "Seminar Charges";
                //RunPageLink = field2 = field(field1);
                Image = Costs;
                ToolTip = 'Executes the Charges action.';
            }
        }
    }
}