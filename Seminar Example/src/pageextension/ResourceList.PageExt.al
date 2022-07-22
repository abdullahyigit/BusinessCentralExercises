pageextension 70200 "ResourceList" extends "Resource List"
{
    layout
    {
        addafter(Type)
        {
            field("Internal/External"; Rec."Internal/External")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Internal/External field.';
            }
            field("Maximum Participanst"; Rec."Maximum Participants")
            {
                ApplicationArea = all;
                Visible = ShowMaxParticipants;
                ToolTip = 'Specifies the value of the Maximum Participants field.';
            }
        }
        modify(Type)
        {
            Visible = ShowType;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        [InDataSet]
        ShowType: Boolean;
        ShowMaxParticipants: Boolean;

    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(3);
        ShowType := Rec.GETFILTER(Type) = '';
        ShowMaxParticipants := Rec.GETFILTER(Type) = FORMAT(Rec.Type::Machine);
        Rec.FILTERGROUP(0);
    end;

}