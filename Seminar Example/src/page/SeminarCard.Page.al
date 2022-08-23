page 70102 "Seminar Card"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Seminar";
    Caption = 'Seminar Card';

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
                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit() THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Name"; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Seminar Duration"; Rec."Seminar Duration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seminar Duration field.';
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
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Search field.';
                }
                field("Blocked"; Rec.Blocked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Date Modified field.';
                }
            }
            group(Invoicing)
            {
                field("Seminar Price"; Rec."Seminar Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seminar Price field.';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.';
                }
                field("Vat. Prod. Posting Group"; Rec."Vat. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vat. Prod. Posting Group field.';
                }
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action("Seminar Registration")
            {
                Caption = 'Seminar Registration';
                RunPageMode = Create;
                Image = NewTimesheet;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                RunObject = page "Seminar Registration";
                RunPageLink = "Seminar No." = field("No.");
                ApplicationArea = All;
                ToolTip = 'Executes the Seminar Registration action.';
            }
        }
        area(Navigation)
        {
            group(Seminar)
            {
                action("Ledger Entries")
                {
                    Caption = 'Ledger Entries';
                    Image = WarrantyLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortcutKey = "Ctrl + F7";
                    RunObject = page "Seminar Ledger Entries";
                    RunPageLink = "Seminar No." = field("No.");
                    ApplicationArea = all;
                    ToolTip = 'Executes the Ledger Entries action.';
                }

                action("&Statistics")
                {
                    Caption = '&Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortcutKey = "F7";
                    RunObject = page "Seminar Statistics";
                    RunPageLink = "No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Executes the &Statistics action.';
                }
                action("Dimensions")
                {
                    Caption = 'Dimensions';
                    ApplicationArea = all;
                    Image = Dimensions;
                    ShortcutKey = "Shift+Ctrl+D";
                    RunObject = page "Default Dimensions";
                    RunPageLink = "Table ID" = const(70101), "No." = field("No.");
                    ToolTip = 'Executes the Dimensions action.';
                }
            }
            group("&Registrations")
            {
                action("Registrations")
                {
                    Caption = '&Registrations';
                    Image = Timesheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Seminar Registration List";
                    RunPageLink = "Seminar No." = field("No.");
                    ApplicationArea = all;
                    ToolTip = 'Executes the &Registrations action.';
                }
            }
        }
    }
}