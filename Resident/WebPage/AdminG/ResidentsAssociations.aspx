<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResidentsAssociations.aspx.cs" Inherits="Resident.WebPage.AdminG.ResidentsAssociations" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <link href="../../ContentProject/Admin/ResidentsAssociations.css" rel="stylesheet" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="../../ScriptsProject/ResidentsAssociations.js"></script>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="container">
            <div class="row">
                <div class="col-sm-2"></div>

                <div class="col-sm-8">
                    <div style="background-color: #d7ccc8; text-align: center; margin-bottom: 5px; margin-top: 4px; font-weight: 600">
                        <asp:Label runat="server" ID="lblHead" Font-Size="19px">
                                    Here you can add Residential Associations Details :
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
                            <div id="divddlResiCom" runat="server" visible="true">
                                <asp:DropDownList ID="ddlResiCom" runat="server" CssClass="form-control" DataSourceID="sqlddlResiCom" DataTextField="Name"
                                    DataValueField="Id" OnDataBound="ddlResiCom_DataBound" AutoPostBack="true" OnSelectedIndexChanged="ddlResiCom_SelectedIndexChanged">
                                </asp:DropDownList>
                                <asp:SqlDataSource runat="server" ID="sqlddlResiCom" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                    SelectCommand="ResidentialComplex_ddl_Sel_AdminG" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
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
                            <div id="divResAsso" runat="server" visible="false">

                                <asp:DetailsView ID="dvwResAsso" runat="server" AutoGenerateRows="False" DefaultMode="Insert" DataKeyNames="Id"
                                    CssClass="table table-bordered table-condensed table-responsive-sm table-sm"
                                    OnItemInserting="dvwResAsso_ItemInserting" HeaderText="Enter Residential Associations details" HeaderStyle-ForeColor="#032e3a" HeaderStyle-BackColor="#d9edf7"
                                    OnItemInserted="dvwResAsso_ItemInserted" OnItemUpdating="dvwResAsso_ItemUpdating" OnItemUpdated="dvwResAsso_ItemUpdated"
                                    DataSourceID="sqldvwResAsso">
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
                                                    <asp:Image ID="img1" runat="server" ImageUrl='<%# Bind("Image1") %>' CssClass="img-fluid" Width="75px" />
                                                    <asp:HiddenField ID="hdnImage1" runat="server" Value='<%# Bind("Image1") %>' />

                                                </span>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Name">
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("Name") %>' ID="txtName" CssClass="form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtName"
                                                    runat="server" Display="Dynamic" ValidationGroup="valResAsso" Font-Size="XX-Small" SetFocusOnError="true" />
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("Name") %>' ID="txtName" CssClass="form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtName"
                                                    runat="server" Display="Dynamic" ValidationGroup="valResAsso" Font-Size="XX-Small" SetFocusOnError="true" />
                                            </EditItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Alt Name">
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

                                        <asp:TemplateField HeaderText="Start Date">
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("StartDt","{0:dd MMM yyyy}") %>'
                                                    ID="txtStartDate" CssClass="form-control date-picker" AutoCompleteType="Disabled"></asp:TextBox>
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("StartDt","{0:dd MMM yyyy}") %>'
                                                    ID="txtStartDate" CssClass="form-control date-picker" AutoCompleteType="Disabled"></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Start Year">
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("StartYr") %>' ID="txtStartYr" MaxLength="4" CssClass="form-control input-number"></asp:TextBox>
                                                <span class="errmsg" style="color: crimson; font-size: xx-small"></span>
                                                <asp:RegularExpressionValidator ID="revaltxtStartYr" ValidationExpression="^\d+$" ValidationGroup="valResAsso"
                                                    ControlToValidate="txtStartYr" runat="server" ForeColor="Red" ErrorMessage="*Enter Only Numbers." Font-Size="XX-Small"
                                                    Display="Dynamic" SetFocusOnError="true" />
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("StartYr") %>' ID="txtStartYr" MaxLength="4" CssClass="form-control input-number"></asp:TextBox>
                                                <span class="errmsg" style="color: crimson; font-size: xx-small"></span>
                                                <asp:RegularExpressionValidator ID="revaltxtStartYr" ValidationExpression="^\d+$" ValidationGroup="valResAsso"
                                                    ControlToValidate="txtStartYr" runat="server" ForeColor="Red" ErrorMessage="*Enter Only Numbers." Font-Size="XX-Small"
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
                                                    Display="Dynamic" ValidationGroup="valResAsso" />
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                 <div class="custom-file">
                                                    <asp:FileUpload ID="fuLogo" runat="server" accept="image/*" CssClass="custom-file-input" />
                                                    <asp:Label AssociatedControlID="fuLogo" CssClass="custom-file-label" runat="server" Font-Size="Smaller">Choose File</asp:Label>
                                                </div>
                                                <asp:RegularExpressionValidator ID="revalfuLogo" ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.png|.jpg|.bmp|.gif|.jpeg|.tft|.PNG|.JPG|.BMP|.GIF|.JPEG|.TFT)$"
                                                    ControlToValidate="fuLogo" runat="server" ForeColor="Red" ErrorMessage="*Invalid Image Extension." Font-Size="XX-Small"
                                                    Display="Dynamic" ValidationGroup="valResAsso" />
                                            </EditItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Image">
                                            <InsertItemTemplate>
                                                <div class="custom-file">
                                                    <asp:FileUpload ID="fuImage1" runat="server" accept="image/*" CssClass="custom-file-input" />
                                                    <asp:Label AssociatedControlID="fuImage1" CssClass="custom-file-label" runat="server" Font-Size="Smaller">Choose File</asp:Label>
                                                </div>
                                                <asp:RegularExpressionValidator ID="revalfuImage1" ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.png|.jpg|.bmp|.gif|.jpeg|.tft|.PNG|.JPG|.BMP|.GIF|.JPEG|.TFT)$"
                                                    ControlToValidate="fuImage1" runat="server" ForeColor="Red" ErrorMessage="*Invalid Image Extension." Font-Size="XX-Small"
                                                    Display="Dynamic" ValidationGroup="valResAsso" />
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                 <div class="custom-file">
                                                    <asp:FileUpload ID="fuImage1" runat="server" accept="image/*" CssClass="custom-file-input" />
                                                    <asp:Label AssociatedControlID="fuImage1" CssClass="custom-file-label" runat="server" Font-Size="Smaller">Choose File</asp:Label>
                                                </div>
                                                <asp:RegularExpressionValidator ID="revalfuImage1" ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.png|.jpg|.bmp|.gif|.jpeg|.tft|.PNG|.JPG|.BMP|.GIF|.JPEG|.TFT)$"
                                                    ControlToValidate="fuImage1" runat="server" ForeColor="Red" ErrorMessage="*Invalid Image Extension." Font-Size="XX-Small"
                                                    Display="Dynamic" ValidationGroup="valResAsso" />
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
                                        <asp:CommandField ShowInsertButton="true" InsertText="Submit" ValidationGroup="valResAsso" ButtonType="Button"
                                            ControlStyle-CssClass="btn btn-outline-primary btn-sm" />
                                        <asp:CommandField ShowEditButton="true" EditText="Update" ValidationGroup="valResAsso" ButtonType="Button"
                                            ControlStyle-CssClass="btn btn-outline-primary btn-sm" />
                                    </Fields>

                                </asp:DetailsView>

                                <asp:SqlDataSource runat="server" ID="sqldvwResAsso" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                    InsertCommand="ResidentsAssociations_Dvw_Ins_AdminG" InsertCommandType="StoredProcedure"
                                    SelectCommand="ResidentsAssociations_Dvw_Sel_AdminG" SelectCommandType="StoredProcedure"
                                    UpdateCommand="ResidentsAssociations_Dvw_Upd_AdminG" UpdateCommandType="StoredProcedure">
                                    <InsertParameters>
                                        <asp:Parameter Name="Name" Type="String" />
                                        <asp:Parameter Name="NameAlt" Type="String" />
                                        <asp:Parameter Name="Abbr" Type="String" />
                                        <asp:ControlParameter ControlID="ddlResiCom" Name="ResComId" PropertyName="SelectedValue" Type="Int32" />
                                        <asp:Parameter Name="StartDt" Type="DateTime" />
                                        <asp:Parameter Name="StartYr" Type="Int32" />
                                        <asp:Parameter Name="Logo" Type="String" />
                                        <asp:Parameter Name="Image1" Type="String" />
                                        <asp:Parameter Name="CrBY" Type="String" />
                                        <asp:Parameter Name="CrDt" Type="DateTime" />
                                        <asp:Parameter Name="CrByIP" Type="String" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="gvwResAsso" Name="Id" PropertyName="SelectedValue" Type="Int32" />
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="Name" Type="String" />
                                        <asp:Parameter Name="NameAlt" Type="String" />
                                        <asp:Parameter Name="Abbr" Type="String" />
                                        <asp:Parameter Name="StartDt" Type="DateTime" />
                                        <asp:Parameter Name="StartYr" Type="Int32" />
                                        <asp:Parameter Name="Logo" Type="String" />
                                        <asp:Parameter Name="Image1" Type="String" />
                                        <asp:Parameter Name="IsDel" Type="Boolean" />
                                        <asp:Parameter Name="ModBy" Type="String" />
                                        <asp:Parameter Name="ModDt" Type="DateTime" />
                                        <asp:Parameter Name="ModByIP" Type="String" />
                                        <asp:Parameter Name="Id" Type="Int32" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>


                                <asp:GridView ID="gvwResAsso" runat="server" AutoGenerateColumns="False"
                                    DataKeyNames="Id" OnSelectedIndexChanged="gvwResAsso_SelectedIndexChanged"
                                    EmptyDataText="There is no data to show." CssClass="table table-bordered table-responsive-sm table-sm table-condensed table-striped"
                                    DataSourceID="sqlgvwResAsso">
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
                                                <asp:Label runat="server" Text='<%# Eval("StartYr") %>' ID="lblStartYr"></asp:Label>
                                                <div>
                                                    <asp:Label runat="server" Text='<%# "("+ Eval("StartDt","{0:dd MMM yyyy}") + ")" %>'
                                                        Visible='<%#(Eval("StartDt")).ToString()!=""? true:false %>' ID="lblStartDt"></asp:Label>
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
                                                    <asp:Image ID="img" runat="server" ImageUrl='<%# Bind("Image1") %>'
                                                        Visible='<%#(Eval("Image1")).ToString()!=""? true:false %>'
                                                        CssClass="img-fluid" Width="100px" />
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ShowSelectButton="true" SelectText="Select" ControlStyle-CssClass="btn btn-outline-success btn-sm" />
                                    </Columns>

                                </asp:GridView>

                                <asp:SqlDataSource runat="server" ID="sqlgvwResAsso" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                    SelectCommand="ResidentsAssociations_Gvw_Sel_AdminG" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="ddlResiCom" Name="ResComId" PropertyName="SelectedValue" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="dvwResAsso" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
                <div class="col-sm-2">
                </div>
            </div>
        </div>
    </form>
</body>
</html>
