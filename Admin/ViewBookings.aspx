<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewBookings.aspx.cs" Inherits="Admin_ViewBookings" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Bookings | EMS Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4361ee;
            --secondary: #3f37c9;
            --bg: #f4f7fe;
        }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg); }

        .navbar { box-shadow: 0 2px 15px rgba(0,0,0,0.1); padding: 15px 0; }
        .navbar-brand { font-weight: 700; color: white !important; }
        .nav-link { font-weight: 500; color: rgba(255,255,255,0.7) !important; margin: 0 10px; }
        .nav-link:hover, .nav-link.active { color: white !important; }

        .page-header { background: white; padding: 30px 0; border-bottom: 1px solid #e9ecef; margin-bottom: 30px; }
        .card { border: none; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); }
        .stats-card { background: linear-gradient(135deg, var(--primary) 0%, #4cc9f0 100%); color: white; padding: 20px; border-radius: 15px; }

        .table { background: white; border-radius: 15px; overflow: hidden; }
        .table thead { background: #f8f9fa; }
        .table th { border: none; font-weight: 600; color: #495057; text-transform: uppercase; font-size: 0.8rem; letter-spacing: 0.5px; padding: 15px; }
        .table td { vertical-align: middle; padding: 15px; border-top: 1px solid #f1f3f5; }

        .btn { border-radius: 10px; font-weight: 600; padding: 8px 20px; transition: 0.3s; }
        .btn-primary { background: var(--primary); border: none; }

        .filter-section { background: white; padding: 20px; border-radius: 15px; margin-bottom: 25px; }
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
                        <li class="nav-item">
                            <a class="nav-link" href="ManageEvents.aspx"><i class="fa-solid fa-list-check me-1"></i> Manage Events</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="ManageUsers.aspx"><i class="fa-solid fa-users me-1"></i> Manage Users</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="ViewBookings.aspx"><i class="fa-solid fa-ticket me-1"></i> View All Bookings</a>
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

        <div class="page-header">
            <div class="container d-flex justify-content-between align-items-center">
                <div>
                    <h2 class="fw-bold mb-1">Booking Management</h2>
                    <p class="text-muted mb-0">Monitor all event registrations</p>
                </div>
                <div class="stats-card shadow-sm">
                    <div class="d-flex align-items-center">
                        <div class="me-3">
                            <i class="fa-solid fa-ticket-simple fa-2x opacity-50"></i>
                        </div>
                        <div>
                            <h6 class="mb-0 small text-uppercase fw-bold opacity-75">Total Booked Tickets</h6>
                            <h3 class="mb-0 fw-bold"><asp:Label ID="lblTotalBookings" runat="server" Text="0"></asp:Label></h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="container pb-5">
            <div class="filter-section shadow-sm">
                <div class="row g-3 align-items-end">
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-secondary">Filter by Event</label>
                        <asp:DropDownList ID="ddlEvents" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged">
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-5">
                        <label class="form-label small fw-bold text-secondary">Search by User Full Name</label>
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                            <asp:TextBox ID="txtUserSearch" runat="server" CssClass="form-control border-start-0" placeholder="Enter user's name..." AutoPostBack="true" OnTextChanged="FilterChanged"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <asp:LinkButton ID="btnClearFilters" runat="server" CssClass="btn btn-outline-secondary w-100" OnClick="btnClearFilters_Click">
                            <i class="fa-solid fa-filter-circle-xmark me-1"></i> Clear Filters
                        </asp:LinkButton>
                    </div>
                </div>
            </div>

            <div class="table-responsive shadow-sm rounded-3 overflow-hidden mb-5">
                <asp:GridView ID="gvBookings" runat="server" AutoGenerateColumns="False" CssClass="table table-hover table-striped align-middle mb-0"
                    GridLines="None">
                    <Columns>
                        <asp:TemplateField HeaderText="Event Name">
                            <ItemTemplate>
                                <div class="d-flex align-items-center">
                                    <div class="bg-primary-subtle text-primary rounded-circle p-2 me-3" style="width: 35px; height: 35px; display: flex; align-items: center; justify-content: center;">
                                        <i class="fa-solid fa-calendar-day small"></i>
                                    </div>
                                    <span class="fw-bold text-dark"><%# Eval("EventName") %></span>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="User Full Name">
                            <ItemTemplate>
                                <span><i class="fa-solid fa-user me-2 text-secondary"></i><%# Eval("FullName") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Booking Date">
                            <ItemTemplate>
                                <span class="text-muted"><i class="fa-regular fa-clock me-1"></i> <%# Convert.ToDateTime(Eval("BookingDate")).ToString("MMM dd, yyyy HH:mm") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="p-5 text-center">
                            <i class="fa-solid fa-ticket-slash fa-3x text-light mb-3"></i>
                            <h5 class="text-muted">No bookings found.</h5>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
