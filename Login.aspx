<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | EMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="StyleSheet.css" rel="stylesheet">
    <script type="text/javascript">
        function validateLogin() {
            var username = document.getElementById('<%= txtUsername.ClientID %>').value.trim();
            var password = document.getElementById('<%= txtPassword.ClientID %>').value.trim();
            if (username === "") { alert("Username is required!"); return false; }
            if (password === "") { alert("Password is required!"); return false; }
            return true;
        }
    </script>
</head>
<body>
    <script src="ThemeScript.js"></script>
    <form id="form1" runat="server">
        <button type="button" id="themeToggle" class="theme-toggle-floating">
            <i class="fa-solid fa-moon"></i>
        </button>
        <div class="login-card">
            <div class="text-center mb-4">
                <div class="brand-logo">
                    <i class="fa-solid fa-bolt"></i>
                </div>
                <h3 class="fw-bold">Welcome Back</h3>
                <p class="text-muted small">Sign in to manage your premium events</p>
            </div>

            <div class="mb-3">
                <label class="form-label">Username</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-user-ninja"></i></span>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="username"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" Display="Dynamic" Enabled="false"></asp:RequiredFieldValidator>
            </div>

            <div class="mb-4">
                <label class="form-label">Password</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-shield-halved"></i></span>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="••••••••"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" Display="Dynamic" Enabled="false"></asp:RequiredFieldValidator>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Access Dashboard" CssClass="btn btn-primary w-100 mb-3" OnClick="btnLogin_Click" OnClientClick="return validateLogin();" />

            <div class="text-center mb-4">
                <p class="text-muted small">New here? <a href="Register.aspx" class="text-decoration-none fw-semibold" style="color: var(--accent);">Create an account</a></p>
            </div>

            <div class="p-3 rounded-4" style="background-color: var(--bg-input); border: 1px solid var(--border-color);">
                <div class="d-flex align-items-center mb-2">
                    <span class="demo-badge me-2">DEMO</span>
                    <span class="text-muted x-small fw-bold" style="font-size: 0.7rem; text-transform: uppercase;">Quick Access</span>
                </div>
                <div class="d-flex justify-content-between small">
                    <span class="text-muted">Admin: <code style="color: #818cf8;">admin / admin123</code></span>
                </div>
                <div class="d-flex justify-content-between small">
                    <span class="text-muted">User: <code style="color: #818cf8;">user / user123</code></span>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
