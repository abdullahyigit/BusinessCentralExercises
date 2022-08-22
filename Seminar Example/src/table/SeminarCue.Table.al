table 70113 "Seminar Cue"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; Planned; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Seminar Registration Header" where(Status = const(Planning)));
            Caption = 'Planned';
        }
        field(3; Registered; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Seminar Registration Header" where(Status = const(Registration)));
            Caption = 'Registered';
        }
        field(4; Closed; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Seminar Registration Header" where(Status = const(Closed)));
            Caption = 'Closed';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}