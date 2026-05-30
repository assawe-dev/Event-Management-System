<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewBookings.aspx.cs" Inherits="Admin_ViewBookings" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Bookings | EMS</title>
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
                        <li class="nav-item"><a class="nav-link" href="ManageEvents.aspx">Events</a></li>
                        <li class="nav-item"><a class="nav-link" href="ManageUsers.aspx">Users</a></li>
                        <li class="nav-item"><a class="nav-link active" href="ViewBookings.aspx">Bookings</a></li>
                    </ul>
                    <div class="d-flex align-items-center">
                        <button type="button" id="themeToggle" class="theme-toggle">
                            <i class="fa-solid fa-moon"></i>
                        </button>
                        <span class="me-3 text-muted small fw-bold"><asp:Literal ID="litUsernameNav" runat="server"></asp:Literal></span>
                        <asp:LinkButton ID="btnLogout" runat="server" CssClass="btn btn-logout btn-sm px-3" OnClick="btnLogout_Click" CausesValidation="false">
                            <i class="fa-solid fa-power-off"></i>
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </nav>

        <div class="page-header">
            <div class="container d-flex justify-content-between align-items-center">
                <div>
                    <h2 class="fw-bold mb-0">Booking Manifest</h2>
                    <p class="text-muted mb-0">Audit and verify all platform registrations.</p>
                </div>
                <div class="stats-badge">
                    <div class="small text-muted fw-bold">TOTAL VOLUME</div>
                    <div class="h3 fw-bold mb-0"><asp:Label ID="lblTotalBookings" runat="server" Text="0"></asp:Label></div>
                </div>
            </div>
        </div>

        <div class="container pb-5">
            <div class="card-custom">
                <div class="row g-3 align-items-end">
                    <div class="col-md-4">
                        <label class="small fw-bold text-muted mb-2">Event Filter</label>
                        <asp:DropDownList ID="ddlEvents" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged"></asp:DropDownList>
                    </div>
                    <div class="col-md-5">
                        <label class="small fw-bold text-muted mb-2">Search Participant</label>
                        <asp:TextBox ID="txtUserSearch" runat="server" CssClass="form-control" placeholder="Identity name..." AutoPostBack="true" OnTextChanged="FilterChanged"></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <asp:LinkButton ID="btnClearFilters" runat="server" CssClass="btn btn-dark w-100 rounded-3 border-secondary h-100 py-2" OnClick="btnClearFilters_Click">Reset Filters</asp:LinkButton>
                    </div>
                </div>
            </div>

            <div class="table-container">
                <asp:GridView ID="gvBookings" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle" GridLines="None">
                    <Columns>
                        <asp:TemplateField HeaderText="Event Specification">
                            <ItemTemplate><div class="fw-bold"><%# Eval("EventName") %></div></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Participant Identity">
                            <ItemTemplate><span><i class="fa-solid fa-user-tag me-2 text-accent"></i><%# Eval("FullName") %></span></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Timestamp">
                            <ItemTemplate><span class="text-muted small"><%# Convert.ToDateTime(Eval("BookingDate")).ToString("MMM dd, yyyy HH:mm") %></span></ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
