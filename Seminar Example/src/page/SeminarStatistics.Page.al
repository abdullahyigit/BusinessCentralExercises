page 70115 "Seminar Statistics"
{
    PageType = Card;
    SourceTable = Seminar;
    LinksAllowed = false;
    Editable = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                fixed(FixedLayout)
                {
                    group("This Period")
                    {
                        field("SeminarDateName[1]"; SeminarDateName[1])
                        {
                            ApplicationArea = All;
                            Caption = 'Seminar Date Name';

                        }
                        field("TotalPrice[1]"; TotalPrice[1])
                        {
                            ApplicationArea = All;
                            Caption = 'Total Price';
                        }
                        field("TotalPriceChargeable[1]"; TotalPriceChargeable[1])
                        {
                            ApplicationArea = All;
                            Caption = 'Total Price Chargeable';
                        }
                        field("TotalPriceNotChargeable[1]"; TotalPriceNotChargeable[1])
                        {
                            ApplicationArea = All;
                            Caption = 'Total Price Not Chargeable';
                        }
                    }
                    group("This Year")
                    {
                        field("SeminarDateName[2]"; SeminarDateName[2])
                        {
                            ApplicationArea = All;
                            Caption = 'Seminar Date Name';
                        }
                        field("TotalPrice[2]"; TotalPrice[2])
                        {
                            ApplicationArea = All;
                            Caption = 'Total Price';
                        }
                        field("TotalPriceChargeable[2]"; TotalPriceChargeable[2])
                        {
                            ApplicationArea = All;
                            Caption = 'Total Price Chargeable';
                        }
                        field("TotalPriceNotChargeable[2]"; TotalPriceNotChargeable[2])
                        {
                            ApplicationArea = All;
                            Caption = 'Total Price Not Chargeable';
                        }
                    }
                    group("Last Year")
                    {
                        field("SeminarDateName[3]"; SeminarDateName[3])
                        {
                            ApplicationArea = All;
                            Caption = 'Seminar Date Name';
                        }
                        field("TotalPrice[3]"; TotalPrice[3])
                        {
                            ApplicationArea = All;
                            Caption = 'Total Price';
                        }
                        field("TotalPriceChargeable[3]"; TotalPriceChargeable[3])
                        {
                            ApplicationArea = All;
                            Caption = 'Total Price Chargeable';
                        }
                        field("TotalPriceNotChargeable[3]"; TotalPriceNotChargeable[3])
                        {
                            ApplicationArea = All;
                            Caption = 'Total Price Not Chargeable';
                        }
                    }
                    group("To Date")
                    {
                        field("SeminarDateName[4]"; SeminarDateName[4])
                        {
                            ApplicationArea = All;
                            Caption = 'Seminar Date Name';
                        }
                        field("TotalPrice[4]"; TotalPrice[4])
                        {
                            ApplicationArea = All;
                            Caption = 'Total Price';
                        }
                        field("TotalPriceChargeable[4]"; TotalPriceChargeable[4])
                        {
                            ApplicationArea = All;
                            Caption = 'Total Price Chargeable';
                        }
                        field("TotalPriceNotChargeable[4]"; TotalPriceNotChargeable[4])
                        {
                            ApplicationArea = All;
                            Caption = 'Total Price Not Chargeable';
                        }
                    }
                }
            }
        }
    }

    actions
    {
    }



    trigger OnAfterGetRecord()
    begin
        Rec.SetRange("No.", Rec."No.");

        if CurrentDate <> WorkDate() then begin
            CurrentDate := WorkDate();
            DateFilterCalc.CreateAccountingPeriodFilter(SeminarDateFilter[1], SeminarDateName[1], CurrentDate, 0);
            DateFilterCalc.CreateFiscalYearFilter(SeminarDateFilter[2], SeminarDateName[2], CurrentDate, 0);
            DateFilterCalc.CreateFiscalYearFilter(SeminarDateFilter[3], SeminarDateName[3], CurrentDate, -1);
        end;

        for I := 1 to 4 do begin
            Rec.SetFilter("Date Filter", SeminarDateFilter[I]);
            Rec.CalcFields("Total Price", "Total Price (Chargeable)", "Total Price (Not Chargeable)");
            TotalPrice[I] := Rec."Total Price";
            TotalPriceChargeable[I] := Rec."Total Price (Chargeable)";
            TotalPriceNotChargeable[I] := Rec."Total Price (Not Chargeable)";
        end;

        Rec.SetRange("Date Filter", 0D, CurrentDate);
    end;

    var
        DateFilterCalc: Codeunit "DateFilter-Calc";
        SeminarDateFilter: array[4] of Text[30];
        SeminarDateName: array[4] of Text[30];
        CurrentDate: Date;
        TotalPrice: array[4] of Decimal;
        TotalPriceChargeable: array[4] of Decimal;
        TotalPriceNotChargeable: array[4] of Decimal;
        I: Integer;
}