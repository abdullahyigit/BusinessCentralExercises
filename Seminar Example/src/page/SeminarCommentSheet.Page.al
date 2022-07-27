page 71000 "Seminar Comment Sheet"
{
    Caption = 'Seminar Comment Sheet';
    MultipleNewLines = true;
    LinksAllowed = false;
    SourceTable = "Seminar Comment Line";
    DelayedInsert = true;
    DataCaptionFields = "No.";
    PageType = List;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Date"; Rec.Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Comment field.';
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Code field.';
                }
            }
        }
    }
}