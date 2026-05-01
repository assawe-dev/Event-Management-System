<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BrowseEvents.aspx.cs" Inherits="User_BrowseEvents" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Browse Events - EMS</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .container { margin-top: 30px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <a class="navbar-brand" href="../Dashboard.aspx">EMS</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="../Dashboard.aspx">Dashboard</a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="BrowseEvents.aspx">Browse Events</a>
                    </li>
                </ul>
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-outline-light btn-sm" OnClick="btnLogout_Click" CausesValidation="false" />
            </div>
        </nav>

        <div class="container">
            <h2>Browse Events</h2>
            <hr />

            <div class="row mb-4">
                <div class="col-md-6">
                    <div class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search events..."></asp:TextBox>
                        <div class="input-group-append">
                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearch_Click" CausesValidation="false" />
                            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary" OnClick="btnClear_Click" CausesValidation="false" />
                        </div>
                    </div>
                </div>
            </div>

            <asp:Repeater ID="rptEvents" runat="server">
                <HeaderTemplate>
                    <div class="row">
                </HeaderTemplate>
                <ItemTemplate>
                    <div class="col-md-4 mb-4">
                        <div class="card h-100">
                            <div class="card-body">
                                <h5 class="card-title"><%# Eval("Name") %></h5>
                                <h6 class="card-subtitle mb-2 text-muted"><%# Eval("EventDate") %></h6>
                                <p class="card-text"><strong>Location:</strong> <%# Eval("Location") %></p>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
                <FooterTemplate>
                    </div>
                    <asp:Label ID="lblNoData" runat="server" Text="No events found." Visible='<%# rptEvents.Items.Count == 0 %>' CssClass="alert alert-info d-block"></asp:Label>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </form>
</body>
</html>
