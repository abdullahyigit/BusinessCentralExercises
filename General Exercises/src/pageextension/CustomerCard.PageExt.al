pageextension 50100 "CustomerCard" extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addAfter("F&unctions")
        {
            action(UpdateCreditLimit)
            {
                Caption = 'UpdateCreditLimit';
                ApplicationArea = all;
                Image = CalculateCost;
                trigger OnAction()
                begin
                    CallUpdateCreditLimit();
                end;

            }


        }
    }


    var
        AreYouSureQst: Label 'Are you sure that you want to set the %1 to %2?';
        CreditLimitRoundedTxt: Label 'The credit limit was rounded to %1 to comply with company policies.';
        CreditLimitUpToDateTxt: Label 'The credit limit is up to date.';

    local procedure CallUpdateCreditLimit()

    var
        CreditLimitCalculated: Decimal;
        CreditLimitActual: Decimal;

    begin
        CreditLimitCalculated := Rec.CalculateCreditLimit();
        if CreditLimitCalculated = Rec."Credit Limit (LCY)" then begin
            Message(CreditLimitUpToDateTxt);
            exit;
        end;

        if GuiAllowed() then
            if not Confirm(AreYouSureQst, false, Rec.FieldCaption("Credit Limit (LCY)"), CreditLimitCalculated) then
                exit;

        CreditLimitActual := CreditLimitCalculated;
        Rec.UpdateCreditLimit(CreditLimitActual);
        if CreditLimitActual <> CreditLimitCalculated then
            Message(CreditLimitROundedTxt, CreditLimitActual);
    end;
}