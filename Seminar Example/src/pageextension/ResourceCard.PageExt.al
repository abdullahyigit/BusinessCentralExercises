pageextension 70400 "ResourceCard" extends "Resource Card"
{
    layout
    {
        addlast(General)
        {
            field("Internal/External"; Rec."Internal/External")
            {
                ApplicationArea = all;
            }
            field("Quantitiy Per Day"; Rec."Quantitiy Per Day")
            {
                ApplicationArea = all;
            }
        }

        addlast(content)
        {
            group(Room)
            {
                field("Maximum Participant"; Rec."Maximum Participant")
                {
                    ApplicationArea = all;
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