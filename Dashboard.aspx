<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Dashboard" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Dashboard - EMS</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <a class="navbar-brand" href="#">EMS</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="Dashboard.aspx">Dashboard</a>
                    </li>
                    <asp:PlaceHolder ID="phAdminMenu" runat="server" Visible="false">
                        <li class="nav-item">
                            <a class="nav-link" href="Admin/ManageEvents.aspx">Manage Events</a>
                        </li>
                    </asp:PlaceHolder>
                    <asp:PlaceHolder ID="phUserMenu" runat="server" Visible="false">
                        <li class="nav-item">
                            <a class="nav-link" href="User/BrowseEvents.aspx">Browse Events</a>
                        </li>
                    </asp:PlaceHolder>
                </ul>
                <span class="navbar-text mr-3">
                    Welcome, <asp:Literal ID="litUsername" runat="server"></asp:Literal>
                </span>
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-outline-light btn-sm" OnClick="btnLogout_Click" CausesValidation="false" />
            </div>
        </nav>

        <div class="container mt-5">
            <div class="jumbotron">
                <h1 class="display-4">Welcome to EMS Dashboard</h1>
                <p class="lead">Select an option from the menu above to get started.</p>
                <hr class="my-4">
                <div class="row">
                    <asp:PlaceHolder ID="phAdminCard" runat="server" Visible="false">
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Admin Section</h5>
                                    <p class="card-text">Manage all events, including add, edit, and delete.</p>
                                    <a href="Admin/ManageEvents.aspx" class="btn btn-primary">Go to Manage Events</a>
                                </div>
                            </div>
                        </div>
                    </asp:PlaceHolder>
                    <asp:PlaceHolder ID="phUserCard" runat="server" Visible="false">
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">User Section</h5>
                                    <p class="card-text">Browse and search for available events.</p>
                                    <a href="User/BrowseEvents.aspx" class="btn btn-success">Go to Browse Events</a>
                                </div>
                            </div>
                        </div>
                    </asp:PlaceHolder>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
