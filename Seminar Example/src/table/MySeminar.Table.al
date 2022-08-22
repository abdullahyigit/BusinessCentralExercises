table 70114 "My Seminar"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(2; "Seminar No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Seminar;
        }
    }

    keys
    {
        key(Key1; "User ID", "Seminar No.")
        {
            Clustered = true;
        }
    }
}