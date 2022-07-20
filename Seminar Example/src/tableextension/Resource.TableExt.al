tableextension 70300 "Resource" extends Resource
{
    fields
    {
        field(50150; "Internal/External"; Option)
        {
            OptionCaption = 'Internal,External';
            OptionMembers = "Internal","External";
            Caption = 'Internal/External';
        }
        field(50151; "Maximum Participant"; Integer)
        {
            Caption = 'Maximum Participant';
        }
        field(50152; "Quantitiy Per Day"; Decimal)
        {
            Caption = 'Quantitiy Per Day';
        }
    }


}