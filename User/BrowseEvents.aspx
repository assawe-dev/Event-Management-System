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
    <link href="../StyleSheet.css" rel="stylesheet">
</head>
<body>
    <script src="../ThemeScript.js"></script>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg sticky-top">
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
                        <button type="button" id="themeToggle" class="theme-toggle">
                            <i class="fa-solid fa-moon"></i>
                        </button>
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
                        <asp:Button ID="btnSearch" runat="server" Text="Filter" CssClass="btn btn-primary w-100 h-100 rounded-3" OnClick="btnSearch_Click" />
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
