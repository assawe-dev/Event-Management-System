<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageEvents.aspx.cs" Inherits="Admin_ManageEvents" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Manage Events - EMS Admin</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .container { margin-top: 30px; }
        .form-section { background: #f8f9fa; padding: 20px; border-radius: 5px; margin-bottom: 30px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <a class="navbar-brand" href="../Dashboard.aspx">EMS Admin</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="../Dashboard.aspx">Dashboard</a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="ManageEvents.aspx">Manage Events</a>
                    </li>
                </ul>
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-outline-light btn-sm" OnClick="btnLogout_Click" CausesValidation="false" />
            </div>
        </nav>

        <div class="container">
            <h2>Manage Events</h2>
            <hr />

            <div class="form-section">
                <h4><asp:Literal ID="litFormTitle" runat="server" Text="Add New Event"></asp:Literal></h4>
                <asp:HiddenField ID="hfEventId" runat="server" />
                <div class="form-row">
                    <div class="form-group col-md-4">
                        <label>Event Name</label>
                        <asp:TextBox ID="txtEventName" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEventName" runat="server" ControlToValidate="txtEventName"
                            ErrorMessage="Name is required" ForeColor="Red" Display="Dynamic" ValidationGroup="EventForm"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Date</label>
                        <asp:TextBox ID="txtEventDate" runat="server" CssClass="form-control" placeholder="YYYY-MM-DD"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEventDate" runat="server" ControlToValidate="txtEventDate"
                            ErrorMessage="Date is required" ForeColor="Red" Display="Dynamic" ValidationGroup="EventForm"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revEventDate" runat="server" ControlToValidate="txtEventDate"
                            ErrorMessage="Format YYYY-MM-DD" ValidationExpression="^\d{4}-\d{2}-\d{2}$"
                            ForeColor="Red" Display="Dynamic" ValidationGroup="EventForm"></asp:RegularExpressionValidator>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Location</label>
                        <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvLocation" runat="server" ControlToValidate="txtLocation"
                            ErrorMessage="Location is required" ForeColor="Red" Display="Dynamic" ValidationGroup="EventForm"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group col-md-2 d-flex align-items-end">
                        <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary mr-2" OnClick="btnSave_Click" ValidationGroup="EventForm" />
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary" OnClick="btnCancel_Click" CausesValidation="false" />
                    </div>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <div class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by name or location..."></asp:TextBox>
                        <div class="input-group-append">
                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-info" OnClick="btnSearch_Click" CausesValidation="false" />
                            <asp:Button ID="btnClearSearch" runat="server" Text="Clear" CssClass="btn btn-outline-secondary" OnClick="btnClearSearch_Click" CausesValidation="false" />
                        </div>
                    </div>
                </div>
            </div>

            <asp:GridView ID="gvEvents" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered"
                OnRowCommand="gvEvents_RowCommand" DataKeyNames="Id">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="ID" />
                    <asp:BoundField DataField="Name" HeaderText="Event Name" />
                    <asp:BoundField DataField="EventDate" HeaderText="Date" />
                    <asp:BoundField DataField="Location" HeaderText="Location" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" Text="Edit" CommandName="EditEvent"
                                CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm btn-warning"></asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" runat="server" Text="Delete" CommandName="DeleteEvent"
                                CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm btn-danger"
                                OnClientClick="return confirm('Are you sure you want to delete this event?');"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="alert alert-info">No events found.</div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
