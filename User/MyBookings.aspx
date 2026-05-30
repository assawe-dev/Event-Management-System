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
                        <li class="nav-item"><a class="nav-link" href="BrowseEvents.aspx">Browse</a></li>
                        <li class="nav-item"><a class="nav-link active" href="MyBookings.aspx">My Tickets</a></li>
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

        <div class="container page-header">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h2 class="fw-bold mb-1">My Registrations</h2>
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
                                <div class="fw-medium"><%# Convert.ToDateTime(Eval("EventDate")).ToString("MMM dd, yyyy") %></div>
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
                            <a href="BrowseEvents.aspx" class="btn btn-sm btn-primary mt-2">Explore Catalogue</a>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
