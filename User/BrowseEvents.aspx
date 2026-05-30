<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BrowseEvents.aspx.cs" Inherits="User_BrowseEvents" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Events | EMS</title>
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
        .nav-link { color: var(--text-muted) !important; font-weight: 500; transition: all 0.2s; margin: 0 0.5rem; }
        .nav-link:hover, .nav-link.active { color: var(--accent) !important; }

        .hero-section {
            background: linear-gradient(rgba(15, 17, 21, 0.8), rgba(15, 17, 21, 0.8)), url('https://images.unsplash.com/photo-1540575861501-7ad05823c9f5?auto=format&fit=crop&q=80&w=1470');
            background-size: cover; background-position: center; padding: 6rem 0; margin-bottom: 2rem;
        }

        .search-container {
            background-color: var(--card-dark);
            border: 1px solid #374151;
            padding: 1.5rem; border-radius: 1.25rem;
            margin-top: -4rem; position: relative; z-index: 10;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.3);
        }

        .form-control {
            background-color: #0f1115; border: 1px solid #374151; color: white;
            border-radius: 0.75rem; padding: 0.75rem 1rem;
        }
        .form-control:focus { background-color: #0f1115; color: white; border-color: var(--accent); box-shadow: none; }

        .event-card {
            background-color: var(--card-dark); border: 1px solid #374151;
            border-radius: 1.25rem; overflow: hidden; height: 100%;
            transition: all 0.3s;
        }
        .event-card:hover { transform: translateY(-8px); border-color: var(--accent); }

        .event-img {
            height: 180px; background-color: #2d3139;
            display: flex; align-items: center; justify-content: center;
            font-size: 3rem; color: #374151; position: relative;
        }

        .seats-badge {
            position: absolute; top: 1rem; right: 1rem;
            background-color: rgba(99, 102, 241, 0.9);
            color: white; padding: 0.25rem 0.75rem;
            border-radius: 9999px; font-size: 0.75rem; font-weight: 700;
        }

        .event-body { padding: 1.5rem; }
        .event-date { color: var(--accent); font-weight: 700; font-size: 0.8rem; text-transform: uppercase; margin-bottom: 0.5rem; display: block; }
        .event-title { font-weight: 700; font-size: 1.1rem; color: white; margin-bottom: 1rem; line-height: 1.4; }
        .event-meta { color: var(--text-muted); font-size: 0.875rem; margin-bottom: 0.25rem; }

        .btn-book {
            background-color: var(--accent); color: white; width: 100%;
            border-radius: 0.75rem; padding: 0.6rem; font-weight: 600;
            border: none; margin-top: 1rem; transition: 0.2s;
        }
        .btn-book:hover { background-color: #4f46e5; transform: scale(1.02); color: white; }

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
                        <li class="nav-item"><a class="nav-link active" href="BrowseEvents.aspx">Browse</a></li>
                        <li class="nav-item"><a class="nav-link" href="MyBookings.aspx">My Tickets</a></li>
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

        <section class="hero-section text-center">
            <div class="container">
                <h1 class="display-4 fw-bold text-white mb-2">Discovery Portal</h1>
                <p class="lead text-muted">Register for elite industry conferences and networking events.</p>
            </div>
        </section>

        <div class="container">
            <div class="search-container">
                <div class="row g-2">
                    <div class="col-md-9">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by name, venue, or city..."></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <asp:Button ID="btnSearch" runat="server" Text="Filter" CssClass="btn btn-primary w-100 h-100 rounded-3" style="background-color: var(--accent); border:none;" OnClick="btnSearch_Click" />
                    </div>
                    <div class="col-md-1">
                        <asp:LinkButton ID="btnClear" runat="server" CssClass="btn btn-outline-secondary w-100 h-100 rounded-3" OnClick="btnClear_Click">
                            <i class="fa-solid fa-rotate-left"></i>
                        </asp:LinkButton>
                    </div>
                </div>
            </div>

            <asp:Repeater ID="rptEvents" runat="server" OnItemCommand="rptEvents_ItemCommand">
                <HeaderTemplate><div class="row g-4 mt-2"></HeaderTemplate>
                <ItemTemplate>
                    <div class="col-md-4 mb-4">
                        <div class="event-card">
                            <div class="event-img">
                                <i class="fa-solid fa-layer-group"></i>
                                <div class="seats-badge"><%# Eval("AvailableSeats") %> Slots</div>
                            </div>
                            <div class="event-body">
                                <span class="event-date"><%# Convert.ToDateTime(Eval("EventDate")).ToString("MMM dd, yyyy") %></span>
                                <h5 class="event-title"><%# Eval("EventName") %></h5>
                                <div class="event-meta"><i class="fa-solid fa-location-dot me-2"></i><%# Eval("Location") %></div>
                                <asp:LinkButton ID="btnBook" runat="server" CssClass="btn-book" CommandName="Book" CommandArgument='<%# Eval("EventID") %>'>
                                    Reserve Spot
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
                <FooterTemplate>
                    </div>
                    <asp:PlaceHolder ID="phEmpty" runat="server" Visible='<%# rptEvents.Items.Count == 0 %>'>
                        <div class="text-center py-5">
                            <i class="fa-solid fa-ghost fa-3x text-muted opacity-25 mb-3"></i>
                            <h4 class="text-muted">No Available Events Found</h4>
                        </div>
                    </asp:PlaceHolder>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
