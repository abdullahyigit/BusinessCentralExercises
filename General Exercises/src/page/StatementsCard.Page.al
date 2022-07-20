page 50112 "Statements Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    Caption = 'Statements Card';

    layout
    {
        area(Content)
        {
            group(Input)
            {
                Caption = 'Input';
                field("Difficulty"; "Difficulty")
                {
                    Caption = 'Difficulty';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        GetSuggestion();
                    end;
                }
            }

            group(Output)
            {
                Caption = 'Output';
                field("Level"; "Level")
                {
                    Editable = false;
                    Caption = 'Level';
                    ApplicationArea = All;
                }

                field("Suggestion"; "Suggestion")
                {
                    Editable = false;
                    Caption = 'Suggestion';
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        Level: Text[50];
        Suggestion: Text[80];
        Difficulty: Integer;

    procedure GetSuggestion()
    begin
        Level := '';
        Suggestion := '';

        case Difficulty of
            1 .. 5:
                begin
                    Level := 'Beginner';
                    Suggestion := 'Take e-Learning or remote training';
                end;
            6 .. 8:
                begin
                    Level := 'Intermediate';
                    Suggestion := 'Attend instructor-Led';
                end;
            9 .. 10:
                begin
                    Level := 'Advanced';
                    Suggestion := 'Attend instructor-Led and self study';
                end;
        end;
    end;
}