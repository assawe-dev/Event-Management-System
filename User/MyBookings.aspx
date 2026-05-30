<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MyBookings.aspx.cs" Inherits="User_MyBookings" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings | EMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-dark: #0f1115;
            --card-dark: #1c1f26;
            --accent: #6366f1;
            --text-main: #f3f4f6;
            --text-muted: #9ca3af;
        }

        body { font-family: 'Inter', sans-serif; background-color: var(--bg-dark); color: var(--text-main); }

        .navbar {
            background-color: rgba(15, 17, 21, 0.9) !important;
            backdrop-filter: blur(10px);
            border-bottom: 1px solid #1f2937;
            padding: 1rem 0;
        }

        .navbar-brand { font-weight: 800; color: white !important; }
        .nav-link { color: var(--text-muted) !important; font-weight: 500; margin: 0 0.5rem; }
        .nav-link:hover, .nav-link.active { color: var(--accent) !important; }

        .page-header { padding: 4rem 0 2rem; }

        .card-table {
            background-color: var(--card-dark); border: 1px solid #374151;
            border-radius: 1.5rem; overflow: hidden; box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.3);
        }

        .table { margin-bottom: 0; color: var(--text-main); }
        .table thead th {
            background-color: #252a33; color: var(--text-muted);
            border-bottom: 1px solid #374151; padding: 1.25rem 1.5rem;
            text-transform: uppercase; font-size: 0.75rem; letter-spacing: 0.05em; font-weight: 700;
        }
        .table tbody td {
            padding: 1.25rem 1.5rem; vertical-align: middle;
            border-bottom: 1px solid #1f2937; background-color: transparent; color: var(--text-main);
        }
        .table-hover tbody tr:hover { background-color: #2d3139; }

        .badge-id { background-color: #0f1115; color: var(--accent); padding: 0.4rem 0.8rem; border-radius: 0.5rem; font-family: monospace; font-weight: 700; }
        .event-name { font-weight: 600; color: white; font-size: 1rem; }

        .btn-cancel {
            background-color: rgba(239, 68, 68, 0.1); color: #ef4444;
            border: 1px solid rgba(239, 68, 68, 0.2);
            border-radius: 0.75rem; padding: 0.5rem 1rem;
            font-weight: 600; font-size: 0.875rem; transition: all 0.2s;
        }
        .btn-cancel:hover { background-color: #ef4444; color: white; }

        .btn-logout {
            background-color: rgba(239, 68, 68, 0.1);
            color: #ef4444; border: 1px solid rgba(239, 68, 68, 0.2);
            border-radius: 0.75rem; padding: 0.5rem 1rem;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
            <div class="container">
                <a class="navbar-brand" href="../Dashboard.aspx">EMS.PRO</a>
                <div class="collapse navbar-collapse">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item"><a class="nav-link" href="../Dashboard.aspx">Dashboard</a></li>
                        <asp:PlaceHolder ID="phAdminMenu" runat="server" Visible="false">
                            <li class="nav-item"><a class="nav-link" href="../Admin/ManageEvents.aspx">Events</a></li>
                        </asp:PlaceHolder>
                        <li class="nav-item"><a class="nav-link" href="BrowseEvents.aspx">Browse</a></li>
                        <li class="nav-item"><a class="nav-link active" href="MyBookings.aspx">My Tickets</a></li>
                    </ul>
                    <div class="d-flex align-items-center">
                        <span class="me-3 text-muted small fw-bold"><asp:Literal ID="litUsernameNav" runat="server"></asp:Literal></span>
                        <asp:LinkButton ID="btnLogout" runat="server" CssClass="btn-logout btn-sm" OnClick="btnLogout_Click" CausesValidation="false">
                            <i class="fa-solid fa-power-off"></i>
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </nav>

        <div class="container page-header">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h2 class="fw-bold text-white mb-1">My Registrations</h2>
                    <p class="text-muted mb-0">Review and manage your active event credentials.</p>
                </div>
            </div>
        </div>

        <div class="container mb-5">
            <div class="card-table table-responsive">
                <asp:GridView ID="gvBookings" runat="server" AutoGenerateColumns="false" CssClass="table table-hover align-middle" GridLines="None"
                    DataKeyNames="BookingID,EventID" OnRowCommand="gvBookings_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="Reference">
                            <ItemTemplate><span class="badge-id">#<%# Eval("BookingID") %></span></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Event Particulars">
                            <ItemTemplate>
                                <div class="event-name"><%# Eval("EventName") %></div>
                                <div class="small text-muted"><i class="fa-solid fa-location-dot me-1"></i> <%# Eval("Location") %></div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date">
                            <ItemTemplate>
                                <div class="text-white fw-medium"><%# Convert.ToDateTime(Eval("EventDate")).ToString("MMM dd, yyyy") %></div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Registered On">
                            <ItemTemplate>
                                <div class="text-muted small"><%# Convert.ToDateTime(Eval("BookingDate")).ToString("MMM dd, HH:mm") %></div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Operations">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn-cancel"
                                    CommandName="CancelBooking" CommandArgument='<%# Container.DataItemIndex %>'
                                    OnClientClick="return confirm('Initiate booking cancellation?');">
                                    <i class="fa-solid fa-trash-can me-1"></i> Cancel
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="text-center py-5">
                            <i class="fa-solid fa-ticket-slash fa-3x mb-3 text-muted opacity-25"></i>
                            <h5 class="text-muted">No active bookings found in your profile.</h5>
                            <a href="BrowseEvents.aspx" class="btn btn-sm btn-primary mt-2" style="background-color: var(--accent); border:none;">Explore Catalogue</a>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
