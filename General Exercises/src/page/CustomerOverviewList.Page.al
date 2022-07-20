page 50102 "Customer Overview List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Customer Overview";
    Caption = 'Customer Overview List';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    Caption = 'Customer Name';
                    ApplicationArea = All;
                }
                field("Source Code"; Rec."Source Code")
                {
                    Caption = 'Source Code';
                    ApplicationArea = All;
                }
                field("Amount"; Rec."Amount")
                {
                    Caption = 'Decimal';
                    ApplicationArea = All;
                }
                field("LastRunDate"; Rec."LastRunDate")
                {
                    Caption = 'LastRunDate';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Import Records")
            {
                Caption = 'Import Records';
                Image = Import;
                ApplicationArea = All;

                trigger OnAction()
                var
                    UpdateCustomerOverview: Codeunit "Customer Overview Mgmt";
                begin
                    UpdateCustomerOverview.Run();
                end;
            }
        }
    }

    var
        myInt: Integer;
}