<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageUsers.aspx.cs" Inherits="Admin_ManageUsers" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users | EMS Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <script type="text/javascript">
        function validateUser() {
            var username = document.getElementById('<%= txtUsername.ClientID %>').value.trim();
            var password = document.getElementById('<%= txtPassword.ClientID %>').value.trim();
            var fullName = document.getElementById('<%= txtFullName.ClientID %>').value.trim();

            if (username === "") {
                alert("Username is required!");
                return false;
            }

            if (password === "") {
                alert("Password is required!");
                return false;
            }
            if (password.length < 6) {
                alert("Password must be at least 6 characters long!");
                return false;
            }

            if (fullName === "") {
                alert("Full Name is required!");
                return false;
            }
            var nameRegex = /^[a-zA-Z\s]+$/;
            if (!nameRegex.test(fullName)) {
                alert("Full Name must contain letters only!");
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
                            <a class="nav-link" href="ManageEvents.aspx"><i class="fa-solid fa-list-check me-1"></i> Manage Events</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="ManageUsers.aspx"><i class="fa-solid fa-users me-1"></i> Manage Users</a>
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
                    <h2 class="fw-bold mb-1">User Management</h2>
                    <p class="text-muted mb-0">Add, Edit and Delete platform users</p>
                </div>
                <div class="search-box">
                    <div class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by username..."></asp:TextBox>
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
                <h5 class="fw-bold mb-4 text-primary">
                    <i class="fa-solid fa-user-plus me-2"></i>
                    <asp:Literal ID="litFormTitle" runat="server" Text="Add New User"></asp:Literal>
                </h5>
                <asp:HiddenField ID="hfUserId" runat="server" />
                <div class="row g-3">
                    <div class="col-md-3">
                        <label class="form-label fw-semibold small">Username</label>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="e.g. john_doe"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername"
                            ErrorMessage="Username is required" CssClass="text-danger validation-error" Display="Dynamic" ValidationGroup="UserForm" Enabled="false"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-semibold small">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="SingleLine" placeholder="Enter password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                            ErrorMessage="Password is required" CssClass="text-danger validation-error" Display="Dynamic" ValidationGroup="UserForm" Enabled="false"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="txtPassword"
                            ErrorMessage="Min. 6 characters" ValidationExpression="^.{6,}$"
                            CssClass="text-danger validation-error" Display="Dynamic" ValidationGroup="UserForm" Enabled="false"></asp:RegularExpressionValidator>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-semibold small">Full Name</label>
                        <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="e.g. John Doe"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName"
                            ErrorMessage="Full Name is required" CssClass="text-danger validation-error" Display="Dynamic" ValidationGroup="UserForm" Enabled="false"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-1">
                        <label class="form-label fw-semibold small">Role</label>
                        <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-select">
                            <asp:ListItem Text="User" Value="User"></asp:ListItem>
                            <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                            <asp:ListItem Text="Employee" Value="Employee"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-2 d-flex align-items-end gap-2">
                        <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-primary w-100" OnClick="btnSave_Click" ValidationGroup="UserForm" OnClientClick="return validateUser();">
                            <i class="fa-solid fa-floppy-disk me-1"></i> Save
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-light w-100" OnClick="btnCancel_Click" CausesValidation="false">
                            <i class="fa-solid fa-xmark me-1"></i> Cancel
                        </asp:LinkButton>
                    </div>
                </div>
            </div>

            <div class="table-responsive shadow-sm rounded-3 overflow-hidden mb-5">
                <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="table table-hover table-striped align-middle mb-0"
                    OnRowCommand="gvUsers_RowCommand" DataKeyNames="UserID" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="UserID" HeaderText="ID" ItemStyle-CssClass="text-muted small" />
                        <asp:TemplateField HeaderText="Username">
                            <ItemTemplate>
                                <span class="fw-bold text-dark"><%# Eval("Username") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Full Name">
                            <ItemTemplate>
                                <span><%# Eval("FullName") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Role">
                            <ItemTemplate>
                                <span class='badge <%# Eval("Role").ToString() == "Admin" ? "bg-primary" : (Eval("Role").ToString() == "Employee" ? "bg-info" : "bg-secondary") %>'>
                                    <%# Eval("Role") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditUser"
                                    CommandArgument='<%# Eval("UserID") %>' CssClass="btn btn-sm btn-outline-warning me-1">
                                    <i class="fa-solid fa-pencil"></i> Edit
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteUser"
                                    CommandArgument='<%# Eval("UserID") %>' CssClass="btn btn-sm btn-outline-danger"
                                    OnClientClick="return confirm('Are you sure you want to delete this user?');">
                                    <i class="fa-solid fa-trash-can"></i> Delete
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="p-5 text-center">
                            <i class="fa-solid fa-user-slash fa-3x text-light mb-3"></i>
                            <h5 class="text-muted">No users found matching your criteria.</h5>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
