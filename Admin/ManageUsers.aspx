<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageUsers.aspx.cs" Inherits="Admin_ManageUsers" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users | EMS</title>
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
                        <li class="nav-item"><a class="nav-link active" href="ManageUsers.aspx">Users</a></li>
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
                    <h2 class="fw-bold mb-0">Directory Management</h2>
                    <p class="text-muted mb-0">Administer platform participants and credentials.</p>
                </div>
                <div class="d-flex gap-2" style="width: 400px;">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search directory..."></asp:TextBox>
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
                <h5 class="fw-bold mb-4"><asp:Literal ID="litFormTitle" runat="server"></asp:Literal></h5>
                <asp:HiddenField ID="hfUserId" runat="server" />
                <div class="row g-3">
                    <div class="col-md-3">
                        <label class="small fw-bold text-muted mb-2">Username</label>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <label class="small fw-bold text-muted mb-2">Security Credential</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <label class="small fw-bold text-muted mb-2">Identity (Full Name)</label>
                        <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-1">
                        <label class="small fw-bold text-muted mb-2">Role</label>
                        <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-select">
                            <asp:ListItem Text="User" Value="User"></asp:ListItem>
                            <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                            <asp:ListItem Text="Employee" Value="Employee"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-2 d-flex align-items-end gap-2">
                        <asp:LinkButton ID="btnSave" runat="server" CssClass="btn-accent w-100 text-center text-decoration-none" OnClick="btnSave_Click">Save</asp:LinkButton>
                        <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-dark w-100 rounded-3 border-secondary" OnClick="btnCancel_Click" CausesValidation="false">X</asp:LinkButton>
                    </div>
                </div>
            </div>

            <div class="table-container">
                <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle"
                    OnRowCommand="gvUsers_RowCommand" DataKeyNames="UserID" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="UserID" HeaderText="ID" ItemStyle-CssClass="text-muted small" />
                        <asp:TemplateField HeaderText="Identity Profile">
                            <ItemTemplate><div class="fw-bold"><%# Eval("FullName") %></div><div class="small text-muted">@<%# Eval("Username") %></div></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Access Level">
                            <ItemTemplate>
                                <span class='badge-role <%# Eval("Role").ToString() == "Admin" ? "role-admin" : "role-user" %>'>
                                    <%# Eval("Role") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Operations">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditUser" CommandArgument='<%# Eval("UserID") %>' CssClass="btn-outline-warning-custom me-2"><i class="fa-solid fa-pencil"></i></asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteUser" CommandArgument='<%# Eval("UserID") %>' CssClass="btn-outline-danger-custom" OnClientClick="return confirm('Confirm deletion?');"><i class="fa-solid fa-trash"></i></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        <div style="display:none">
            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" Enabled="false"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" Enabled="false"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="txtPassword" Enabled="false" ValidationExpression="^.{6,}$"></asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName" Enabled="false"></asp:RequiredFieldValidator>
        </div>
    </form>
</body>
</html>
