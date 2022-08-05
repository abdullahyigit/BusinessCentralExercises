codeunit 70010 "OnAfterUpdateGlobalDimCode"
{
    [EventSubscriber(ObjectType::Table, Database::"Default Dimension", 'OnAfterUpdateGlobalDimCode', '', false, false)]
    local procedure TableDefaultDimensionOnAfterUpdateGlobalDimCode(GlobalDimCodeNo: Integer; TableID: Integer; AccNo: Code[20]; NewDimValue: Code[20]);
    var
        DefaultDim: Record "Default Dimension";
    begin
        case TableID of
            DATABASE::Seminar:
                begin
                    DefaultDim.UpdateSeminarGlobalDimCode(GlobalDimCodeNo, AccNo, NewDimValue);
                end;

        end;
    end;
}