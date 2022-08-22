table 70112 "Seminar Report Selections"
{

    fields
    {
        field(1; Usage; Option)
        {
            OptionMembers = "Registration";
            OptionCaption = 'Registration';
            Caption = 'Usage';
        }
        field(2; Sequence; Code[10])
        {
            Numeric = true;
            Caption = 'Sequence';
        }

        field(3; "Report ID"; Integer)
        {
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const("Report"));
            Caption = 'Report ID';
            trigger OnValidate()
            begin
                CalcFields("Report Name");
            end;
        }
        field(4; "Report Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(AllObjWithCaption."Object Caption"
            where("Object Type" = const("Report"),
                "Object ID" = field("Report ID")
            ));
            Caption = 'Report Name';
        }
    }
    keys
    {
        key(Key1; Usage, Sequence)
        {
            Clustered = true;
        }
    }

    var
        ReportSelection: Record "Seminar Report Selections";

    procedure NewRecord()
    begin
        ReportSelection.SetRange(Usage, Usage);
        if ReportSelection.Find('+') and (ReportSelection.Sequence <> '') then begin
            Sequence := IncStr(ReportSelection.Sequence);
        end else
            Sequence := '1';
    end;

}