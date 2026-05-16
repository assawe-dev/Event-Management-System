<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageEvents.aspx.cs" Inherits="Admin_ManageEvents" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Events | EMS Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <script type="text/javascript">
        function validateEvent() {
            var eventName = document.getElementById('<%= txtEventName.ClientID %>').value.trim();
            var eventDate = document.getElementById('<%= txtEventDate.ClientID %>').value.trim();
            var location = document.getElementById('<%= txtLocation.ClientID %>').value.trim();
            var capacity = document.getElementById('<%= txtCapacity.ClientID %>').value.trim();
            var available = document.getElementById('<%= txtAvailableSeats.ClientID %>').value.trim();

            if (eventName === "") {
                alert("Event Name is required!");
                return false;
            }

            if (eventDate === "") {
                alert("Event Date is required!");
                return false;
            }

            if (location === "") {
                alert("Location is required!");
                return false;
            }

            if (capacity === "" || isNaN(capacity) || parseInt(capacity) <= 0) {
                alert("Capacity must be a positive number!");
                return false;
            }

            if (available === "" || isNaN(available) || parseInt(available) < 0) {
                alert("Available Seats must be a non-negative number!");
                return false;
            }

            if (parseInt(available) > parseInt(capacity)) {
                alert("Available Seats cannot exceed Capacity!");
                return false;
            }

            return true;
        }
    </script>
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
        .form-section { background: white; padding: 25px; margin-bottom: 30px; }

        .table { background: white; border-radius: 15px; overflow: hidden; }
        .table thead { background: #f8f9fa; }
        .table th { border: none; font-weight: 600; color: #495057; text-transform: uppercase; font-size: 0.8rem; letter-spacing: 0.5px; padding: 15px; }
        .table td { vertical-align: middle; padding: 15px; border-top: 1px solid #f1f3f5; }

        .btn { border-radius: 10px; font-weight: 600; padding: 8px 20px; transition: 0.3s; }
        .btn-primary { background: var(--primary); border: none; }
        .btn-primary:hover { background: var(--secondary); transform: translateY(-2px); }

        .search-box { max-width: 500px; }
        .search-box .form-control { border-radius: 10px 0 0 10px; border-right: none; }
        .search-box .btn { border-radius: 0 10px 10px 0; }

        .validation-error { font-size: 0.8rem; display: block; margin-top: 5px; }
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
                            <a class="nav-link active" href="ManageEvents.aspx"><i class="fa-solid fa-list-check me-1"></i> Manage Events</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="ManageUsers.aspx"><i class="fa-solid fa-users me-1"></i> Manage Users</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="ViewBookings.aspx"><i class="fa-solid fa-ticket me-1"></i> View All Bookings</a>
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
                    <h2 class="fw-bold mb-1">Event Management</h2>
                    <p class="text-muted mb-0">Create, edit, and delete events</p>
                </div>
                <div class="search-box">
                    <div class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by name or location..."></asp:TextBox>
                        <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-primary" OnClick="btnSearch_Click" CausesValidation="false">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnClearSearch" runat="server" CssClass="btn btn-outline-secondary" OnClick="btnClearSearch_Click" CausesValidation="false">
                            <i class="fa-solid fa-xmark"></i>
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>

        <div class="container pb-5">
            <div class="card form-section mb-4 shadow-sm rounded-3 p-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h5 class="fw-bold text-primary mb-0">
                        <i class="fa-solid fa-pen-to-square me-2"></i>
                        <asp:Literal ID="litFormTitle" runat="server" Text="Add New Event"></asp:Literal>
                    </h5>
                    <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-outline-secondary btn-sm" OnClick="btnRefresh_Click" CausesValidation="false">
                        <i class="fa-solid fa-rotate me-1"></i> Refresh List
                    </asp:LinkButton>
                </div>
                <asp:HiddenField ID="hfEventId" runat="server" />
                <div class="row g-3">
                    <div class="col-md-3">
                        <label class="form-label fw-semibold small">Event Name</label>
                        <asp:TextBox ID="txtEventName" runat="server" CssClass="form-control" placeholder="e.g. Tech Summit 2025"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEventName" runat="server" ControlToValidate="txtEventName"
                            ErrorMessage="Name is required" CssClass="text-danger validation-error" Display="Dynamic" ValidationGroup="EventForm" Enabled="false"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label fw-semibold small">Date</label>
                        <asp:TextBox ID="txtEventDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEventDate" runat="server" ControlToValidate="txtEventDate"
                            ErrorMessage="Date is required" CssClass="text-danger validation-error" Display="Dynamic" ValidationGroup="EventForm" Enabled="false"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="cvEventDate" runat="server" ControlToValidate="txtEventDate"
                            Operator="DataTypeCheck" Type="Date" ErrorMessage="Invalid date"
                            CssClass="text-danger validation-error" Display="Dynamic" ValidationGroup="EventForm" Enabled="false"></asp:CompareValidator>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-semibold small">Location</label>
                        <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" placeholder="e.g. San Francisco, CA"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvLocation" runat="server" ControlToValidate="txtLocation"
                            ErrorMessage="Location is required" CssClass="text-danger validation-error" Display="Dynamic" ValidationGroup="EventForm" Enabled="false"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-1">
                        <label class="form-label fw-semibold small">Capacity</label>
                        <asp:TextBox ID="txtCapacity" runat="server" CssClass="form-control" placeholder="0"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCapacity" runat="server" ControlToValidate="txtCapacity"
                            ErrorMessage="Required" CssClass="text-danger validation-error" Display="Dynamic" ValidationGroup="EventForm" Enabled="false"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="rvCapacity" runat="server" ControlToValidate="txtCapacity"
                            MinimumValue="0" MaximumValue="1000000" Type="Integer" ErrorMessage="Invalid"
                            CssClass="text-danger validation-error" Display="Dynamic" ValidationGroup="EventForm" Enabled="false"></asp:RangeValidator>
                    </div>
                    <div class="col-md-1">
                        <label class="form-label fw-semibold small">Available</label>
                        <asp:TextBox ID="txtAvailableSeats" runat="server" CssClass="form-control" placeholder="0"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvAvailable" runat="server" ControlToValidate="txtAvailableSeats"
                            ErrorMessage="Required" CssClass="text-danger validation-error" Display="Dynamic" ValidationGroup="EventForm" Enabled="false"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="cvAvailable" runat="server" ControlToValidate="txtAvailableSeats"
                            ControlToCompare="txtCapacity" Operator="LessThanEqual" Type="Integer"
                            ErrorMessage="Must be <= Capacity" CssClass="text-danger validation-error" Display="Dynamic" ValidationGroup="EventForm" Enabled="false"></asp:CompareValidator>
                    </div>
                    <div class="col-md-2 d-flex align-items-end gap-2">
                        <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-primary w-100" OnClick="btnSave_Click" ValidationGroup="EventForm" OnClientClick="return validateEvent();">
                             <i class="fa-solid fa-floppy-disk me-1"></i> Save
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-light w-100" OnClick="btnCancel_Click" CausesValidation="false">
                             <i class="fa-solid fa-xmark me-1"></i> Cancel
                        </asp:LinkButton>
                    </div>
                </div>
            </div>

            <div class="table-responsive shadow-sm rounded-3 overflow-hidden mb-5">
                <asp:GridView ID="gvEvents" runat="server" AutoGenerateColumns="False" CssClass="table table-hover table-striped align-middle mb-0"
                    OnRowCommand="gvEvents_RowCommand" DataKeyNames="EventID" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="EventID" HeaderText="ID" ItemStyle-CssClass="text-muted small" />
                        <asp:TemplateField HeaderText="Event Name">
                            <ItemTemplate>
                                <span class="fw-bold text-dark"><%# Eval("EventName") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date">
                            <ItemTemplate>
                                <span><i class="fa-regular fa-calendar me-1 text-primary"></i> <%# Convert.ToDateTime(Eval("EventDate")).ToString("MMM dd, yyyy") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Location">
                            <ItemTemplate>
                                <span><i class="fa-solid fa-location-dot me-1 text-danger"></i> <%# Eval("Location") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Capacity">
                            <ItemTemplate>
                                <span class="badge bg-info-subtle text-info border border-info-subtle">
                                    <%# Eval("Capacity") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Available">
                            <ItemTemplate>
                                <span class='badge <%# Convert.ToInt32(Eval("AvailableSeats")) > 0 ? "bg-success-subtle text-success border border-success-subtle" : "bg-danger-subtle text-danger border border-danger-subtle" %>'>
                                    <%# Eval("AvailableSeats") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditEvent"
                                    CommandArgument='<%# Eval("EventID") %>' CssClass="btn btn-sm btn-outline-warning me-1">
                                    <i class="fa-solid fa-pencil"></i> Edit
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteEvent"
                                    CommandArgument='<%# Eval("EventID") %>' CssClass="btn btn-sm btn-outline-danger"
                                    OnClientClick="return confirm('Are you sure you want to delete this event?');">
                                    <i class="fa-solid fa-trash-can"></i> Delete
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="p-5 text-center">
                            <i class="fa-solid fa-calendar-xmark fa-3x text-light mb-3"></i>
                            <h5 class="text-muted">No events found matching your criteria.</h5>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
