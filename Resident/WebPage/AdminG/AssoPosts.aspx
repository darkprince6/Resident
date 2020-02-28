<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssoPosts.aspx.cs" Inherits="Resident.WebPage.AdminG.AssoPosts" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="../../ScriptsProject/AssoPosts.js"></script>

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
                                    Here you can add Associate Posts Details :
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
                            <div id="divddlAssoReg" runat="server" visible="true">
                                <asp:DropDownList ID="ddlAssoReg" runat="server" CssClass="form-control" DataSourceID="sqlddlAssoReg" DataTextField="RegisNumber"
                                    DataValueField="Id" OnDataBound="ddlAssoReg_DataBound" AutoPostBack="true" OnSelectedIndexChanged="ddlAssoReg_SelectedIndexChanged">
                                </asp:DropDownList>
                                <asp:SqlDataSource runat="server" ID="sqlddlAssoReg" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                    SelectCommand="AssoRegistrations_ddl_Sel_AdminG" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
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
                            <div id="divAssoPosts" runat="server" visible="false">

                                <asp:DetailsView ID="dvwAssoPosts" runat="server" AutoGenerateRows="False" DefaultMode="Insert" DataKeyNames="Id"
                                    CssClass="table table-bordered table-condensed table-responsive-sm table-sm"
                                    OnItemInserting="dvwAssoPosts_ItemInserting" HeaderText="Enter Residential Associate Posts details" HeaderStyle-ForeColor="#032e3a" HeaderStyle-BackColor="#d9edf7"
                                    OnItemInserted="dvwAssoPosts_ItemInserted" OnItemUpdating="dvwAssoPosts_ItemUpdating" OnItemUpdated="dvwAssoPosts_ItemUpdated"
                                    DataSourceID="sqldvwAssoPosts">
                                    <EditRowStyle HorizontalAlign="Left" />
                                    <Fields>
                                        <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id"></asp:BoundField>

                                        <asp:TemplateField HeaderText="Post Name *">
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("PName") %>' ID="txtPName" CssClass="form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtPName"
                                                    runat="server" Display="Dynamic" ValidationGroup="valAssoPosts" Font-Size="XX-Small" SetFocusOnError="true" />
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("PName") %>' ID="txtPName" CssClass="form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtPName"
                                                    runat="server" Display="Dynamic" ValidationGroup="valAssoPosts" Font-Size="XX-Small" SetFocusOnError="true" />
                                            </EditItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Alt Name">
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("PNameAlt") %>' ID="txtPNameAlt" CssClass="form-control"></asp:TextBox>
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("PNameAlt") %>' ID="txtPNameAlt" CssClass="form-control"></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Abbreviation">
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("Abbr") %>'
                                                    ID="txtAbbr" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("Abbr") %>'
                                                    ID="txtAbbr" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Number">
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("Numbers") %>' ID="txtNumber" CssClass="form-control input-number" MaxLength="2"></asp:TextBox>
                                                <span class="errmsg" style="color: crimson; font-size: xx-small"></span>
                                                 <asp:RegularExpressionValidator ID="revalNumbers" ValidationExpression="^\d+$" ValidationGroup="valAssoPosts"
                                                    ControlToValidate="txtNumber" runat="server" ForeColor="Red" ErrorMessage="*Enter Only Numbers." Font-Size="XX-Small"
                                                    Display="Dynamic" SetFocusOnError="true" />
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("Numbers") %>' ID="txtNumber" CssClass="form-control input-number" MaxLength="2"></asp:TextBox>
                                                <span class="errmsg" style="color: crimson; font-size: xx-small"></span>
                                                <asp:RegularExpressionValidator ID="revalNumbers" ValidationExpression="^\d+$" ValidationGroup="valAssoPosts"
                                                    ControlToValidate="txtNumber" runat="server" ForeColor="Red" ErrorMessage="*Enter Only Numbers." Font-Size="XX-Small"
                                                    Display="Dynamic" SetFocusOnError="true" />
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

                                        <asp:CommandField ShowInsertButton="true" InsertText="Submit" ValidationGroup="valAssoPosts" ButtonType="Button"
                                            ControlStyle-CssClass="btn btn-outline-primary btn-sm" />
                                        <asp:CommandField ShowEditButton="true" EditText="Update" ValidationGroup="valAssoPosts" ButtonType="Button"
                                            ControlStyle-CssClass="btn btn-outline-primary btn-sm" />
                                    </Fields>

                                </asp:DetailsView>

                                <asp:SqlDataSource runat="server" ID="sqldvwAssoPosts" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                    InsertCommand="AssoPosts_Dvw_Ins_AdminG" InsertCommandType="StoredProcedure"
                                    SelectCommand="AssoPosts_Dvw_Sel_AdminG" SelectCommandType="StoredProcedure"
                                    UpdateCommand="AssoPosts_Dvw_Upd_AdminG" UpdateCommandType="StoredProcedure">
                                    <InsertParameters>
                                        <asp:Parameter Name="ResComId" Type="Int32" DefaultValue="1" />
                                        <asp:ControlParameter ControlID="ddlAssoReg" Name="AssoId" PropertyName="SelectedValue" Type="Int32" />
                                        <asp:Parameter Name="PName" Type="String" />
                                        <asp:Parameter Name="PNameAlt" Type="String" />
                                        <asp:Parameter Name="Abbr" Type="String" />
                                        <asp:Parameter Name="Numbers" Type="Int32" DefaultValue="1" />
                                        <asp:Parameter Name="CrBY" Type="String" />
                                        <asp:Parameter Name="CrDt" Type="DateTime" />
                                        <asp:Parameter Name="CrByIP" Type="String" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="gvwAssoPosts" Name="Id" PropertyName="SelectedValue" Type="Int32" />
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="PName" Type="String" />
                                        <asp:Parameter Name="PNameAlt" Type="String" />
                                        <asp:Parameter Name="Abbr" Type="String" />
                                        <asp:Parameter Name="Numbers" Type="Int32" DefaultValue="1" />
                                        <asp:Parameter Name="IsDel" Type="Boolean" />
                                        <asp:Parameter Name="ModBy" Type="String" />
                                        <asp:Parameter Name="ModDt" Type="DateTime" />
                                        <asp:Parameter Name="ModByIP" Type="String" />
                                        <asp:Parameter Name="Id" Type="Int32" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                                <asp:GridView ID="gvwAssoPosts" runat="server" AutoGenerateColumns="False"
                                    DataKeyNames="Id" OnSelectedIndexChanged="gvwAssoPosts_SelectedIndexChanged"
                                    EmptyDataText="There is no data to show." CssClass="table table-bordered table-responsive-sm table-sm table-condensed table-striped"
                                    DataSourceID="sqlgvwAssoPosts">
                                    <Columns>
                                        <asp:TemplateField HeaderText="#">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Post">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# Eval("PName") %>' ID="lblPName"></asp:Label>
                                                <span>
                                                    <asp:Label runat="server" Text='<%# "("+ Eval("Abbr") + ")" %>'
                                                    Visible='<%#(Eval("Abbr")).ToString()!=""? true:false %>' ID="lblAbbr"></asp:Label>
                                                </span>
                                               <div>
                                                   <asp:Label runat="server" Text='<%# "("+ Eval("PNameAlt") + ")" %>' Visible='<%#(Eval("PNameAlt")).ToString()!=""? true:false %>'
                                                        ID="lblPNameAlt"></asp:Label>
                                               </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Number">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# Eval("Numbers") %>' ID="lblNumbers"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ShowSelectButton="true" SelectText="Select" ControlStyle-CssClass="btn btn-outline-success btn-sm" />
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource runat="server" ID="sqlgvwAssoPosts" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                    SelectCommand="AssoPosts_Gvw_Sel_AdminG" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="ddlAssoReg" Name="AssoId" PropertyName="SelectedValue" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="col-sm-2">
                </div>
            </div>
        </div>
    </form>
</body>
</html>
