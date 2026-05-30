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
    <style>
        :root {
            --bg-dark: #0f1115;
            --card-dark: #1c1f26;
            --accent: #6366f1;
            --text-main: #f3f4f6;
            --text-muted: #9ca3af;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-dark);
            color: var(--text-main);
        }

        .navbar {
            background-color: rgba(15, 17, 21, 0.9) !important;
            backdrop-filter: blur(10px);
            border-bottom: 1px solid #1f2937;
            padding: 1rem 0;
        }

        .navbar-brand { font-weight: 800; color: white !important; letter-spacing: -0.5px; }
        .nav-link { color: var(--text-muted) !important; font-weight: 500; transition: all 0.2s; margin: 0 0.5rem; }
        .nav-link:hover, .nav-link.active { color: var(--accent) !important; }

        .welcome-card {
            background: linear-gradient(135deg, var(--accent) 0%, #4338ca 100%);
            border-radius: 1.5rem;
            padding: 3rem;
            margin-bottom: 3rem;
            position: relative;
            overflow: hidden;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.2);
        }

        .welcome-card h1 { font-weight: 800; margin-bottom: 0.5rem; }
        .welcome-card .bg-icon {
            position: absolute; right: -2rem; bottom: -2rem;
            font-size: 12rem; opacity: 0.1; transform: rotate(-15deg);
        }

        .stat-card {
            background-color: var(--card-dark);
            border: 1px solid #374151;
            border-radius: 1.25rem;
            padding: 1.5rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .stat-card:hover { transform: translateY(-5px); border-color: var(--accent); }

        .stat-icon {
            width: 48px; height: 48px; border-radius: 0.75rem;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.25rem; margin-bottom: 1rem;
            background-color: rgba(99, 102, 241, 0.1);
            color: var(--accent);
        }

        .stat-value { font-size: 1.5rem; font-weight: 700; color: white; }
        .stat-label { color: var(--text-muted); font-size: 0.875rem; font-weight: 600; text-transform: uppercase; letter-spacing: 0.05em; }

        .menu-card {
            background-color: var(--card-dark);
            border: 1px solid #374151;
            border-radius: 1.5rem;
            padding: 2.5rem;
            height: 100%;
            transition: all 0.3s;
        }

        .menu-card:hover { border-color: var(--accent); box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.3); }

        .btn-action {
            background-color: var(--accent);
            color: white;
            border-radius: 0.75rem;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            display: inline-block;
            text-decoration: none;
            transition: all 0.2s;
            width: 100%;
            text-align: center;
        }

        .btn-action:hover { background-color: #4f46e5; color: white; transform: translateY(-2px); }

        .btn-logout {
            background-color: rgba(239, 68, 68, 0.1);
            color: #ef4444;
            border: 1px solid rgba(239, 68, 68, 0.2);
            border-radius: 0.75rem;
            padding: 0.5rem 1rem;
            font-weight: 600;
            transition: all 0.2s;
        }

        .btn-logout:hover { background-color: #ef4444; color: white; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
            <div class="container">
                <a class="navbar-brand" href="Dashboard.aspx">
                    <i class="fa-solid fa-cube me-2 text-accent" style="color: var(--accent);"></i>EMS.PRO
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
                        <div class="text-end me-3">
                            <div class="small text-muted fw-bold lh-1">USER CONTEXT</div>
                            <div class="text-white small fw-semibold"><asp:Literal ID="litUsername" runat="server"></asp:Literal></div>
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
