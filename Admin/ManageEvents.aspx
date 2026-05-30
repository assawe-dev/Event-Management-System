<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageEvents.aspx.cs" Inherits="Admin_ManageEvents" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Events | EMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="../StyleSheet.css" rel="stylesheet">
    <script type="text/javascript">
        function validateEvent() {
            var eventName = document.getElementById('<%= txtEventName.ClientID %>').value.trim();
            if (eventName === "") { alert("Event Name is required!"); return false; }
            return true;
        }
    </script>
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
                        <li class="nav-item"><a class="nav-link active" href="ManageEvents.aspx">Events</a></li>
                        <li class="nav-item"><a class="nav-link" href="ManageUsers.aspx">Users</a></li>
                        <li class="nav-item"><a class="nav-link" href="ViewBookings.aspx">Bookings</a></li>
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
                    <h2 class="fw-bold mb-0">Event Control Center</h2>
                    <p class="text-muted mb-0">Configure and monitor platform events.</p>
                </div>
                <div class="d-flex gap-2" style="width: 400px;">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Filter command..."></asp:TextBox>
                    <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-accent" OnClick="btnSearch_Click" CausesValidation="false">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnClearSearch" runat="server" CssClass="btn btn-dark rounded-3 border-secondary" OnClick="btnClearSearch_Click" CausesValidation="false">
                        <i class="fa-solid fa-xmark"></i>
                    </asp:LinkButton>
                </div>
            </div>
        </div>

        <div class="container pb-5">
            <div class="card-custom">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h5 class="fw-bold mb-0"><asp:Literal ID="litFormTitle" runat="server"></asp:Literal></h5>
                    <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-dark btn-sm rounded-3 border-secondary" OnClick="btnRefresh_Click" CausesValidation="false">
                        <i class="fa-solid fa-rotate"></i>
                    </asp:LinkButton>
                </div>
                <asp:HiddenField ID="hfEventId" runat="server" />
                <div class="row g-3">
                    <div class="col-md-3">
                        <label class="small fw-bold text-muted mb-2">Event Title</label>
                        <asp:TextBox ID="txtEventName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <label class="small fw-bold text-muted mb-2">Schedule</label>
                        <asp:TextBox ID="txtEventDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <label class="small fw-bold text-muted mb-2">Venue</label>
                        <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-1">
                        <label class="small fw-bold text-muted mb-2">Cap</label>
                        <asp:TextBox ID="txtCapacity" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-1">
                        <label class="small fw-bold text-muted mb-2">Avail</label>
                        <asp:TextBox ID="txtAvailableSeats" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-2 d-flex align-items-end gap-2">
                        <asp:LinkButton ID="btnSave" runat="server" CssClass="btn-accent w-100 text-center text-decoration-none" OnClick="btnSave_Click" OnClientClick="return validateEvent();">Save</asp:LinkButton>
                        <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-dark w-100 rounded-3 border-secondary" OnClick="btnCancel_Click" CausesValidation="false">X</asp:LinkButton>
                    </div>
                </div>
            </div>

            <div class="table-container">
                <asp:GridView ID="gvEvents" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle"
                    OnRowCommand="gvEvents_RowCommand" DataKeyNames="EventID" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="EventID" HeaderText="ID" ItemStyle-CssClass="text-muted small" />
                        <asp:TemplateField HeaderText="Event Specification">
                            <ItemTemplate><div class="fw-bold"><%# Eval("EventName") %></div><div class="small text-muted"><%# Eval("Location") %></div></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date"><ItemTemplate><%# Convert.ToDateTime(Eval("EventDate")).ToString("MMM dd, yyyy") %></ItemTemplate></asp:TemplateField>
                        <asp:BoundField DataField="Capacity" HeaderText="Cap" />
                        <asp:BoundField DataField="AvailableSeats" HeaderText="Avail" />
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditEvent" CommandArgument='<%# Eval("EventID") %>' CssClass="btn-outline-warning-custom me-2"><i class="fa-solid fa-pencil"></i></asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteEvent" CommandArgument='<%# Eval("EventID") %>' CssClass="btn-outline-danger-custom" OnClientClick="return confirm('Confirm deletion?');"><i class="fa-solid fa-trash"></i></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        <%-- Preserving validators but keeping them hidden as per SaaS aesthetic --%>
        <div style="display:none">
            <asp:RequiredFieldValidator ID="rfvEventName" runat="server" ControlToValidate="txtEventName" Enabled="false"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="rfvEventDate" runat="server" ControlToValidate="txtEventDate" Enabled="false"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="rfvLocation" runat="server" ControlToValidate="txtLocation" Enabled="false"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="rfvCapacity" runat="server" ControlToValidate="txtCapacity" Enabled="false"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="rfvAvailable" runat="server" ControlToValidate="txtAvailableSeats" Enabled="false"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="cvEventDate" runat="server" ControlToValidate="txtEventDate" Enabled="false"></asp:CompareValidator>
            <asp:RangeValidator ID="rvCapacity" runat="server" ControlToValidate="txtCapacity" Enabled="false"></asp:RangeValidator>
            <asp:CompareValidator ID="cvAvailable" runat="server" ControlToValidate="txtAvailableSeats" Enabled="false"></asp:CompareValidator>
        </div>
    </form>
</body>
</html>
