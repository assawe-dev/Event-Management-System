<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | EMS</title>
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
            padding: 2rem 0;
        }

        .register-card {
            width: 100%;
            max-width: 440px;
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
    </style>
    <script type="text/javascript">
        function validateRegister() {
            var fullName = document.getElementById('<%= txtFullName.ClientID %>').value.trim();
            var username = document.getElementById('<%= txtUsername.ClientID %>').value.trim();
            var password = document.getElementById('<%= txtPassword.ClientID %>').value.trim();
            if (fullName === "") { alert("Full Name is required!"); return false; }
            var nameRegex = /^[a-zA-Z\s]+$/;
            if (!nameRegex.test(fullName)) { alert("Full Name must contain letters only!"); return false; }
            if (username === "") { alert("Username is required!"); return false; }
            if (password === "") { alert("Password is required!"); return false; }
            if (password.length < 6) { alert("Password must be at least 6 characters long!"); return false; }
            return true;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="register-card">
            <div class="text-center mb-4">
                <div class="brand-logo">
                    <i class="fa-solid fa-user-plus"></i>
                </div>
                <h3 class="fw-bold text-white">Join EMS</h3>
                <p class="text-muted small">Create your premium account today</p>
            </div>

            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-signature"></i></span>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="John Doe"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName" Display="Dynamic" Enabled="false"></asp:RequiredFieldValidator>
            </div>

            <div class="mb-3">
                <label class="form-label">Username</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-at"></i></span>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="username"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" Display="Dynamic" Enabled="false"></asp:RequiredFieldValidator>
            </div>

            <div class="mb-4">
                <label class="form-label">Password</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-key"></i></span>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="••••••••"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" Display="Dynamic" Enabled="false"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="txtPassword" Display="Dynamic" Enabled="false" ValidationExpression="^.{6,}$"></asp:RegularExpressionValidator>
            </div>

            <asp:Button ID="btnRegister" runat="server" Text="Create Account" CssClass="btn btn-primary w-100 mb-3" OnClick="btnRegister_Click" OnClientClick="return validateRegister();" />

            <div class="text-center">
                <p class="text-muted small">Already have an account? <a href="Login.aspx" class="text-decoration-none fw-semibold" style="color: var(--accent);">Sign in</a></p>
            </div>
        </div>
    </form>
</body>
</html>
