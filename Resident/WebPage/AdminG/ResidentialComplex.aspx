<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResidentialComplex.aspx.cs" Inherits="Resident.WebPage.AdminG.ResidentialComplex" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <link href="../../ContentProject/Admin/ResidentialComplex.css" rel="stylesheet" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="../../ScriptsProject/ResidentialComplex.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <div class="container">
                <div class="row">
                    <div class="col-sm-2"></div>

                    <div class="col-sm-8">
                        <div style="background-color: #d7ccc8; text-align: center; margin-bottom: 5px; margin-top: 4px; font-weight: 600">
                            <asp:Label runat="server" ID="lblHead" Font-Size="19px">
                                    Here you can add Residential Complex Details :
                            </asp:Label>
                        </div>
                    </div>
                    <div class="col-sm-2"></div>

                </div>

                <div class="row">
                    <div class="col-sm-2"></div>
                    <div class="col-sm-8">
                        <div id="divNoLog" runat="server" visible="true">
                            <div class="alert alert-danger">
                                <i class="fa fa-close"></i>
                                <asp:Label runat="server" ID="lblNoLog" Font-Size="18px" ForeColor="Crimson"></asp:Label>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2"></div>
                </div>

                <div class="row">
                    <div class="col-sm-2"></div>
                    <div class="col-sm-8">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <div id="divddlResiComCat" runat="server" visible="true">
                                    <asp:DropDownList ID="ddlResiComCat" runat="server" CssClass="form-control" DataSourceID="sqlddlResiComCat" DataTextField="Cat"
                                        DataValueField="Id" OnDataBound="ddlResiComCat_DataBound" AutoPostBack="true" OnSelectedIndexChanged="ddlResiComCat_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource runat="server" ID="sqlddlResiComCat" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                        SelectCommand="ResComCat_ddl_Sel_AdminG" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div class="col-sm-2"></div>
                </div>
                <div class="row">
                    <div class="col-sm-2">
                    </div>
                    <div class="col-sm-8">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <div id="divResCom" runat="server" visible="false">

                                    <asp:DetailsView ID="dvwResCom" runat="server" AutoGenerateRows="False" DefaultMode="Insert" DataKeyNames="Id"
                                        CssClass="table table-bordered table-condensed table-responsive-sm table-sm"
                                        OnItemInserting="dvwResCom_ItemInserting" HeaderText="Enter Residential Complex details" HeaderStyle-ForeColor="#032e3a" HeaderStyle-BackColor="#d9edf7"
                                        OnItemInserted="dvwResCom_ItemInserted" OnItemUpdating="dvwResCom_ItemUpdating" OnItemUpdated="dvwResCom_ItemUpdated"
                                        DataSourceID="sqldvwResCom">
                                        <EditRowStyle HorizontalAlign="Left" />
                                        <Fields>
                                            <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id"></asp:BoundField>
                                            <asp:TemplateField HeaderText="Image" InsertVisible="false">
                                                <ItemTemplate>
                                                    <span>
                                                        <asp:Image ID="imgLogo" runat="server" ImageUrl='<%# Bind("Logo") %>' CssClass="img-fluid" Width="75px" />
                                                        <asp:HiddenField ID="hdnLogo" runat="server" Value='<%# Bind("Logo") %>' />
                                                    </span>
                                                    <span>
                                                        <asp:Image ID="imgCoverImg" runat="server" ImageUrl='<%# Bind("CoverImg") %>' CssClass="img-fluid" Width="75px" />
                                                        <asp:HiddenField ID="hdnCoverImg" runat="server" Value='<%# Bind("CoverImg") %>' />

                                                    </span>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Complex Name">
                                                <InsertItemTemplate>
                                                    <asp:TextBox runat="server" Text='<%# Bind("Name") %>' ID="txtName" CssClass="form-control"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtName"
                                                        runat="server" Display="Dynamic" ValidationGroup="valResCom" Font-Size="XX-Small" SetFocusOnError="true" />
                                                </InsertItemTemplate>

                                                <EditItemTemplate>
                                                    <asp:TextBox runat="server" Text='<%# Bind("Name") %>' ID="txtName" CssClass="form-control"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtName"
                                                        runat="server" Display="Dynamic" ValidationGroup="valResCom" Font-Size="XX-Small" SetFocusOnError="true" />
                                                </EditItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Complex Alt Name">
                                                <InsertItemTemplate>
                                                    <asp:TextBox runat="server" Text='<%# Bind("NameAlt") %>' ID="txtNameAlt" CssClass="form-control"></asp:TextBox>
                                                </InsertItemTemplate>

                                                <EditItemTemplate>
                                                    <asp:TextBox runat="server" Text='<%# Bind("NameAlt") %>' ID="txtNameAlt" CssClass="form-control"></asp:TextBox>
                                                </EditItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Abbreviation">
                                                <InsertItemTemplate>
                                                    <asp:TextBox runat="server" Text='<%# Bind("Abbr") %>' ID="txtAbbr" CssClass="form-control"></asp:TextBox>
                                                </InsertItemTemplate>

                                                <EditItemTemplate>
                                                    <asp:TextBox runat="server" Text='<%# Bind("Abbr") %>' ID="txtAbbr" CssClass="form-control"></asp:TextBox>
                                                </EditItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Founded">
                                                <InsertItemTemplate>
                                                    <asp:TextBox runat="server" Text='<%# Bind("Founded","{0:dd MMM yyyy}") %>'
                                                        ID="txtFounded" CssClass="form-control date-picker" AutoCompleteType="Disabled"></asp:TextBox>
                                                </InsertItemTemplate>

                                                <EditItemTemplate>
                                                    <asp:TextBox runat="server" Text='<%# Bind("Founded","{0:dd MMM yyyy}") %>'
                                                        ID="txtFounded" CssClass="form-control date-picker" AutoCompleteType="Disabled"></asp:TextBox>
                                                </EditItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Founded Year">
                                                <InsertItemTemplate>
                                                    <asp:TextBox runat="server" Text='<%# Bind("FoundedYr") %>' ID="txtFoundedYr" MaxLength="4" CssClass="form-control input-number"></asp:TextBox>
                                                    <span class="errmsg" style="color: crimson; font-size: xx-small"></span>
                                                    <asp:RegularExpressionValidator ID="revaltxtFoundedYr" ValidationExpression="^\d+$" ValidationGroup="valResCom"
                                                        ControlToValidate="txtFoundedYr" runat="server" ForeColor="Red" ErrorMessage="*Enter Only Numbers." Font-Size="XX-Small"
                                                        Display="Dynamic" SetFocusOnError="true" />
                                                </InsertItemTemplate>

                                                <EditItemTemplate>
                                                    <asp:TextBox runat="server" Text='<%# Bind("FoundedYr") %>' ID="txtFoundedYr" MaxLength="4" CssClass="form-control input-number"></asp:TextBox>
                                                    <span class="errmsg" style="color: crimson; font-size: xx-small"></span>
                                                    <asp:RegularExpressionValidator ID="revaltxtFoundedYr" ValidationExpression="^\d+$" ValidationGroup="valResCom"
                                                        ControlToValidate="txtFoundedYr" runat="server" ForeColor="Red" ErrorMessage="*Enter Only Numbers." Font-Size="XX-Small"
                                                        Display="Dynamic" SetFocusOnError="true" />
                                                </EditItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Logo">
                                                <InsertItemTemplate>
                                                    <div class="custom-file">
                                                        <asp:FileUpload ID="fuLogo" runat="server" accept="image/*" CssClass="custom-file-input" />
                                                        <asp:Label AssociatedControlID="fuLogo" CssClass="custom-file-label" runat="server" Font-Size="Smaller">Choose File</asp:Label>
                                                    </div>
                                                    <asp:RegularExpressionValidator ID="revalfuLogo" ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.png|.jpg|.bmp|.gif|.jpeg|.tft|.PNG|.JPG|.BMP|.GIF|.JPEG|.TFT)$"
                                                        ControlToValidate="fuLogo" runat="server" ForeColor="Red" ErrorMessage="*Invalid Image Extension." Font-Size="XX-Small"
                                                        Display="Dynamic" ValidationGroup="valResCom" />
                                                </InsertItemTemplate>

                                                <EditItemTemplate>

                                                    <div class="custom-file">
                                                        <asp:FileUpload ID="fuLogo" runat="server" accept="image/*" CssClass="custom-file-input" />
                                                        <asp:Label AssociatedControlID="fuLogo" CssClass="custom-file-label" runat="server" Font-Size="Smaller">Choose File</asp:Label>
                                                    </div>
                                                    <asp:RegularExpressionValidator ID="revalfuLogo" ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.png|.jpg|.bmp|.gif|.jpeg|.tft|.PNG|.JPG|.BMP|.GIF|.JPEG|.TFT)$"
                                                        ControlToValidate="fuLogo" runat="server" ForeColor="Red" ErrorMessage="*Invalid Image Extension." Font-Size="XX-Small"
                                                        Display="Dynamic" ValidationGroup="valResCom" />
                                                </EditItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Cover Image">
                                                <InsertItemTemplate>

                                                    <div class="custom-file">
                                                        <asp:FileUpload ID="fuCoverImg" runat="server" accept="image/*" CssClass="custom-file-input" />
                                                        <asp:Label AssociatedControlID="fuCoverImg" CssClass="custom-file-label" runat="server" Font-Size="Smaller">Choose File</asp:Label>
                                                    </div>
                                                    <asp:RegularExpressionValidator ID="revalfuCoverImg" ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.png|.jpg|.bmp|.gif|.jpeg|.tft|.PNG|.JPG|.BMP|.GIF|.JPEG|.TFT)$"
                                                        ControlToValidate="fuCoverImg" runat="server" ForeColor="Red" ErrorMessage="*Invalid Image Extension." Font-Size="XX-Small"
                                                        Display="Dynamic" ValidationGroup="valResCom" />
                                                </InsertItemTemplate>

                                                <EditItemTemplate>

                                                    <div class="custom-file">
                                                        <asp:FileUpload ID="fuCoverImg" runat="server" accept="image/*" CssClass="custom-file-input" />
                                                        <asp:Label AssociatedControlID="fuCoverImg" CssClass="custom-file-label" runat="server" Font-Size="Smaller">Choose File</asp:Label>
                                                    </div>
                                                    <asp:RegularExpressionValidator ID="revalfuCoverImg" ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.png|.jpg|.bmp|.gif|.jpeg|.tft|.PNG|.JPG|.BMP|.GIF|.JPEG|.TFT)$"
                                                        ControlToValidate="fuCoverImg" runat="server" ForeColor="Red" ErrorMessage="*Invalid Image Extension." Font-Size="XX-Small"
                                                        Display="Dynamic" ValidationGroup="valResCom" />
                                                </EditItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Mark deleted?:" InsertVisible="false">
                                                <EditItemTemplate>
                                                    <asp:RadioButtonList runat="server" ID="rbtnDel" RepeatDirection="Horizontal" SelectedValue='<%# Bind("IsDel") %>'>
                                                        <asp:ListItem Value="True" Selected="False">
                                                            Yes
                                                        </asp:ListItem>
                                                        <asp:ListItem Value="False" Selected="False">
                                                            No
                                                        </asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:CommandField ShowInsertButton="true" InsertText="Submit" ValidationGroup="valResCom" ButtonType="Button"
                                                ControlStyle-CssClass="btn btn-outline-primary btn-sm" />
                                            <asp:CommandField ShowEditButton="true" EditText="Update" ValidationGroup="valResCom" ButtonType="Button"
                                                ControlStyle-CssClass="btn btn-outline-primary btn-sm" />


                                        </Fields>

                                    </asp:DetailsView>

                                    <asp:SqlDataSource runat="server" ID="sqldvwResCom" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                        InsertCommand="ResidentialComplex_Dvw_Ins_AdminG" InsertCommandType="StoredProcedure"
                                        SelectCommand="ResidentialComplex_Dvw_Sel_AdminG" SelectCommandType="StoredProcedure"
                                        UpdateCommand="ResidentialComplex_Dvw_Upd_AdminG" UpdateCommandType="StoredProcedure">
                                        <InsertParameters>
                                            <asp:Parameter Name="Name" Type="String" />
                                            <asp:Parameter Name="NameAlt" Type="String" />
                                            <asp:Parameter Name="Abbr" Type="String" />
                                            <asp:ControlParameter ControlID="ddlResiComCat" Name="ResComCatId" PropertyName="SelectedValue" Type="Int32" />
                                            <asp:Parameter Name="ParentId" Type="Int32" DefaultValue="0" />
                                            <asp:Parameter Name="DistrictId" Type="Int32" DefaultValue="0" />
                                            <asp:Parameter Name="StateId" Type="Int32" DefaultValue="0" />
                                            <asp:Parameter Name="CountryId" Type="Int32" DefaultValue="0" />
                                            <asp:Parameter Name="Founded" Type="DateTime" />
                                            <asp:Parameter Name="FoundedYr" Type="Int32" />
                                            <asp:Parameter Name="Logo" Type="String" />
                                            <asp:Parameter Name="CoverImg" Type="String" />
                                            <asp:Parameter Name="CrBY" Type="String" />
                                            <asp:Parameter Name="CrDt" Type="DateTime" />
                                            <asp:Parameter Name="CrByIP" Type="String" />
                                        </InsertParameters>
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="gvwResCom" Name="Id" PropertyName="SelectedValue" Type="Int32" />
                                        </SelectParameters>
                                        <UpdateParameters>
                                            <asp:Parameter Name="Name" Type="String" />
                                            <asp:Parameter Name="NameAlt" Type="String" />
                                            <asp:Parameter Name="Abbr" Type="String" />
                                            <asp:Parameter Name="Founded" Type="DateTime" />
                                            <asp:Parameter Name="FoundedYr" Type="Int32" />
                                            <asp:Parameter Name="Logo" Type="String" />
                                            <asp:Parameter Name="CoverImg" Type="String" />
                                            <asp:Parameter Name="IsDel" Type="Boolean" />
                                            <asp:Parameter Name="ModBy" Type="String" />
                                            <asp:Parameter Name="ModDt" Type="DateTime" />
                                            <asp:Parameter Name="ModByIP" Type="String" />
                                            <asp:Parameter Name="Id" Type="Int32" />
                                        </UpdateParameters>
                                    </asp:SqlDataSource>

                                    
                                    <asp:GridView ID="gvwResCom" runat="server" AutoGenerateColumns="False"
                                        DataKeyNames="Id" OnSelectedIndexChanged="gvwResCom_SelectedIndexChanged"
                                        EmptyDataText="There is no data to show." CssClass="table table-bordered table-responsive-sm table-sm table-condensed table-striped"
                                        DataSourceID="sqlgvwResCom">
                                        <Columns>
                                            <asp:TemplateField HeaderText="#">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Name">

                                                <ItemTemplate>
                                                    <asp:Label runat="server" Text='<%# Eval("Name") %>' ID="lblName"></asp:Label>
                                                    <asp:Label runat="server" Text='<%# "("+ Eval("Abbr") + ")" %>' Visible='<%#(Eval("Abbr")).ToString()!=""? true:false %>' ID="lblAbbr"></asp:Label>
                                                    <div>
                                                        <asp:Label runat="server" Text='<%# "("+ Eval("NameAlt") + ")" %>' Visible='<%#(Eval("NameAlt")).ToString()!=""? true:false %>' ID="lblNameAlt"></asp:Label>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Date">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" Text='<%# Eval("FoundedYr") %>' ID="lblFoundedYr"></asp:Label>
                                                    <div>
                                                        <asp:Label runat="server" Text='<%# "("+ Eval("Founded","{0:dd MMM yyyy}") + ")" %>' Visible='<%#(Eval("Founded")).ToString()!=""? true:false %>' ID="lblFounded"></asp:Label>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Image">
                                                <ItemTemplate>

                                                    <div style="margin-bottom: 5px">
                                                        <asp:Image ID="imgLogo" runat="server" ImageUrl='<%# Bind("Logo") %>' CssClass="img-fluid"
                                                            Visible='<%#(Eval("Logo")).ToString()!=""? true:false %>' Width="100px" />
                                                    </div>

                                                    <div>
                                                        <asp:Image ID="imgCoverImg" runat="server" ImageUrl='<%# Bind("CoverImg") %>'
                                                            Visible='<%#(Eval("CoverImg")).ToString()!=""? true:false %>'
                                                            CssClass="img-fluid" Width="100px" />
                                                    </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:CommandField ShowSelectButton="true" SelectText="Select" ControlStyle-CssClass="btn btn-outline-success btn-sm" />
                                        </Columns>

                                    </asp:GridView>

                                    <asp:SqlDataSource runat="server" ID="sqlgvwResCom" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                        SelectCommand="ResidentialComplex_Gvw_Sel_AdminG" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="ddlResiComCat" Name="ResComCatId" PropertyName="SelectedValue" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>

                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:PostBackTrigger ControlID="dvwResCom" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                    <div class="col-sm-2">
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
