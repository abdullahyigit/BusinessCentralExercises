page 70103 "Seminar List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Seminar;
    CardPageId = "Seminar Card";
    Editable = false;
    Caption = 'Seminar List';
    PromotedActionCategories = 'New,Process,Creation,Seminar';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
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
            action(Comments)
            {
                Image = Comment;
                RunObject = page "Comment Sheet";
                RunPageLink = "Table Name" = const(Seminar), "No." = field("No.");
                ApplicationArea = All;
                ToolTip = 'Executes the Comments action.';
            }

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
        area(Processing)
        {
            group(Seminar)
            {
                Caption = 'Seminar';
                Image = AvailableToPromise;
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
                action("Dimensions-Single")
                {
                    Caption = 'Dimensions-Single';
                    ApplicationArea = all;
                    Image = Dimensions;
                    ShortcutKey = "Shift+Ctrl+D";
                    RunObject = page "Default Dimensions";
                    RunPageLink = "Table ID" = const(70101), "No." = field("No.");
                    ToolTip = 'Executes the Dimensions-Single action.';
                }
                action("Dimensions-Multiple")
                {
                    Caption = 'Dimensions-Multiple';
                    ApplicationArea = all;
                    ToolTip = 'Executes the Dimensions-Multiple action.';
                    trigger OnAction()
                    var
                        Seminar: Record Seminar;
                        DefaultDimMultiple: page "Default Dimensions-Multiple";
                    begin
                        CurrPage.SetSelectionFilter(Seminar);
                        DefaultDimMultiple.SetMultiSeminar(Seminar);
                        DefaultDimMultiple.RunModal();
                    end;
                }
            }
        }
    }
}