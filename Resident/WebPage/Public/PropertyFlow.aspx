<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PropertyFlow.aspx.cs" Inherits="Resident.WebPage.Public.PropertyFlow" %>

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

    <script>

        $(document).ready(function () {
            fun1();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (evt, args) {
                fun1();
            });
        });
        function fun1(){

            //  $(window).resize(function () {
            //do your check here on resize
            if ($(window).width() <= 575) {

                $(".tv-node").click(function () {
                    $('html, body').animate({
                        scrollTop: $('.scroll-div').offset().top
                    }, 3000);
                });
                //alert("hi");
            }
            //do here
            // });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="container mt-3">
            <asp:UpdatePanel runat="server">
                <ContentTemplate>


                    <div class="row">
                        <div class="col-sm-4">
                            <asp:TreeView ID="tvPropertyFlow" runat="server" ImageSet="Arrows" NodeIndent="15" ShowLines="true" ClientIDMode="Static"
                                OnSelectedNodeChanged="tvPropertyFlow_SelectedNodeChanged" CssClass="jumbotron" NodeStyle-CssClass="tv-node">
                                <HoverNodeStyle Font-Underline="True" ForeColor="#6666AA" />
                                <NodeStyle></NodeStyle>
                                <%--<ParentNodeStyle Font-Bold="False" />
                                <SelectedNodeStyle BackColor="#B5B5B5" Font-Underline="False" HorizontalPadding="0px"
                                    VerticalPadding="0px" />--%>
                            </asp:TreeView>
                        </div>

                        <div class="col-sm-8">
                            <div class="card bg-light text-center" style="border-bottom: 0px; border-radius: 0px;">
                                <div class="card-body p-0">
                                    <h5 class="card-title m-1">
                                        <asp:Label runat="server" ID="lblPFCName" Text="<< Select an an item from leftside "></asp:Label>
                                    </h5>
                                </div>
                            </div>
                            <asp:HiddenField ID="hdnPFCId" runat="server" />

                            <asp:HiddenField ID="hdnRoot" runat="server" />

                            <div class="scroll-div">
                                <asp:DetailsView ID="dvwPropertyFlow" runat="server" AutoGenerateRows="False" DataKeyNames="Id" Enabled="false"
                                    CssClass="table table-bordered table-condensed table-responsive-sm table-sm"
                                    HeaderStyle-ForeColor="#032e3a" HeaderStyle-BackColor="#d9edf7"
                                    DataSourceID="SqlDvw" DefaultMode="Insert" OnItemInserted="dvwPropertyFlow_ItemInserted" OnItemInserting="dvwPropertyFlow_ItemInserting"
                                    OnItemUpdating="dvwPropertyFlow_ItemUpdating" OnItemUpdated="dvwPropertyFlow_ItemUpdated">
                                    <Fields>
                                        <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id"></asp:BoundField>
                                        <asp:TemplateField HeaderText="Image" InsertVisible="false">
                                            <ItemTemplate>

                                                <span>
                                                    <asp:Image ID="imgImage1" runat="server" ImageUrl='<%# Bind("Image1") %>' CssClass="img-fluid" Width="75px" />
                                                    <asp:HiddenField ID="hdnImage1" runat="server" Value='<%# Bind("Image1") %>' />
                                                </span>

                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Name">
                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("Name") %>' ID="txtName" CssClass="form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtName"
                                                    runat="server" Display="Dynamic" ValidationGroup="valPropertyFlow" Font-Size="XX-Small" SetFocusOnError="true" />
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("Name") %>' ID="txtName" CssClass="form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtName"
                                                    runat="server" Display="Dynamic" ValidationGroup="valPropertyFlow" Font-Size="XX-Small" SetFocusOnError="true" />
                                            </InsertItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="NameAlt">
                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("NameAlt") %>' ID="txtNameAlt" CssClass="form-control"></asp:TextBox>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("NameAlt") %>' ID="txtNameAlt" CssClass="form-control"></asp:TextBox>
                                            </InsertItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Image1" SortExpression="Image1">
                                            <EditItemTemplate>
                                                <div class="custom-file">
                                                    <asp:FileUpload runat="server" ID="fuImage1" accept="image/*" CssClass="custom-file-input"></asp:FileUpload>
                                                    <asp:Label AssociatedControlID="fuImage1" CssClass="custom-file-label" runat="server" Font-Size="Smaller">Choose File</asp:Label>
                                                </div>
                                                <asp:RegularExpressionValidator ID="revalfuImage1" ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.png|.jpg|.bmp|.gif|.jpeg|.tft|.PNG|.JPG|.BMP|.GIF|.JPEG|.TFT)$"
                                                    ControlToValidate="fuImage1" runat="server" ForeColor="Red" ErrorMessage="*Invalid Image Extension." Font-Size="XX-Small"
                                                    Display="Dynamic" ValidationGroup="valPropertyFlow" />

                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <div class="custom-file">
                                                    <asp:FileUpload runat="server" ID="fuImage1" accept="image/*" CssClass="custom-file-input"></asp:FileUpload>
                                                    <asp:Label AssociatedControlID="fuImage1" CssClass="custom-file-label" runat="server" Font-Size="Smaller">Choose File</asp:Label>
                                                </div>
                                                <asp:RegularExpressionValidator ID="revalfuImage1" ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.png|.jpg|.bmp|.gif|.jpeg|.tft|.PNG|.JPG|.BMP|.GIF|.JPEG|.TFT)$"
                                                    ControlToValidate="fuImage1" runat="server" ForeColor="Red" ErrorMessage="*Invalid Image Extension." Font-Size="XX-Small"
                                                    Display="Dynamic" ValidationGroup="valPropertyFlow" />
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
                                            ControlStyle-CssClass="btn btn-outline-primary btn-sm" ValidationGroup="valPropertyFlow" />
                                        <asp:CommandField ShowEditButton="true" EditText="Update" ButtonType="Button"
                                            ControlStyle-CssClass="btn btn-outline-primary btn-sm" ValidationGroup="valPropertyFlow" />
                                    </Fields>
                                </asp:DetailsView>
                                <asp:SqlDataSource runat="server" ID="SqlDvw" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                    SelectCommand="SELECT [Id], [Name], [NameAlt], [Image1], [Descr] FROM [PropertyFlowChart] WHERE Id=@Id"
                                    InsertCommand="INSERT INTO PropertyFlowChart(ComplexId, ParentId, Name, NameAlt, Image1, Descr, CrBy, CrByIP, CrDt) 
                                        VALUES (@ComplexId, @ParentId, @Name, @NameAlt, @Image1, @Descr, @CrBy, @CrByIP, @CrDt)"
                                    UpdateCommand="UPDATE PropertyFlowChart SET Name = @Name, NameAlt = @NameAlt, Image1 = @Image1, Descr = @Descr, 
                                        @ModBy=@ModBy, ModByIP=@ModByIP, ModDt=@ModDt WHERE (Id = @Id)">
                                    <InsertParameters>
                                        <asp:Parameter Name="Name"></asp:Parameter>
                                        <asp:Parameter Name="NameAlt"></asp:Parameter>
                                        <asp:Parameter Name="Image1"></asp:Parameter>
                                        <asp:Parameter Name="Descr"></asp:Parameter>
                                        <asp:Parameter Name="ComplexId" Type="Int32" />
                                        <asp:Parameter Name="ParentId" Type="Int32" />

                                        <asp:Parameter Name="CrBY" Type="String" />
                                        <asp:Parameter Name="CrDt" Type="DateTime" />
                                        <asp:Parameter Name="CrByIP" Type="String" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="gvwPropertyFlow" Name="Id" PropertyName="SelectedValue" Type="Int32" />
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="Name"></asp:Parameter>
                                        <asp:Parameter Name="NameAlt"></asp:Parameter>
                                        <asp:Parameter Name="Image1"></asp:Parameter>
                                        <asp:Parameter Name="Descr"></asp:Parameter>
                                        <asp:Parameter Name="ModBy" Type="String" />
                                        <asp:Parameter Name="ModDt" Type="DateTime" />
                                        <asp:Parameter Name="ModByIP" Type="String" />
                                        <asp:Parameter Name="Id" Type="Int32" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>

                                <div>
                                    <asp:GridView ID="gvwPropertyFlow" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
                                        OnSelectedIndexChanged="gvwPropertyFlow_SelectedIndexChanged" EmptyDataText="There is no data to show."
                                        CssClass="table table-bordered table-responsive-sm table-sm table-condensed table-striped">
                                        <Columns>
                                            <asp:TemplateField HeaderText="#">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Name">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" Text='<%# Eval("Name") %>' ID="lblPropertyFlow"></asp:Label>
                                                    <div runat="server" visible='<%#(Eval("NameAlt")).ToString()!=""? true:false %>'>
                                                        ( <%# Eval("NameAlt") %> )
                                                    </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Description">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" Text='<%# Eval("Descr") %>' ID="lblDescr"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Image">
                                                <ItemTemplate>
                                                    <div>
                                                        <asp:Image ID="img" runat="server" ImageUrl='<%# Bind("Image1") %>'
                                                            Visible='<%#(Eval("Image1")).ToString()!=""? true:false %>'
                                                            CssClass="img-fluid" Width="100px" />
                                                    </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:CommandField ShowSelectButton="true" SelectText="Select" ControlStyle-CssClass="btn btn-outline-success btn-sm" />
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>

                        </div>

                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="dvwPropertyFlow" />
                </Triggers>
            </asp:UpdatePanel>

        </div>
    </form>
</body>
</html>
