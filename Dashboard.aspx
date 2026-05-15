<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Dashboard" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | EMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4361ee;
            --secondary: #3f37c9;
            --accent: #4cc9f0;
            --success: #4cc9f0;
            --dark: #212529;
        }
        body { font-family: 'Inter', sans-serif; background-color: #f4f7fe; }

        /* Navbar */
        .navbar { box-shadow: 0 2px 15px rgba(0,0,0,0.1); padding: 15px 0; }
        .navbar-brand { font-weight: 700; color: white !important; font-size: 1.5rem; }
        .nav-link { font-weight: 500; color: rgba(255,255,255,0.7) !important; margin: 0 10px; transition: 0.3s; }
        .nav-link:hover, .nav-link.active { color: white !important; }
        .btn-logout { border-radius: 10px; padding: 8px 20px; font-weight: 600; }

        /* Dashboard Header */
        .welcome-section { background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%); border-radius: 20px; padding: 40px; color: white; margin-bottom: 40px; position: relative; overflow: hidden; }
        .welcome-section h1 { font-weight: 700; z-index: 2; position: relative; }
        .welcome-section p { opacity: 0.9; z-index: 2; position: relative; }
        .welcome-section i.bg-icon { position: absolute; right: -20px; bottom: -20px; font-size: 10rem; opacity: 0.1; transform: rotate(-15deg); }

        /* Stats Cards */
        .stat-card { border: none; border-radius: 20px; padding: 25px; box-shadow: 0 10px 30px rgba(0,0,0,0.03); transition: 0.3s; background: white; height: 100%; }
        .stat-card:hover { transform: translateY(-5px); box-shadow: 0 15px 35px rgba(0,0,0,0.08); }
        .stat-icon { width: 50px; height: 50px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; margin-bottom: 15px; }
        .stat-value { font-size: 1.75rem; font-weight: 700; color: var(--dark); margin-bottom: 5px; }
        .stat-label { color: #6c757d; font-weight: 500; font-size: 0.9rem; text-transform: uppercase; letter-spacing: 0.5px; }

        /* Menu Cards */
        .card-menu { border: none; border-radius: 20px; transition: 0.3s; box-shadow: 0 10px 30px rgba(0,0,0,0.03); height: 100%; overflow: hidden; }
        .card-menu:hover { transform: translateY(-10px); box-shadow: 0 15px 35px rgba(0,0,0,0.1); }
        .card-icon { width: 60px; height: 60px; border-radius: 15px; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; margin-bottom: 20px; }
        .icon-admin { background: rgba(67, 97, 238, 0.1); color: var(--primary); }
        .icon-user { background: rgba(76, 201, 240, 0.1); color: var(--accent); }
        .btn-action { border-radius: 10px; padding: 10px 20px; font-weight: 600; width: 100%; text-align: center; display: inline-block; text-decoration: none; transition: 0.3s; }
        .btn-admin { background: var(--primary); color: white; }
        .btn-admin:hover { background: var(--secondary); color: white; }
        .btn-user { background: var(--accent); color: white; }
        .btn-user:hover { background: #3ab0d3; color: white; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
            <div class="container">
                <a class="navbar-brand" href="Dashboard.aspx">
                    <i class="fa-solid fa-calendar-check me-2"></i>EMS
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link active" href="Dashboard.aspx"><i class="fa-solid fa-house me-1"></i> Dashboard</a>
                        </li>
                        <asp:PlaceHolder ID="phAdminMenu" runat="server" Visible="false">
                            <li class="nav-item">
                                <a class="nav-link" href="Admin/ManageEvents.aspx"><i class="fa-solid fa-list-check me-1"></i> Manage Events</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="Admin/ManageUsers.aspx"><i class="fa-solid fa-users me-1"></i> Manage Users</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="Admin/ViewBookings.aspx"><i class="fa-solid fa-ticket me-1"></i> View All Bookings</a>
                            </li>
                        </asp:PlaceHolder>
                        <asp:PlaceHolder ID="phUserMenu" runat="server" Visible="false">
                            <li class="nav-item">
                                <a class="nav-link" href="User/BrowseEvents.aspx"><i class="fa-solid fa-magnifying-glass me-1"></i> Browse Events</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="User/MyBookings.aspx"><i class="fa-solid fa-ticket me-1"></i> My Bookings</a>
                            </li>
                        </asp:PlaceHolder>
                    </ul>
                    <div class="d-flex align-items-center">
                        <span class="me-3 text-secondary small fw-bold">
                            <i class="fa-solid fa-circle-user me-1 text-primary"></i>
                            <asp:Literal ID="litUsername" runat="server"></asp:Literal>
                        </span>
                        <asp:LinkButton ID="btnLogout" runat="server" CssClass="btn btn-outline-danger btn-logout btn-sm" OnClick="btnLogout_Click" CausesValidation="false">
                            <i class="fa-solid fa-right-from-bracket me-1"></i> Logout
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </nav>

        <div class="container mt-5 pb-5">
            <div class="welcome-section">
                <h1>Hello, <asp:Literal ID="litUsernameWelcome" runat="server"></asp:Literal>!</h1>
                <p class="lead mb-0">Welcome back to the Event Management System. What would you like to do today?</p>
                <i class="fa-solid fa-calendar-days bg-icon"></i>
            </div>

            <!-- Statistics Section -->
            <div class="row g-4 mb-5 pb-4">
                <div class="col-md-4">
                    <div class="stat-card shadow-sm rounded-3">
                        <div class="stat-icon bg-primary-subtle text-primary">
                            <i class="fa-solid fa-calendar-star"></i>
                        </div>
                        <div class="stat-value"><asp:Literal ID="litTotalEvents" runat="server"></asp:Literal></div>
                        <div class="stat-label">Total Events</div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card shadow-sm rounded-3">
                        <div class="stat-icon bg-info-subtle text-info">
                            <i class="fa-solid fa-ticket"></i>
                        </div>
                        <div class="stat-value"><asp:Literal ID="litTotalUsers" runat="server"></asp:Literal></div>
                        <div class="stat-label">
                            <asp:Literal ID="litBookingsLabel" runat="server" Text="Total Bookings"></asp:Literal>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card shadow-sm rounded-3">
                        <div class="stat-icon bg-success-subtle text-success">
                            <i class="fa-solid fa-circle-check"></i>
                        </div>
                        <div class="stat-value"><asp:Literal ID="litBookingScope" runat="server"></asp:Literal></div>
                        <div class="stat-label">Booking Scope</div>
                    </div>
                </div>
            </div>

            <div class="row g-4 justify-content-center pb-5">
                <asp:PlaceHolder ID="phAdminCard" runat="server" Visible="false">
                    <div class="col-md-4">
                        <div class="card card-menu p-4 shadow-sm rounded-3">
                            <div class="card-icon icon-admin">
                                <i class="fa-solid fa-screwdriver-wrench"></i>
                            </div>
                            <h4 class="fw-bold">Admin Management</h4>
                            <p class="text-muted mb-4">Access administrative tools to create, update, and remove events from the platform. Monitor event details and maintain the database.</p>
                            <a href="Admin/ManageEvents.aspx" class="btn-action btn-admin">
                                <i class="fa-solid fa-gears me-2"></i> Manage All Events
                            </a>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card card-menu p-4 shadow-sm rounded-3">
                            <div class="card-icon icon-admin" style="background: rgba(13, 110, 253, 0.1); color: #0d6efd;">
                                <i class="fa-solid fa-user-shield"></i>
                            </div>
                            <h4 class="fw-bold">User Access</h4>
                            <p class="text-muted mb-4">Manage platform users, update credentials, and assign roles. Ensure the right people have the right access to the EMS portal.</p>
                            <a href="Admin/ManageUsers.aspx" class="btn-action btn-admin" style="background: #0d6efd;">
                                <i class="fa-solid fa-users-cog me-2"></i> Manage Users
                            </a>
                        </div>
                    </div>
                </asp:PlaceHolder>

                <asp:PlaceHolder ID="phUserCard" runat="server" Visible="false">
                    <div class="col-md-5">
                        <div class="card card-menu p-4 shadow-sm rounded-3">
                            <div class="card-icon icon-user">
                                <i class="fa-solid fa-compass"></i>
                            </div>
                            <h4 class="fw-bold">Explore Events</h4>
                            <p class="text-muted mb-4">Discover upcoming conferences, workshops, and meetups. Search by name or location to find the events that interest you most.</p>
                            <a href="User/BrowseEvents.aspx" class="btn-action btn-user">
                                <i class="fa-solid fa-magnifying-glass me-2"></i> Browse & Book
                            </a>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <div class="card card-menu p-4 shadow-sm rounded-3">
                            <div class="card-icon icon-user" style="background: rgba(255, 193, 7, 0.1); color: #ffc107;">
                                <i class="fa-solid fa-ticket"></i>
                            </div>
                            <h4 class="fw-bold">My Bookings</h4>
                            <p class="text-muted mb-4">View your registered events, check dates and locations, and manage your personal event calendar with ease.</p>
                            <a href="User/MyBookings.aspx" class="btn-action btn-user" style="background: #ffc107;">
                                <i class="fa-solid fa-list me-2"></i> View My Tickets
                            </a>
                        </div>
                    </div>
                </asp:PlaceHolder>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
