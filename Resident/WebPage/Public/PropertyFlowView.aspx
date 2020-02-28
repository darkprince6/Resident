<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PropertyFlowView.aspx.cs" Inherits="Resident.WebPage.Public.PropertyFlowView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link href="../../ContentProject/Admin/ResComPS.css" rel="stylesheet" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="../../ScriptsProject/ResComPS.js"></script>


</head>

<body>
    <form id="form1" runat="server">
        <div>
            <div class="container mt-3">
                <div class="row">
                    <div class="col-sm-4">
                        <asp:TreeView ID="tvPropertyFlow" runat="server" ImageSet="Arrows" NodeIndent="15" ShowLines="true" OnTreeNodeExpanded="tvPropertyFlow_TreeNodeExpanded"
                            CssClass="jumbotron">
                            <HoverNodeStyle Font-Underline="True" ForeColor="#6666AA" />
                            <HoverNodeStyle Font-Underline="True" ForeColor="#2979ff" />
                            <NodeStyle></NodeStyle>
                            <RootNodeStyle ForeColor="#1C2331" ChildNodesPadding="2px" Font-Size="Large" />
                            <ParentNodeStyle ChildNodesPadding="1px" ForeColor="#4B515D" />
                            <NodeStyle ForeColor="#3F729B" />
                            <SelectedNodeStyle ForeColor="#007E33" />
                        </asp:TreeView>
                    </div>
                    <div class="col-sm-4">
                        <asp:Repeater ID="repPropertyFlow" runat="server" DataSourceID="sqlRepPropertyFlow">
                            <ItemTemplate>

                                <div class="card">
                                    <asp:Image class="card-img-top" ImageUrl='<%# Eval("Image1") %>' runat="server" Visible='<%#(Eval("Image1")).ToString()!=""? true:false %>' />
                                    <div class="card-body">
                                        <h5 class="card-title">
                                            <asp:Label runat="server" ID="lblPFCName" Text='<%# Eval("Name") %>'></asp:Label>

                                            <div runat="server" visible='<%#(Eval("NameAlt")).ToString()!=""? true:false %>'>
                                                <small>( <%# Eval("NameAlt") %> ) </small>
                                            </div>
                                        </h5>
                                        <p class="card-text" runat="server" visible='<%#(Eval("Descr")).ToString()!=""? true:false %>'>
                                            <asp:Label runat="server" Text='<%# Eval("Descr") %>' ID="lblDescr"></asp:Label>
                                        </p>
                                        <p class="card-text">
                                            <small class="text-muted">Last Updated on <%# Eval("CrDt","{0:d/MMM/yyyy}") %>

                                                <%--<%# (DateTime)Eval("ModDt") > (DateTime)Eval("CrDt")? true:false  %>--%>
                                            </small>
                                        </p>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                        <asp:SqlDataSource runat="server" ID="sqlRepPropertyFlow" ConnectionString='<%$ ConnectionStrings:Residence4UmDBContext %>'
                            SelectCommand="SELECT [Id], [Name], [NameAlt], [Image1], [Descr], [CrDt], [ModDt] FROM [PropertyFlowChart] WHERE ([Id] = @Id)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="tvPropertyFlow"
                                    PropertyName="SelectedValue" DefaultValue="0" Name="Id" Type="Int32"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>


                </div>
            </div>
        </div>
    </form>
</body>
</html>
