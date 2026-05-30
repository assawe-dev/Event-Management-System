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
    <style>
        :root {
            --bg-dark: #0f1115;
            --card-dark: #1c1f26;
            --accent: #6366f1;
            --accent-hover: #4f46e5;
            --text-main: #f3f4f6;
            --text-muted: #9ca3af;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-dark);
            color: var(--text-main);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
        }

        .login-card {
            width: 100%;
            max-width: 420px;
            background-color: var(--card-dark);
            border-radius: 1.25rem;
            padding: 2.5rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
        }

        .brand-logo {
            width: 64px;
            height: 64px;
            background: linear-gradient(135deg, var(--accent) 0%, #818cf8 100%);
            border-radius: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 1.75rem;
            color: white;
            box-shadow: 0 10px 15px -3px rgba(99, 102, 241, 0.3);
        }

        .form-label {
            color: var(--text-muted);
            font-weight: 500;
            font-size: 0.875rem;
            margin-bottom: 0.5rem;
        }

        .form-control {
            background-color: #0f1115;
            border: 1px solid #374151;
            color: white;
            border-radius: 0.75rem;
            padding: 0.75rem 1rem;
            transition: all 0.2s;
        }

        .form-control:focus {
            background-color: #0f1115;
            border-color: var(--accent);
            color: white;
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
            outline: none;
        }

        .btn-primary {
            background-color: var(--accent);
            border: none;
            border-radius: 0.75rem;
            padding: 0.75rem;
            font-weight: 600;
            transition: all 0.2s;
        }

        .btn-primary:hover {
            background-color: var(--accent-hover);
            transform: translateY(-1px);
        }

        .input-group-text {
            background-color: #0f1115;
            border: 1px solid #374151;
            color: var(--text-muted);
            border-radius: 0.75rem 0 0 0.75rem;
        }

        .form-control {
            border-left: none;
            border-radius: 0 0.75rem 0.75rem 0;
        }

        .demo-badge {
            background-color: rgba(99, 102, 241, 0.1);
            color: var(--accent);
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 600;
        }
    </style>
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
    <form id="form1" runat="server">
        <div class="login-card">
            <div class="text-center mb-4">
                <div class="brand-logo">
                    <i class="fa-solid fa-bolt"></i>
                </div>
                <h3 class="fw-bold text-white">Welcome Back</h3>
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

            <div class="p-3 rounded-4" style="background-color: #0f1115;">
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
