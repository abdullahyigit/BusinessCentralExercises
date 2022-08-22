page 70119 "Seminar Manager Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            group(Control1)
            {
                Caption = 'Control1';
                part("Seminar Manager Activities"; "Seminar Manager Activities")
                {
                    Caption = 'Seminar Manager Activities';
                    ApplicationArea = All;
                }
                systempart(Outlook; Outlook)
                {
                    ApplicationArea = All;
                }
            }

            group(Control2)
            {
                Caption = 'Control2';
                part("My Seminars"; "My Seminars")
                {
                    ApplicationArea = All;

                }
                part("My Customers"; "My Customers")
                {
                    ApplicationArea = All;

                }
                //part("Connect Online";)
                systempart(MyNotes; MyNotes)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(Embedding)
        {
            action(SeminarRegistrations)
            {
                Caption = 'Seminar Registrations';
                RunObject = page "Seminar Registration List";
                ApplicationArea = All;
                ToolTip = 'Executes the Seminar Registrations action.';
            }
            action(Seminars)
            {
                RunObject = page "Seminar List";
                ApplicationArea = All;
                ToolTip = 'Executes the Seminars action.';
            }
            action(Instructors)
            {
                RunObject = page "Resource List";
                RunPageView = where(Type = const(Person));
                ApplicationArea = All;
                ToolTip = 'Executes the Instructors action.';
            }
            action(Rooms)
            {
                RunObject = page "Resource List";
                RunPageView = where(Type = const(Machine));
                ApplicationArea = All;
                ToolTip = 'Executes the Rooms action.';
            }
            action(Customers)
            {
                RunObject = page "Customer List";
                ApplicationArea = All;
                ToolTip = 'Executes the Customers action.';
            }
            action(Contacts)
            {
                RunObject = page "Contact List";
                ApplicationArea = All;
                ToolTip = 'Executes the Contacts action.';
            }

        }
        area(Sections)
        {
            group("Posted Documents")
            {
                action("Posted Seminar Reg.")
                {
                    Caption = 'Posted Seminar Registrations';
                    RunObject = page "Posted Seminar Reg. List";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Posted Seminar Registrations action.';
                }
                action("Posted Sales Invoices")
                {
                    Caption = 'Posted Sales Invoices';
                    RunObject = page "Posted Sales Invoices";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Posted Sales Invoices action.';
                }
                action(Registers)
                {
                    Caption = 'Registers';
                    RunObject = page "Seminar Registers";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Registers action.';
                }
            }
        }

        area(Processing)
        {
            group(NewDocumentItems)
            {
                action("Seminar Registration")
                {
                    Caption = 'Seminar Registration';
                    RunObject = page "Seminar Registration";
                    Image = NewTimesheet;
                    ApplicationArea = all;
                    ToolTip = 'Executes the Seminar Registration action.';
                }
                action("Sales Invoice")
                {
                    Caption = 'Sales Invoice';
                    RunObject = page "Sales Invoice";
                    Image = NewInvoice;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Sales Invoice action.';
                }
            }
        }

        area(Creation)
        {
            group(ActionItems)
            {
                action("Create Invoices")
                {
                    Caption = 'Create Invoices';
                    RunObject = report "Create Seminar Invoices";
                    Image = CreateJobSalesInvoice;
                    ApplicationArea = all;
                    ToolTip = 'Executes the Create Invoices action.';
                }
                action("Navigate")
                {
                    Caption = 'Navigate';
                    RunObject = page "Navigate";
                    Image = Navigate;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Navigate action.';
                }
            }
        }

        area(Reporting)
        {
            action("Participant List")
            {
                Caption = 'Participant List';
                RunObject = report "Seminar Reg.-Participant List";
                Image = Report;
                ApplicationArea = All;
                ToolTip = 'Executes the Participant List action.';
            }
        }
    }
}