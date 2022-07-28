page 70105 "Seminar Registration"
{
    PageType = Document;
    SourceTable = "Seminar Registration Header";
    Caption = 'Seminar Registration';
    RefreshOnActivate = true;

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
                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
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
            }
            part(SeminarRegistrationLines; "Seminar Registration Subform")
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = FIELD("No.");
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

        area(FactBoxes)
        {
            part(MyArea; "Customer Details FactBox")
            {
                ApplicationArea = All;
                Provider = SeminarRegistrationLines;
                SubPageLink = "No." = field("Bill-to Customer No.");
            }
            systempart(RecordLinks; Links)
            {
                ApplicationArea = All;
                Provider = SeminarRegistrationLines;

            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
                Provider = SeminarRegistrationLines;
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
                RunPageView = WHERE("Document Type" = const(1));
                RunPageLink = "No." = field("No.");
                Image = Comment;
                ToolTip = 'Executes the Comments action.';
            }
            action("Charges")
            {
                ApplicationArea = All;
                RunObject = page "Seminar Charges";
                RunPageLink = "Document No." = field("No.");
                Image = Costs;
                ToolTip = 'Executes the Charges action.';
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
                }
            }
        }

    }

    var
        Navigate: Page Navigate;
}