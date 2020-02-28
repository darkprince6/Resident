<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssoOfficeBearers.aspx.cs" Inherits="Resident.WebPage.AdminG.AssoOfficeBearers" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <link href="../../ContentProject/Admin/AssoOfficeBearers.css" rel="stylesheet" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="../../ScriptsProject/AssoOfficeBearers.js"></script>
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
                                    Here you can add Office Bearers Details :
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
                            <div id="divddlAssoPosts" runat="server" visible="true">
                                <asp:DropDownList ID="ddlAssoPosts" runat="server" CssClass="form-control" DataSourceID="sqlddlAssoPosts" DataTextField="PName"
                                    DataValueField="Id" OnDataBound="ddlAssoPosts_DataBound" AutoPostBack="true" OnSelectedIndexChanged="ddlAssoPosts_SelectedIndexChanged">
                                </asp:DropDownList>
                                <asp:SqlDataSource runat="server" ID="sqlddlAssoPosts" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                    SelectCommand="AssoPosts_ddl_Sel_AdminG" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
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
                            <div id="divAssoOB" runat="server" visible="false">

                                <asp:DetailsView ID="dvwAssoOB" runat="server" AutoGenerateRows="False" DefaultMode="Insert" DataKeyNames="Id"
                                    CssClass="table table-bordered table-condensed table-responsive-sm table-sm"
                                    OnItemInserting="dvwAssoOB_ItemInserting" HeaderText="Enter Office Bearers details" HeaderStyle-ForeColor="#032e3a" HeaderStyle-BackColor="#d9edf7"
                                    OnItemInserted="dvwAssoOB_ItemInserted" OnItemUpdating="dvwAssoOB_ItemUpdating" OnItemUpdated="dvwAssoOB_ItemUpdated"
                                    DataSourceID="sqlAssoOB">
                                    <EditRowStyle HorizontalAlign="Left" />
                                    <Fields>
                                        <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id"></asp:BoundField>
                                        <asp:TemplateField HeaderText="Image" InsertVisible="false">
                                            <ItemTemplate>
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
                                                    runat="server" Display="Dynamic" ValidationGroup="valAssoOB" Font-Size="XX-Small" SetFocusOnError="true" />
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("Name") %>' ID="txtName" CssClass="form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtName"
                                                    runat="server" Display="Dynamic" ValidationGroup="valAssoOB" Font-Size="XX-Small" SetFocusOnError="true" />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="OB">
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" ID="txtOBName" CssClass="form-control txt-OB"></asp:TextBox>
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" ID="txtOBName" CssClass="form-control txt-OB"></asp:TextBox>

                                            </EditItemTemplate>
                                        </asp:TemplateField>


                                        <asp:TemplateField HeaderText="From Date">
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("DateFrom","{0:dd MMM yyyy}") %>'
                                                    ID="txtDateFrom" CssClass="form-control date-picker" AutoCompleteType="Disabled"></asp:TextBox>
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("DateFrom","{0:dd MMM yyyy}") %>'
                                                    ID="txtDateFrom" CssClass="form-control date-picker" AutoCompleteType="Disabled"></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="To Date">
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("DateTo","{0:dd MMM yyyy}") %>'
                                                    ID="txtDateTo" CssClass="form-control date-picker" AutoCompleteType="Disabled"></asp:TextBox>
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("DateTo","{0:dd MMM yyyy}") %>'
                                                    ID="txtDateTo" CssClass="form-control date-picker" AutoCompleteType="Disabled"></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="From Year">
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("YearFrom") %>' ID="txtYearFrom" MaxLength="4" CssClass="form-control input-number"></asp:TextBox>
                                                <span class="errmsg" style="color: crimson; font-size: xx-small"></span>
                                                <asp:RegularExpressionValidator ID="revaltxtYearFrom" ValidationExpression="^\d+$" ValidationGroup="valAssoOB"
                                                    ControlToValidate="txtYearFrom" runat="server" ForeColor="Red" ErrorMessage="*Enter Only Numbers." Font-Size="XX-Small"
                                                    Display="Dynamic" SetFocusOnError="true" />
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("YearFrom") %>' ID="txtYearFrom" MaxLength="4" CssClass="form-control input-number"></asp:TextBox>
                                                <span class="errmsg" style="color: crimson; font-size: xx-small"></span>
                                                <asp:RegularExpressionValidator ID="revaltxtYearFrom" ValidationExpression="^\d+$" ValidationGroup="valAssoOB"
                                                    ControlToValidate="txtYearFrom" runat="server" ForeColor="Red" ErrorMessage="*Enter Only Numbers." Font-Size="XX-Small"
                                                    Display="Dynamic" SetFocusOnError="true" />
                                            </EditItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="To Year">
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("YearTo") %>' ID="txtYearTo" MaxLength="4" CssClass="form-control input-number"></asp:TextBox>
                                                <span class="errmsg" style="color: crimson; font-size: xx-small"></span>
                                                <asp:RegularExpressionValidator ID="revaltxtYearTo" ValidationExpression="^\d+$" ValidationGroup="valAssoOB"
                                                    ControlToValidate="txtYearTo" runat="server" ForeColor="Red" ErrorMessage="*Enter Only Numbers." Font-Size="XX-Small"
                                                    Display="Dynamic" SetFocusOnError="true" />
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("YearTo") %>' ID="txtYearTo" MaxLength="4" CssClass="form-control input-number"></asp:TextBox>
                                                <span class="errmsg" style="color: crimson; font-size: xx-small"></span>
                                                <asp:RegularExpressionValidator ID="revaltxtYearTo" ValidationExpression="^\d+$" ValidationGroup="valAssoOB"
                                                    ControlToValidate="txtYearTo" runat="server" ForeColor="Red" ErrorMessage="*Enter Only Numbers." Font-Size="XX-Small"
                                                    Display="Dynamic" SetFocusOnError="true" />
                                            </EditItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Date Of Birth">
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("DoB","{0:dd MMM yyyy}") %>'
                                                    ID="txtDoB" CssClass="form-control date-picker" AutoCompleteType="Disabled"></asp:TextBox>
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("DoB","{0:dd MMM yyyy}") %>'
                                                    ID="txtDoB" CssClass="form-control date-picker" AutoCompleteType="Disabled"></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Age">
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("Age") %>' ID="txtAge" MaxLength="3" CssClass="form-control input-number"></asp:TextBox>
                                                <span class="errmsg" style="color: crimson; font-size: xx-small"></span>
                                                <asp:RegularExpressionValidator ID="revaltxtAge" ValidationExpression="^\d+$" ValidationGroup="valAssoOB"
                                                    ControlToValidate="txtAge" runat="server" ForeColor="Red" ErrorMessage="*Enter Only Numbers." Font-Size="XX-Small"
                                                    Display="Dynamic" SetFocusOnError="true" />
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("Age") %>' ID="txtAge" MaxLength="3" CssClass="form-control input-number"></asp:TextBox>
                                                <span class="errmsg" style="color: crimson; font-size: xx-small"></span>
                                                <asp:RegularExpressionValidator ID="revaltxtAge" ValidationExpression="^\d+$" ValidationGroup="valAssoOB"
                                                    ControlToValidate="txtAge" runat="server" ForeColor="Red" ErrorMessage="*Enter Only Numbers." Font-Size="XX-Small"
                                                    Display="Dynamic" SetFocusOnError="true" />
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
                                                    Display="Dynamic" ValidationGroup="valAssoOB" />
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <div class="custom-file">
                                                    <asp:FileUpload ID="fuImage1" runat="server" accept="image/*" CssClass="custom-file-input" />
                                                    <asp:Label AssociatedControlID="fuImage1" CssClass="custom-file-label" runat="server" Font-Size="Smaller">Choose File</asp:Label>
                                                </div>
                                                <asp:RegularExpressionValidator ID="revalfuImage1" ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.png|.jpg|.bmp|.gif|.jpeg|.tft|.PNG|.JPG|.BMP|.GIF|.JPEG|.TFT)$"
                                                    ControlToValidate="fuImage1" runat="server" ForeColor="Red" ErrorMessage="*Invalid Image Extension." Font-Size="XX-Small"
                                                    Display="Dynamic" ValidationGroup="valAssoOB" />
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

                                        <asp:CommandField ShowInsertButton="true" InsertText="Submit" ValidationGroup="valAssoOB" ButtonType="Button"
                                            ControlStyle-CssClass="btn btn-outline-primary btn-sm" />
                                        <asp:CommandField ShowEditButton="true" EditText="Update" ValidationGroup="valAssoOB" ButtonType="Button"
                                            ControlStyle-CssClass="btn btn-outline-primary btn-sm" />
                                    </Fields>

                                </asp:DetailsView>

                                <asp:SqlDataSource runat="server" ID="sqlAssoOB" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                    InsertCommand="AssoOfficeBearers_Dvw_Ins_AdminG" InsertCommandType="StoredProcedure"
                                    SelectCommand="AssoOfficeBearers_Dvw_Sel_AdminG" SelectCommandType="StoredProcedure"
                                    UpdateCommand="AssoOfficeBearers_Dvw_Upd_AdminG" UpdateCommandType="StoredProcedure">
                                    <InsertParameters>
                                        <asp:Parameter Name="ResComId" Type="Int32" DefaultValue="0" />
                                        <asp:Parameter Name="AssoId" Type="Int32" DefaultValue="0" />
                                        <asp:ControlParameter ControlID="ddlAssoPosts" Name="AssoPostId" PropertyName="SelectedValue" Type="Int32" />
                                        <asp:Parameter Name="AssoEId" Type="Int32" DefaultValue="0" />
                                        <asp:Parameter Name="AssoECandiId" Type="Int32" DefaultValue="0" />
                                        <asp:Parameter Name="ResComBondId" Type="Int32" DefaultValue="0" />
                                        <asp:Parameter Name="Name" Type="String" />
                                        <asp:Parameter Name="DateFrom" Type="DateTime" />
                                        <asp:Parameter Name="DateTo" Type="DateTime" />
                                        <asp:Parameter Name="YearFrom" Type="Int32" />
                                        <asp:Parameter Name="YearTo" Type="Int32" />
                                        <asp:Parameter Name="DoB" Type="DateTime" />
                                        <asp:Parameter Name="Age" Type="Int32" />
                                        <asp:Parameter Name="Image1" Type="String" />
                                        <asp:Parameter Name="CrBY" Type="String" />
                                        <asp:Parameter Name="CrDt" Type="DateTime" />
                                        <asp:Parameter Name="CrByIP" Type="String" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="gvwAssoOB" Name="Id" PropertyName="SelectedValue" Type="Int32" />
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="Name" Type="String" />
                                        <asp:Parameter Name="DateFrom" Type="DateTime" />
                                        <asp:Parameter Name="DateTo" Type="DateTime" />
                                        <asp:Parameter Name="YearFrom" Type="Int32" />
                                        <asp:Parameter Name="YearTo" Type="Int32" />
                                        <asp:Parameter Name="DoB" Type="DateTime" />
                                        <asp:Parameter Name="Age" Type="Int32" />
                                        <asp:Parameter Name="Image1" Type="String" />
                                        <asp:Parameter Name="IsDel" Type="Boolean" />
                                        <asp:Parameter Name="ModBy" Type="String" />
                                        <asp:Parameter Name="ModDt" Type="DateTime" />
                                        <asp:Parameter Name="ModByIP" Type="String" />
                                        <asp:Parameter Name="Id" Type="Int32" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>


                                <asp:GridView ID="gvwAssoOB" runat="server" AutoGenerateColumns="False"
                                    DataKeyNames="Id" OnSelectedIndexChanged="gvwAssoOB_SelectedIndexChanged"
                                    EmptyDataText="There is no data to show." CssClass="table table-bordered table-responsive-sm table-sm table-condensed table-striped"
                                    DataSourceID="sqlgvwAssoOB">
                                    <Columns>
                                        <asp:TemplateField HeaderText="#">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Name">

                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# Eval("Name") %>' ID="lblName"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="From - To Date">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# Eval("DateFrom","{0:dd MMM yyyy}") %>' ID="lblDateFrom"></asp:Label>
                                                <span>
                                                    <asp:Label runat="server" Text='<%# " - "+ Eval("DateTo","{0:dd MMM yyyy}") %>'
                                                        Visible='<%#(Eval("DateTo")).ToString()!=""? true:false %>' ID="lblDateTo"></asp:Label>
                                                </span>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="DoB/Age">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# "DoB- " + Eval("DoB","{0:dd MMM yyyy}") %>' ID="lblDoB"
                                                    Visible='<%#(Eval("DoB")).ToString()!=""? true:false %>'></asp:Label>
                                                <div>
                                                    <asp:Label runat="server" Text='<%# "Age- "+ Eval("Age") %>'
                                                        Visible='<%#(Eval("Age")).ToString()!=""? true:false %>' ID="lblAge"></asp:Label>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Image">
                                            <ItemTemplate>
                                                <asp:Image ID="img" runat="server" ImageUrl='<%# Bind("Image1") %>'
                                                    Visible='<%#(Eval("Image1")).ToString()!=""? true:false %>'
                                                    CssClass="img-fluid" Width="100px" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ShowSelectButton="true" SelectText="Select" ControlStyle-CssClass="btn btn-outline-success btn-sm" />
                                    </Columns>
                                </asp:GridView>

                                <asp:SqlDataSource runat="server" ID="sqlgvwAssoOB" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                    SelectCommand="AssoOfficeBearers_Gvw_Sel_AdminG" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="ddlAssoPosts" Name="AssoPostId" PropertyName="SelectedValue" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="dvwAssoOB" />
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
