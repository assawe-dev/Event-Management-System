<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Event Management System</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --bg-gradient: linear-gradient(135deg, #4361ee 0%, #4cc9f0 100%);
        }
        body {
            font-family: 'Inter', sans-serif;
            background: #f8f9fa;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
        }
        .login-card {
            width: 100%;
            max-width: 450px;
            border: none;
            background: #fff;
        }
        .card-header-gradient {
            background: var(--bg-gradient);
            padding: 40px 20px;
            text-align: center;
            color: white;
        }
        .card-header-gradient i {
            font-size: 3rem;
            margin-bottom: 15px;
        }
        .form-control {
            border-radius: 10px;
            padding: 12px 15px;
            border: 1px solid #e0e0e0;
            background-color: #fdfdfd;
        }
        .form-control:focus {
            box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.15);
            border-color: var(--primary-color);
        }
        .btn-login {
            background: var(--primary-color);
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s;
            color: white;
        }
        .btn-login:hover {
            background: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
            color: white;
        }
        .input-group-text {
            background: transparent;
            border-right: none;
            color: #adb5bd;
        }
        .form-control {
            border-left: none;
        }
        .input-group:focus-within .input-group-text {
            color: var(--primary-color);
            border-color: var(--primary-color);
        }
        .demo-box {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 15px;
            margin-top: 25px;
        }
        .validation-error {
            font-size: 0.85rem;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-card shadow-lg rounded-4 overflow-hidden animate__animated animate__fadeInUp">
            <div class="card-header-gradient">
                <i class="fa-solid fa-calendar-check"></i>
                <h2 class="fw-bold mb-0">EMS Portal</h2>
                <p class="opacity-75">Sign in to manage your events</p>
            </div>
            <div class="card-body p-4 p-md-5">
                <div class="mb-4">
                    <label class="form-label fw-semibold text-secondary small text-uppercase">Username</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter username"></asp:TextBox>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername"
                        ErrorMessage="<i class='fa-solid fa-circle-exclamation'></i> Username is required"
                        CssClass="text-danger validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold text-secondary small text-uppercase">Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter password"></asp:TextBox>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                        ErrorMessage="<i class='fa-solid fa-circle-exclamation'></i> Password is required"
                        CssClass="text-danger validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="txtPassword"
                        ErrorMessage="<i class='fa-solid fa-circle-exclamation'></i> Min. 6 characters"
                        ValidationExpression="^.{6,}$" CssClass="text-danger validation-error" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>

                <asp:Button ID="btnLogin" runat="server" Text="Sign In" CssClass="btn btn-login w-100 mt-2" OnClick="btnLogin_Click" />

                <div class="demo-box">
                    <p class="text-muted small fw-bold mb-2"><i class="fa-solid fa-flask me-1"></i> Demo Access:</p>
                    <div class="d-flex justify-content-between">
                        <span class="small text-secondary">Admin: <code>admin / admin123</code></span>
                        <span class="small text-secondary">User: <code>user / user123</code></span>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
