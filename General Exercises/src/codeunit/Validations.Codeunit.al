codeunit 50120 "Validations"
{
    trigger OnRun()
    begin

    end;

    procedure CheckForPlusSign(TextToVerify: Text)
    begin

        if StrPos(TextToVerify, '+') > 0 then
            Message('+ sign is found!.us');

    end;

    [EventSubscriber(ObjectType::Page, Page::"Customer Card", 'OnBeforeValidateEvent', 'Address', false, false)]
    local procedure OnBeforeValidateAddress(var Rec: Record Customer; var xRec: Record Customer)
    begin
        CheckForPlusSign(Rec.Address);
    end;

    var
        myInt: Integer;
}