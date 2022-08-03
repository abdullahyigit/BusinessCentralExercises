tableextension 70001 "DefaultDimension" extends "Default Dimension"
{
    var
    procedure UpdateSeminarGlobalDimCode(GlobalDimCodeNo: Integer; SeminarNo: Code[20]; NewDimValue: Code[20])
    var
        Seminar: Record Seminar;
    begin
        if Seminar.Get(SeminarNo) then begin
            case GlobalDimCodeNo of
                1:
                    Seminar."Global Dimension 1 Code" := NewDimValue;
                2:
                    Seminar."Global Dimension 2 Code" := NewDimValue;
                DATABASE::Seminar:
                    UpdateSeminarGlobalDimCode(GlobalDimCodeNo, "No.", NewDimValue);
            end;
        end;
    end;
}