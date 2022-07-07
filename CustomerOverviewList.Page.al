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
                field("Entry No."; "Entry No.")
                {
                    Caption = 'Entry No.';
                    ApplicationArea = All;
                }
                field("Customer No."; "Customer No.")
                {
                    Caption = 'Customer No.';
                    ApplicationArea = All;
                }
                field("Customer Name"; "Customer Name")
                {
                    Caption = 'Customer Name';
                    ApplicationArea = All;
                }
                field("Source Code"; "Source Code")
                {
                    Caption = 'Source Code';
                    ApplicationArea = All;
                }
                field("Amount"; "Amount")
                {
                    Caption = 'Decimal';
                    ApplicationArea = All;
                }
                field("LastRunDate"; "LastRunDate")
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
                    UpdateCustomerOverview : Codeunit "Customer Overview Mgmt";
                begin
                    UpdateCustomerOverview.Run();
                end;
            }
        }
    }

    var
        myInt: Integer;
}