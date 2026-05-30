<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Dashboard" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | EMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="StyleSheet.css" rel="stylesheet">
</head>
<body>
    <script src="ThemeScript.js"></script>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg sticky-top">
            <div class="container">
                <a class="navbar-brand" href="Dashboard.aspx">
                    <i class="fa-solid fa-cube me-2" style="color: var(--accent);"></i>EMS.PRO
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link active" href="Dashboard.aspx">Dashboard</a>
                        </li>
                        <asp:PlaceHolder ID="phAdminMenu" runat="server" Visible="false">
                            <li class="nav-item"><a class="nav-link" href="Admin/ManageEvents.aspx">Events</a></li>
                            <li class="nav-item"><a class="nav-link" href="Admin/ManageUsers.aspx">Users</a></li>
                            <li class="nav-item"><a class="nav-link" href="Admin/ViewBookings.aspx">Bookings</a></li>
                        </asp:PlaceHolder>
                        <asp:PlaceHolder ID="phUserMenu" runat="server" Visible="false">
                            <li class="nav-item"><a class="nav-link" href="User/BrowseEvents.aspx">Browse</a></li>
                            <li class="nav-item"><a class="nav-link" href="User/MyBookings.aspx">My Tickets</a></li>
                        </asp:PlaceHolder>
                    </ul>
                    <div class="d-flex align-items-center">
                        <button type="button" id="themeToggle" class="theme-toggle">
                            <i class="fa-solid fa-moon"></i>
                        </button>
                        <div class="text-end me-3">
                            <div class="small text-muted fw-bold lh-1">USER CONTEXT</div>
                            <div class="text-main small fw-semibold"><asp:Literal ID="litUsername" runat="server"></asp:Literal></div>
                        </div>
                        <asp:LinkButton ID="btnLogout" runat="server" CssClass="btn-logout" OnClick="btnLogout_Click" CausesValidation="false">
                            <i class="fa-solid fa-power-off"></i>
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </nav>

        <div class="container mt-5 pb-5">
            <div class="welcome-card text-white">
                <h1 class="display-5">Welcome, <asp:Literal ID="litUsernameWelcome" runat="server"></asp:Literal></h1>
                <p class="lead opacity-75">Your high-performance event management workspace is ready.</p>
                <i class="fa-solid fa-rocket bg-icon"></i>
            </div>

            <div class="row g-4 mb-5">
                <div class="col-md-4">
                    <div class="stat-card">
                        <div class="stat-icon"><i class="fa-solid fa-calendar-check"></i></div>
                        <div class="stat-value"><asp:Literal ID="litTotalEvents" runat="server"></asp:Literal></div>
                        <div class="stat-label">System Events</div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card">
                        <div class="stat-icon"><i class="fa-solid fa-ticket"></i></div>
                        <div class="stat-value"><asp:Literal ID="litTotalUsers" runat="server"></asp:Literal></div>
                        <div class="stat-label"><asp:Literal ID="litBookingsLabel" runat="server"></asp:Literal></div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card">
                        <div class="stat-icon"><i class="fa-solid fa-chart-line"></i></div>
                        <div class="stat-value"><asp:Literal ID="litBookingScope" runat="server"></asp:Literal></div>
                        <div class="stat-label">Activity Scope</div>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                <asp:PlaceHolder ID="phAdminCard" runat="server" Visible="false">
                    <div class="col-md-6">
                        <div class="menu-card">
                            <h3 class="fw-bold mb-3">Event Operations</h3>
                            <p class="text-muted mb-4">Full administrative control over the event lifecycle. Deploy new conferences, workshops, and manage capacity in real-time.</p>
                            <a href="Admin/ManageEvents.aspx" class="btn-action">Launch Command Center</a>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="menu-card">
                            <h3 class="fw-bold mb-3">Identity Management</h3>
                            <p class="text-muted mb-4">Manage user permissions, authentication protocols, and organizational roles across the platform infrastructure.</p>
                            <a href="Admin/ManageUsers.aspx" class="btn-action" style="background-color: #4f46e5;">Manage Directory</a>
                        </div>
                    </div>
                </asp:PlaceHolder>

                <asp:PlaceHolder ID="phUserCard" runat="server" Visible="false">
                    <div class="col-md-6">
                        <div class="menu-card">
                            <h3 class="fw-bold mb-3">Discovery Engine</h3>
                            <p class="text-muted mb-4">Explore our curated list of high-impact events. Use advanced filtering to find your next professional milestone.</p>
                            <a href="User/BrowseEvents.aspx" class="btn-action">Explore Events</a>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="menu-card">
                            <h3 class="fw-bold mb-3">Personal Portfolio</h3>
                            <p class="text-muted mb-4">Manage your registered bookings and track your professional development journey through event attendance.</p>
                            <a href="User/MyBookings.aspx" class="btn-action" style="background-color: #818cf8;">View My Tickets</a>
                        </div>
                    </div>
                </asp:PlaceHolder>
            </div>
        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
