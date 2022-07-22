pageextension 70400 "ResourceCard" extends "Resource Card"
{
    layout
    {
        addlast(General)
        {
            field("Internal/External"; Rec."Internal/External")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Internal/External field.';
            }
            field("Quantitiy Per Day"; Rec."Quantitiy Per Day")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Quantitiy Per Day field.';
            }
        }

        addlast(content)
        {
            group(Room)
            {
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Maximum Participants field.';
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}