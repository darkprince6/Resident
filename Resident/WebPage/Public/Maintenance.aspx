<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Maintenance.aspx.cs" Inherits="Resident.WebPage.Public.Maintenance" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="container">
            <div class="row">
                <div class="col-sm-4">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <asp:TreeView ID="tvMaintBranches" runat="server" ImageSet="Arrows" NodeIndent="15" ShowLines="true"
                                OnSelectedNodeChanged="tvMaintBranches_SelectedNodeChanged" CssClass="jumbotron">
                                <HoverNodeStyle Font-Underline="True" ForeColor="#6666AA" />
                                <HoverNodeStyle Font-Underline="True" ForeColor="#2979ff" />
                                <NodeStyle></NodeStyle>
                                <RootNodeStyle ForeColor="#1C2331" ChildNodesPadding="2px" Font-Size="Large" />
                                <ParentNodeStyle ChildNodesPadding="1px" ForeColor="#4B515D" />
                                <NodeStyle ForeColor="#3F729B" />
                                <SelectedNodeStyle ForeColor="#007E33" />
                            </asp:TreeView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <div class="col-sm-8">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>

                            <div class="card bg-light text-center" style="border-bottom: 0px; border-radius: 0px;">
                                <div class="card-body p-0">
                                    <h5 class="card-title m-1">
                                        <asp:Label runat="server" ID="lblMaintBranch" Text="<< Select an an item from leftside "></asp:Label>
                                    </h5>
                                </div>
                            </div>
                            <asp:HiddenField ID="hdnBranchId" runat="server" />
                            <asp:HiddenField ID="hdnRoot" runat="server" />
                            <asp:DetailsView ID="dvwMaintPost" runat="server" AutoGenerateRows="False" DataKeyNames="Id" Enabled="false"
                                CssClass="table table-bordered table-condensed table-responsive-sm table-sm"
                                HeaderStyle-ForeColor="#032e3a" HeaderStyle-BackColor="#d9edf7"
                                DataSourceID="SqlDvw" DefaultMode="Insert" OnItemInserted="dvwMaintPost_ItemInserted" OnItemInserting="dvwMaintPost_ItemInserting"
                                OnItemUpdating="dvwMaintPost_ItemUpdating" OnItemUpdated="dvwMaintPost_ItemUpdated">
                                <Fields>
                                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id"></asp:BoundField>

                                    <asp:TemplateField HeaderText="Name">
                                        <EditItemTemplate>
                                            <asp:TextBox runat="server" Text='<%# Bind("PName") %>' ID="txtName" CssClass="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtName"
                                                runat="server" Display="Dynamic" ValidationGroup="valMaintPost" Font-Size="XX-Small" SetFocusOnError="true" />
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox runat="server" Text='<%# Bind("PName") %>' ID="txtName" CssClass="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtName"
                                                runat="server" Display="Dynamic" ValidationGroup="valMaintPost" Font-Size="XX-Small" SetFocusOnError="true" />
                                        </InsertItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Descr" SortExpression="Descr">
                                        <EditItemTemplate>
                                            <asp:TextBox runat="server" Text='<%# Bind("Descr") %>' ID="txtDescr" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox runat="server" Text='<%# Bind("Descr") %>' ID="txtDescr" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                        </InsertItemTemplate>

                                    </asp:TemplateField>
                                    <asp:CommandField ShowInsertButton="true" InsertText="Submit" ButtonType="Button"
                                        ControlStyle-CssClass="btn btn-outline-primary btn-sm" ValidationGroup="valMaintPost" />
                                    <asp:CommandField ShowEditButton="true" EditText="Update" ButtonType="Button"
                                        ControlStyle-CssClass="btn btn-outline-primary btn-sm" ValidationGroup="valMaintPost" />
                                </Fields>
                            </asp:DetailsView>
                            <asp:SqlDataSource runat="server" ID="SqlDvw" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                SelectCommand="SELECT [Id], [PName], [Descr] FROM [MaintPosts] WHERE Id=@Id"
                                InsertCommand="INSERT INTO MaintPosts(ResComId, BranchId, PName, Descr, CrBy, CrByIP, CrDt) 
                                        VALUES (@ResComId, @BranchId, @PName, @Descr, @CrBy, @CrByIP, @CrDt)"
                                UpdateCommand="UPDATE MaintPosts SET PName = @PName, Descr = @Descr, 
                                        @ModBy=@ModBy, ModByIP=@ModByIP, ModDt=@ModDt WHERE (Id = @Id)">
                                <InsertParameters>
                                    <asp:Parameter Name="PName"></asp:Parameter>
                                    <asp:Parameter Name="Descr"></asp:Parameter>
                                    <asp:Parameter Name="ResComId" Type="Int32" />

                                    <asp:Parameter Name="BranchId" Type="Int32" />
                                    <asp:Parameter Name="CrBY" Type="String" />
                                    <asp:Parameter Name="CrDt" Type="DateTime" />
                                    <asp:Parameter Name="CrByIP" Type="String" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gvwMaintPost" Name="Id" PropertyName="SelectedValue" Type="Int32" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="PName"></asp:Parameter>
                                    <asp:Parameter Name="Descr"></asp:Parameter>
                                    <asp:Parameter Name="ModBy" Type="String" />
                                    <asp:Parameter Name="ModDt" Type="DateTime" />
                                    <asp:Parameter Name="ModByIP" Type="String" />
                                    <asp:Parameter Name="Id" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                            <div>
                                <asp:GridView ID="gvwMaintPost" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
                                    OnSelectedIndexChanged="gvwMaintPost_SelectedIndexChanged" EmptyDataText="There is no data to show."
                                    CssClass="table table-bordered table-responsive-sm table-sm table-condensed table-striped">
                                    <Columns>
                                        <asp:TemplateField HeaderText="#">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Name">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# Eval("PName") %>' ID="lblName"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Description">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# Eval("Descr") %>' ID="lblDescr"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ShowSelectButton="true" SelectText="Select" ControlStyle-CssClass="btn btn-outline-success btn-sm" />
                                    </Columns>
                                </asp:GridView>
                            </div>

                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

            </div>
        </div>
    </form>
</body>
</html>
