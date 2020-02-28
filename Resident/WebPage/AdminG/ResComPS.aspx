<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResComPS.aspx.cs" Inherits="Resident.WebPage.AdminG.ResComPS" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>--%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <link href="../../ContentProject/Admin/ResComPS.css" rel="stylesheet" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="../../ScriptsProject/ResComPS.js"></script>
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
                                    Here you can add Residential Complex Police Station Details :
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
                            <div id="divResComPS" runat="server" visible="false">

                                <asp:DetailsView ID="dvwResComPS" runat="server" AutoGenerateRows="False" DefaultMode="Insert" DataKeyNames="Id"
                                    CssClass="table table-bordered table-condensed table-responsive-sm table-sm"
                                    OnItemInserting="dvwResComPS_ItemInserting" HeaderText="Enter Residential Complex Police Station details" HeaderStyle-ForeColor="#032e3a" HeaderStyle-BackColor="#d9edf7"
                                    OnItemInserted="dvwResComPS_ItemInserted" OnItemUpdating="dvwResComPS_ItemUpdating" OnItemUpdated="dvwResComPS_ItemUpdated"
                                    DataSourceID="sqldvwResComPS">
                                    <EditRowStyle HorizontalAlign="Left" />
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

                                        <asp:TemplateField HeaderText="Police Station *">
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("PoliceStation") %>' ID="txtPoliceStation" CssClass="form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtPoliceStation"
                                                    runat="server" Display="Dynamic" ValidationGroup="valResComPS" Font-Size="XX-Small" SetFocusOnError="true" />
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("PoliceStation") %>' ID="txtPoliceStation" CssClass="form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtPoliceStation"
                                                    runat="server" Display="Dynamic" ValidationGroup="valResComPS" Font-Size="XX-Small" SetFocusOnError="true" />
                                            </EditItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Address Line 1 *">
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("Address1") %>' ID="txtAddress1" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtAddress1"
                                                    runat="server" Display="Dynamic" ValidationGroup="valResComPS" Font-Size="XX-Small" SetFocusOnError="true" />
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("Address1") %>' ID="txtAddress1" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtAddress1"
                                                    runat="server" Display="Dynamic" ValidationGroup="valResComPS" Font-Size="XX-Small" SetFocusOnError="true" />
                                            </EditItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Address Line 2">
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("Address2") %>' ID="txtAddress2" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("Address2") %>' ID="txtAddress2" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>


                                        <asp:TemplateField HeaderText="PIN Code *">
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("PinCode") %>' ID="txtPinCode" MaxLength="6" CssClass="form-control input-number"></asp:TextBox>
                                                <span class="errmsg" style="color: crimson; font-size: xx-small"></span>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtPinCode"
                                                    runat="server" Display="Dynamic" ValidationGroup="valResComPS" Font-Size="XX-Small" SetFocusOnError="true" />

                                                <asp:RegularExpressionValidator ID="revalPinCode" ValidationExpression="^\d+$" ValidationGroup="valResComPS"
                                                    ControlToValidate="txtPinCode" runat="server" ForeColor="Red" ErrorMessage="*Enter Only Numbers." Font-Size="XX-Small"
                                                    Display="Dynamic" SetFocusOnError="true" />
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("PinCode") %>' ID="txtPinCode" MaxLength="6" CssClass="form-control input-number"></asp:TextBox>
                                                <span class="errmsg" style="color: crimson; font-size: xx-small"></span>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtPinCode"
                                                    runat="server" Display="Dynamic" ValidationGroup="valResComPS" Font-Size="XX-Small" SetFocusOnError="true" />
                                                <asp:RegularExpressionValidator ID="revalPinCode" ValidationExpression="^\d+$" ValidationGroup="valResComPS"
                                                    ControlToValidate="txtPinCode" runat="server" ForeColor="Red" ErrorMessage="*Enter Only Numbers." Font-Size="XX-Small"
                                                    Display="Dynamic" SetFocusOnError="true" />
                                            </EditItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Phone 1">
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("Phone1") %>' ID="txtPhone1" CssClass="form-control"></asp:TextBox>
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("Phone1") %>' ID="txtPhone1" CssClass="form-control"></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Phone 2">
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("Phone2") %>' ID="txtPhone2" CssClass="form-control"></asp:TextBox>
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("Phone2") %>' ID="txtPhone2" CssClass="form-control"></asp:TextBox>
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
                                                    Display="Dynamic" ValidationGroup="valResComPS" />
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <div class="custom-file">
                                                    <asp:FileUpload ID="fuImage1" runat="server" accept="image/*" CssClass="custom-file-input" />
                                                    <asp:Label AssociatedControlID="fuImage1" CssClass="custom-file-label" runat="server" Font-Size="Smaller">Choose File</asp:Label>
                                                </div>
                                                <asp:RegularExpressionValidator ID="revalfuImage1" ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.png|.jpg|.bmp|.gif|.jpeg|.tft|.PNG|.JPG|.BMP|.GIF|.JPEG|.TFT)$"
                                                    ControlToValidate="fuImage1" runat="server" ForeColor="Red" ErrorMessage="*Invalid Image Extension." Font-Size="XX-Small"
                                                    Display="Dynamic" ValidationGroup="valResComPS" />
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

                                        <asp:CommandField ShowInsertButton="true" InsertText="Submit" ValidationGroup="valResComPS" ButtonType="Button"
                                            ControlStyle-CssClass="btn btn-outline-primary btn-sm" />
                                        <asp:CommandField ShowEditButton="true" EditText="Update" ValidationGroup="valResComPS" ButtonType="Button"
                                            ControlStyle-CssClass="btn btn-outline-primary btn-sm" />
                                    </Fields>

                                </asp:DetailsView>

                                <asp:SqlDataSource runat="server" ID="sqldvwResComPS" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                    InsertCommand="ResComPS_Dvw_Ins_AdminG" InsertCommandType="StoredProcedure"
                                    SelectCommand="ResComPS_Dvw_Sel_AdminG" SelectCommandType="StoredProcedure"
                                    UpdateCommand="ResComPS_Dvw_Upd_AdminG" UpdateCommandType="StoredProcedure">
                                    <InsertParameters>
                                        <asp:ControlParameter ControlID="ddlResiCom" Name="ResComId" PropertyName="SelectedValue" Type="Int32" />
                                        <asp:Parameter Name="PSId" Type="Int32" DefaultValue="0" />
                                        <asp:Parameter Name="PoliceStation" Type="String" />
                                        <asp:Parameter Name="Address1" Type="String" />
                                        <asp:Parameter Name="Address2" Type="String" />
                                        <asp:Parameter Name="PinCode" Type="Int32" />
                                        <asp:Parameter Name="Phone1" Type="String" />
                                        <asp:Parameter Name="Phone2" Type="String" />
                                        <asp:Parameter Name="Image1" Type="String" />
                                        <asp:Parameter Name="CrBY" Type="String" />
                                        <asp:Parameter Name="CrDt" Type="DateTime" />
                                        <asp:Parameter Name="CrByIP" Type="String" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="gvwResComPS" Name="Id" PropertyName="SelectedValue" Type="Int32" />
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="PoliceStation" Type="String" />
                                        <asp:Parameter Name="Address1" Type="String" />
                                        <asp:Parameter Name="Address2" Type="String" />
                                        <asp:Parameter Name="PinCode" Type="Int32" />
                                        <asp:Parameter Name="Phone1" Type="String" />
                                        <asp:Parameter Name="Phone2" Type="String" />
                                        <asp:Parameter Name="Image1" Type="String" />
                                        <asp:Parameter Name="IsDel" Type="Boolean" />
                                        <asp:Parameter Name="ModBy" Type="String" />
                                        <asp:Parameter Name="ModDt" Type="DateTime" />
                                        <asp:Parameter Name="ModByIP" Type="String" />
                                        <asp:Parameter Name="Id" Type="Int32" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>


                                <asp:GridView ID="gvwResComPS" runat="server" AutoGenerateColumns="False"
                                    DataKeyNames="Id" OnSelectedIndexChanged="gvwResComPS_SelectedIndexChanged"
                                    EmptyDataText="There is no data to show." CssClass="table table-bordered table-responsive-sm table-sm table-condensed table-striped"
                                    DataSourceID="sqlResComPS">
                                    <Columns>
                                        <asp:TemplateField HeaderText="#">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Police Station">

                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# Eval("PoliceStation") %>' ID="lblPoliceStation"></asp:Label>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Address">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# Eval("Address1") %>' ID="lblAddress1"></asp:Label>
                                                <div>
                                                    <asp:Label runat="server" Text='<%# Eval("Address2") %>' Visible='<%#(Eval("Address2")).ToString()!=""? true:false %>'
                                                        ID="lblAddress2"></asp:Label>
                                                </div>
                                                <div>
                                                    <span>PIN: </span>
                                                    <asp:Label runat="server" Text='<%# Eval("PinCode") %>' ID="lblPinCode"></asp:Label>

                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Contact Details">
                                            <ItemTemplate>

                                                <div>
                                                    <asp:Label runat="server" Text='<%# Eval("Phone1") %>' Visible='<%#(Eval("Phone1")).ToString()!=""? true:false %>'
                                                        ID="lblPhone1"></asp:Label>
                                                </div>
                                                <div>
                                                    <asp:Label runat="server" Text='<%# Eval("Phone2") %>' Visible='<%#(Eval("Phone2")).ToString()!=""? true:false %>'
                                                        ID="lblPhone2"></asp:Label>
                                                </div>
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

                                <asp:SqlDataSource runat="server" ID="sqlResComPS" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                    SelectCommand="ResComPS_Gvw_Sel_AdminG" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="ddlResiCom" Name="ResComId" PropertyName="SelectedValue" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="dvwResComPS" />
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
