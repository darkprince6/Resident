<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LazyLode.aspx.cs" Inherits="Resident.WebPage.LazyLode" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery.lazy/1.7.9/jquery.lazy.min.js"></script>
    <script>
        $(function () {
            $('.lazy').Lazy();
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">

            <div class="row">
                <div class="col-md-2"></div>
                <div class="col-md-8 p-3">
                    <asp:GridView ID="gvw" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource1" CssClass="table table-bordered table-sm table-striped p-4 lazy">
                        <Columns>

                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label runat="server" Text='<%# Eval("Id") %>' CssClass="lazy"  data-loader='<%# Eval("Id") %>'></asp:Label>
                                    <br />
                                    <asp:Label runat="server" Text='<%# Eval("Name") %>' CssClass="lazy"  data-loader='<%# Eval("Name") %>'></asp:Label>
                                    <br />
                                    <asp:Label runat="server" Text='<%# Eval("Addr1") %>' CssClass="lazy"  data-loader='<%# Eval("Addr1") %>'></asp:Label>
                                    <br />
                                    <asp:Label runat="server" Text='<%# Eval("Addr2") %>' CssClass="lazy"  data-loader='<%# Eval("Addr2") %>'></asp:Label>
                                    <br />
                                    <asp:Label runat="server" Text='<%# Eval("PostalCode") %>' CssClass="lazy"  data-loader='<%# Eval("PostalCode") %>'></asp:Label>

                                </ItemTemplate>
                            </asp:TemplateField>
                            
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                        SelectCommand="SELECT [Id], [Name], [Addr1], [Addr2], [PostalCode] FROM [Utility]"></asp:SqlDataSource>
                </div>
                <div class="col-md-2"></div>

            </div>

        </div>
    </form>
</body>
</html>
