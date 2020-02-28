<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SearchByAnyWord.aspx.cs" Inherits="Resident.Testing.SearchByAnyWord" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/v/dt/dt-1.10.18/datatables.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/dataTables.bootstrap4.min.css" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.18/datatables.min.js"></script>
    <script>
        $(document).ready(function () {
            $("#tableTesting").dataTable({
                "ordering": false,
                "info": false
            });
        })
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row mt-5">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <div class="card">
                        <div class="card-body">

                            <div class="row">
                                <div class="col-sm-12">
                                    <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
                                    <asp:Button runat="server" Text="Search" OnClick="btnSearch_Click" ID="btnSearch" />
                                </div>
                            </div>

                            <asp:Repeater runat="server" ID="RepTesting" DataSourceID="SqlRepTesting">
                                <%-- <ItemTemplate>
                                    <div class="card mb-3">
                                        <div class="card-body">
                                            <h6 class="card-title text-black">
                                                <asp:Label runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                                                <asp:Label runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                                            </h6>
                                        </div>
                                    </div>
                                </ItemTemplate>--%>

                                <HeaderTemplate>
                                    <table id="tableTesting" class="hover table table-striped table-bordered" style="width:100%">
                                        <thead>
                                            <tr>
                                                <th>Id </th>
                                                <th>Email </th>
                                            </tr>
                                        </thead>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <%--<%# DataBinder.Eval(Container.DataItem, "Id")%>  --%>
                                            <asp:Label runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <%--<%# DataBinder.Eval(Container.DataItem, "Email")%>  --%>
                                            <asp:Label runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </table>  
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
                <div class="col-sm-2"></div>
            </div>
        </div>
        <asp:SqlDataSource runat="server" ID="SqlRepTesting" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
            SelectCommand="SELECT [Id], [Email] FROM [UtilityEmail]"></asp:SqlDataSource>
    </form>
</body>
</html>
