<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MyBookings.aspx.cs" Inherits="User_MyBookings" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings | EMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4361ee;
            --bg: #f8f9fa;
        }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg); }

        .navbar { box-shadow: 0 2px 15px rgba(0,0,0,0.1); padding: 15px 0; }
        .navbar-brand { font-weight: 700; color: white !important; }
        .nav-link { font-weight: 500; color: rgba(255,255,255,0.7) !important; margin: 0 10px; }
        .nav-link:hover, .nav-link.active { color: white !important; }

        .header-section { background: white; padding: 40px 0; border-bottom: 1px solid #e9ecef; margin-bottom: 40px; }
        .grid-container { background: white; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); }

        .table { margin-bottom: 0; }
        .table thead th { border-top: none; background: #f8f9fa; color: #6c757d; font-weight: 600; text-transform: uppercase; font-size: 0.8rem; letter-spacing: 0.5px; padding: 15px; }
        .table tbody td { vertical-align: middle; padding: 15px; border-color: #f1f3f5; color: #495057; }

        .event-name { font-weight: 700; color: #212529; }
        .badge-date { background: rgba(67, 97, 238, 0.1); color: var(--primary); font-weight: 600; padding: 5px 12px; border-radius: 50px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
            <div class="container">
                <a class="navbar-brand" href="../Dashboard.aspx">
                    <i class="fa-solid fa-calendar-check me-2"></i>EMS
                </a>
                <div class="collapse navbar-collapse">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="../Dashboard.aspx"><i class="fa-solid fa-house me-1"></i> Dashboard</a>
                        </li>
                        <asp:PlaceHolder ID="phAdminMenu" runat="server" Visible="false">
                            <li class="nav-item">
                                <a class="nav-link" href="../Admin/ManageEvents.aspx"><i class="fa-solid fa-list-check me-1"></i> Manage Events</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="../Admin/ManageUsers.aspx"><i class="fa-solid fa-users me-1"></i> Manage Users</a>
                            </li>
                        </asp:PlaceHolder>
                        <li class="nav-item">
                            <a class="nav-link" href="BrowseEvents.aspx"><i class="fa-solid fa-magnifying-glass me-1"></i> Browse Events</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="MyBookings.aspx"><i class="fa-solid fa-ticket me-1"></i> My Bookings</a>
                        </li>
                    </ul>
                    <div class="d-flex align-items-center">
                        <span class="me-3 text-secondary small fw-bold">
                            <i class="fa-solid fa-circle-user me-1 text-primary"></i>
                            <asp:Literal ID="litUsernameNav" runat="server"></asp:Literal>
                        </span>
                        <asp:LinkButton ID="btnLogout" runat="server" CssClass="btn btn-outline-danger btn-sm" OnClick="btnLogout_Click" CausesValidation="false">
                            <i class="fa-solid fa-right-from-bracket me-1"></i> Logout
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </nav>

        <section class="header-section">
            <div class="container">
                <h1 class="fw-bold mb-2">My Bookings</h1>
                <p class="text-muted mb-0">View and manage your registered event tickets.</p>
            </div>
        </section>

        <div class="container mb-5">
            <div class="grid-container table-responsive shadow-sm rounded-3 overflow-hidden p-0">
                <asp:GridView ID="gvBookings" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-striped align-middle mb-0" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="BookingID" HeaderText="ID" ItemStyle-Width="80px" />
                        <asp:TemplateField HeaderText="Event Name">
                            <ItemTemplate>
                                <span class="event-name"><%# Eval("EventName") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Location">
                            <ItemTemplate>
                                <i class="fa-solid fa-location-dot text-danger me-1 small"></i> <%# Eval("Location") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Event Date">
                            <ItemTemplate>
                                <span class="badge-date"><%# Convert.ToDateTime(Eval("EventDate")).ToString("MMM dd, yyyy") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="BookingDate" HeaderText="Booked On" DataFormatString="{0:MMM dd, yyyy HH:mm}" />
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="text-center py-5">
                            <i class="fa-solid fa-ticket fa-3x mb-3 text-muted opacity-25"></i>
                            <h4 class="text-muted">You haven't booked any events yet.</h4>
                            <a href="BrowseEvents.aspx" class="btn btn-primary mt-3">Explore Events</a>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
