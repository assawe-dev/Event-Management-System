<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BrowseEvents.aspx.cs" Inherits="User_BrowseEvents" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Events | EMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4361ee;
            --bg: #f8f9fa;
        }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg); }

        .navbar { background: white; box-shadow: 0 2px 15px rgba(0,0,0,0.05); padding: 15px 0; }
        .navbar-brand { font-weight: 700; color: var(--primary); }
        .nav-link { font-weight: 500; color: #6c757d; margin: 0 10px; }
        .nav-link:hover, .nav-link.active { color: var(--primary); }

        .hero-section { background: linear-gradient(rgba(67, 97, 238, 0.8), rgba(67, 97, 238, 0.8)), url('https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?auto=format&fit=crop&q=80&w=1470&ixlib=rb-4.0.3'); background-size: cover; background-position: center; padding: 100px 0; color: white; margin-bottom: 50px; }
        .search-container { background: white; padding: 20px; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); margin-top: -50px; position: relative; z-index: 10; }

        .event-card { border: none; border-radius: 20px; overflow: hidden; transition: 0.3s; height: 100%; box-shadow: 0 5px 15px rgba(0,0,0,0.05); background: white; }
        .event-card:hover { transform: translateY(-10px); box-shadow: 0 15px 35px rgba(0,0,0,0.1); }
        .event-img { height: 200px; background: #e9ecef; display: flex; align-items: center; justify-content: center; color: #dee2e6; font-size: 4rem; position: relative; }
        .price-tag { position: absolute; top: 15px; right: 15px; background: white; padding: 5px 15px; border-radius: 50px; font-weight: 700; color: var(--primary); box-shadow: 0 5px 10px rgba(0,0,0,0.1); }

        .event-body { padding: 25px; }
        .event-date { color: var(--primary); font-weight: 700; font-size: 0.9rem; text-transform: uppercase; margin-bottom: 10px; display: block; }
        .event-title { font-weight: 700; font-size: 1.25rem; margin-bottom: 15px; color: #212529; height: 3rem; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; }
        .event-info { color: #6c757d; font-size: 0.95rem; margin-bottom: 5px; }

        .btn-view { border-radius: 10px; font-weight: 600; padding: 10px; width: 100%; border: 2px solid #f1f3f5; color: #495057; transition: 0.3s; }
        .btn-view:hover { background: var(--primary); border-color: var(--primary); color: white; }

        .empty-state { padding: 100px 0; text-align: center; color: #adb5bd; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg sticky-top">
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
                            <a class="nav-link active" href="BrowseEvents.aspx"><i class="fa-solid fa-magnifying-glass me-1"></i> Browse Events</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="MyBookings.aspx"><i class="fa-solid fa-ticket me-1"></i> My Bookings</a>
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

        <section class="hero-section text-center">
            <div class="container">
                <h1 class="display-4 fw-bold mb-3">Discover Amazing Events</h1>
                <p class="lead opacity-75">Find and book the best events happening around you.</p>
            </div>
        </section>

        <div class="container">
            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fa-solid fa-circle-check me-2"></i>
                <asp:Literal ID="litMessage" runat="server"></asp:Literal>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </asp:Panel>

            <div class="search-container mb-5">
                <div class="row g-3">
                    <div class="col-md-9">
                        <div class="input-group">
                            <span class="input-group-text bg-transparent border-end-0 text-muted"><i class="fa-solid fa-magnifying-glass"></i></span>
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control border-start-0 ps-0" placeholder="Search by name, category or location..."></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="d-flex gap-2">
                            <asp:Button ID="btnSearch" runat="server" Text="Search Events" CssClass="btn btn-primary w-100 py-2 fw-bold" OnClick="btnSearch_Click" CausesValidation="false" />
                            <asp:LinkButton ID="btnClear" runat="server" CssClass="btn btn-outline-secondary px-3" OnClick="btnClear_Click" CausesValidation="false">
                                <i class="fa-solid fa-rotate-left"></i>
                            </asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>

            <asp:Repeater ID="rptEvents" runat="server" OnItemCommand="rptEvents_ItemCommand">
                <HeaderTemplate>
                    <div class="row g-4">
                </HeaderTemplate>
                <ItemTemplate>
                    <div class="col-md-4 mb-4">
                        <div class="event-card">
                            <div class="event-img">
                                <i class="fa-solid fa-image"></i>
                                <div class="price-tag">
                                    <%# Convert.ToInt32(Eval("AvailableSeats")) > 0 ? Eval("AvailableSeats") + " Left" : "SOLD OUT" %>
                                </div>
                            </div>
                            <div class="event-body">
                                <span class="event-date">
                                    <i class="fa-regular fa-calendar-days me-1"></i>
                                    <%# Convert.ToDateTime(Eval("EventDate")).ToString("ddd, MMM dd • h:mm tt") %>
                                </span>
                                <h5 class="event-title"><%# Eval("EventName") %></h5>
                                <p class="event-info">
                                    <i class="fa-solid fa-location-dot me-1 text-danger"></i>
                                    <%# Eval("Location") %>
                                </p>
                                <div class="mt-4">
                                    <asp:LinkButton ID="btnBook" runat="server" CssClass="btn btn-view" CommandName="Book" CommandArgument='<%# Eval("EventID") %>'>
                                        <i class="fa-solid fa-ticket me-1"></i> Book Now
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
                <FooterTemplate>
                    </div>
                    <asp:PlaceHolder ID="phEmpty" runat="server" Visible='<%# rptEvents.Items.Count == 0 %>'>
                        <div class="empty-state">
                            <i class="fa-solid fa-calendar-xmark fa-4x mb-4"></i>
                            <h3>No events found</h3>
                            <p>Try adjusting your search filters to find what you're looking for.</p>
                        </div>
                    </asp:PlaceHolder>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
