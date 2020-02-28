<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssoRegistrations.aspx.cs" Inherits="Resident.WebPage.AdminG.AssoRegistrations" %>

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
    <script src="../../ScriptsProject/AssoRegistrations.js"></script>
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
                                    Here you can add Associate Registration Details :
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
                            <div id="divAssoReg" runat="server" visible="false">

                                <asp:DetailsView ID="dvwAssoReg" runat="server" AutoGenerateRows="False" DefaultMode="Insert" DataKeyNames="Id"
                                    CssClass="table table-bordered table-condensed table-responsive-sm table-sm"
                                    OnItemInserting="dvwAssoReg_ItemInserting" HeaderText="Enter Residential Associate details" HeaderStyle-ForeColor="#032e3a" HeaderStyle-BackColor="#d9edf7"
                                    OnItemInserted="dvwAssoReg_ItemInserted" OnItemUpdating="dvwAssoReg_ItemUpdating" OnItemUpdated="dvwAssoReg_ItemUpdated"
                                    DataSourceID="sqldvwAssoReg">
                                    <EditRowStyle HorizontalAlign="Left" />
                                    <Fields>
                                        <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id"></asp:BoundField>

                                        <asp:TemplateField HeaderText="Registration Number *">
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("RegisNumber") %>' ID="txtRegisNumber" CssClass="form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtRegisNumber"
                                                    runat="server" Display="Dynamic" ValidationGroup="valAssoRegistrations" Font-Size="XX-Small" SetFocusOnError="true" />
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("RegisNumber") %>' ID="txtRegisNumber" CssClass="form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtRegisNumber"
                                                    runat="server" Display="Dynamic" ValidationGroup="valAssoRegistrations" Font-Size="XX-Small" SetFocusOnError="true" />
                                            </EditItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Authority">
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("RegisAuthority") %>' ID="txtRegisAuthority" CssClass="form-control"></asp:TextBox>
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("RegisAuthority") %>' ID="txtRegisAuthority" CssClass="form-control"></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Registration Date">
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("RegisDate","{0:dd MMM yyyy}") %>'
                                                    ID="txtRegisDate" CssClass="form-control date-picker" AutoCompleteType="Disabled"></asp:TextBox>
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("RegisDate","{0:dd MMM yyyy}") %>'
                                                    ID="txtRegisDate" CssClass="form-control date-picker" AutoCompleteType="Disabled"></asp:TextBox>
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

                                        <asp:CommandField ShowInsertButton="true" InsertText="Submit" ValidationGroup="valAssoRegistrations" ButtonType="Button"
                                            ControlStyle-CssClass="btn btn-outline-primary btn-sm" />
                                        <asp:CommandField ShowEditButton="true" EditText="Update" ValidationGroup="valAssoRegistrations" ButtonType="Button"
                                            ControlStyle-CssClass="btn btn-outline-primary btn-sm" />
                                    </Fields>

                                </asp:DetailsView>

                                <asp:SqlDataSource runat="server" ID="sqldvwAssoReg" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                    InsertCommand="AssoRegistrations_Dvw_Ins_AdminG" InsertCommandType="StoredProcedure"
                                    SelectCommand="AssoRegistrations_Dvw_Sel_AdminG" SelectCommandType="StoredProcedure"
                                    UpdateCommand="AssoRegistrations_Dvw_Upd_AdminG" UpdateCommandType="StoredProcedure">
                                    <InsertParameters>
                                        <asp:ControlParameter ControlID="ddlResiCom" Name="ResComId" PropertyName="SelectedValue" Type="Int32" />
                                        <asp:Parameter Name="RegisNumber" Type="String" />
                                        <asp:Parameter Name="RegisAuthority" Type="String" />
                                        <asp:Parameter Name="RegisDate" Type="DateTime" />
                                        <asp:Parameter Name="CrBY" Type="String" />
                                        <asp:Parameter Name="CrDt" Type="DateTime" />
                                        <asp:Parameter Name="CrByIP" Type="String" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="gvwAssoReg" Name="Id" PropertyName="SelectedValue" Type="Int32" />
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="RegisNumber" Type="String" />
                                        <asp:Parameter Name="RegisAuthority" Type="String" />
                                        <asp:Parameter Name="RegisDate" Type="DateTime" />
                                        <asp:Parameter Name="IsDel" Type="Boolean" />
                                        <asp:Parameter Name="ModBy" Type="String" />
                                        <asp:Parameter Name="ModDt" Type="DateTime" />
                                        <asp:Parameter Name="ModByIP" Type="String" />
                                        <asp:Parameter Name="Id" Type="Int32" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                                <asp:GridView ID="gvwAssoReg" runat="server" AutoGenerateColumns="False"
                                    DataKeyNames="Id" OnSelectedIndexChanged="gvwAssoReg_SelectedIndexChanged"
                                    EmptyDataText="There is no data to show." CssClass="table table-bordered table-responsive-sm table-sm table-condensed table-striped"
                                    DataSourceID="sqlgvwAssoReg">
                                    <Columns>
                                        <asp:TemplateField HeaderText="#">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Number">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# Eval("RegisNumber") %>' ID="lblRegisNumber"></asp:Label>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Authority">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# Eval("RegisAuthority") %>' ID="lblRegisAuthority"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date">
                                            <ItemTemplate>
                                                    <asp:Label runat="server" Text='<%# Bind("RegisDate","{0:dd MMM yyyy}") %>' ID="lblRegisDate"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ShowSelectButton="true" SelectText="Select" ControlStyle-CssClass="btn btn-outline-success btn-sm" />
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource runat="server" ID="sqlgvwAssoReg" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                    SelectCommand="AssoRegistrations_Gvw_Sel_AdminG" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="ddlResiCom" Name="ResComId" PropertyName="SelectedValue" Type="Int32" />
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
