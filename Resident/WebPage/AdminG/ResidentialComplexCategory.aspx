<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResidentialComplexCategory.aspx.cs" Inherits="Resident.WebPage.AdminG.ResidentialComplexCategory" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <script src="../../ScriptsProject/ResidentialComplexCategory.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div style="background-color: #d7ccc8; text-align: center; margin-bottom: 5px; margin-top: 4px; font-weight: 600">
                        <asp:Label runat="server" ID="lblHead" Font-Size="19px">
                    Here you can add Residential Complex Category Details :
                        </asp:Label>
                    </div>
                </div>
            </div>

            <div class="row text-left">
                <div class="col-md-2"></div>
                <div class="col-md-8">
                    <div id="divNoLog" runat="server" visible="true">
                        <div class="alert alert-danger">
                            <i class="fa fa-close"></i>
                            <asp:Label runat="server" ID="lblNoLog" Font-Size="18px" ForeColor="Crimson"></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="col-md-2"></div>
            </div>

            <div class="row">
                <div class="col-sm-2">
                </div>
                <div class="col-sm-8">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div id="divResComCat" runat="server" visible="false">
                                <asp:DetailsView ID="dvwResComCat" runat="server" AutoGenerateRows="False" DefaultMode="Insert" DataKeyNames="Id"
                                    CssClass="table table-bordered table-condensed table-responsive-sm table-sm"
                                    OnItemInserting="dvwResComCat_ItemInserting" HeaderText="Enter Residential Complex Category details" HeaderStyle-ForeColor="#032e3a" HeaderStyle-BackColor="#d9edf7"
                                    OnItemInserted="dvwResComCat_ItemInserted" OnItemUpdating="dvwResComCat_ItemUpdating" OnItemUpdated="dvwResComCat_ItemUpdated"
                                    DataSourceID="sqldvwResComCat">
                                    <EditRowStyle HorizontalAlign="Left" />
                                    <Fields>
                                        <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id"></asp:BoundField>
                                        <asp:TemplateField HeaderText="Category Name">
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("Cat") %>' ID="txtCat" CssClass="form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtCat"
                                                    runat="server" Display="Dynamic" ValidationGroup="valResComCat" Font-Size="XX-Small" />
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("Cat") %>' ID="txtCat" CssClass="form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtCat"
                                                    runat="server" Display="Dynamic" ValidationGroup="valResComCat" Font-Size="XX-Small" />
                                            </EditItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Priority">
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("Priority") %>' ID="txtPriority" MaxLength="2"
                                                    CssClass="form-control input-number" AutoCompleteType="Disabled"></asp:TextBox>
                                                <span class="errmsg" style="color: crimson; font-size: xx-small"></span>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtPriority"
                                                    runat="server" Display="Dynamic" ValidationGroup="valResComCat" Font-Size="XX-Small" />
                                                <asp:RegularExpressionValidator ID="revaltxtPriority" ValidationExpression="^\d+$" ValidationGroup="valResComCat"
                                                    ControlToValidate="txtPriority" runat="server" ForeColor="Red" ErrorMessage="*Enter Only Numbers." Font-Size="XX-Small"
                                                    Display="Dynamic" />
                                            </InsertItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("Priority") %>' ID="txtPriority" MaxLength="2"
                                                    CssClass="form-control input-number" AutoCompleteType="Disabled"></asp:TextBox>
                                                <span class="errmsg" style="color: crimson; font-size: xx-small"></span>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtPriority"
                                                    runat="server" Display="Dynamic" ValidationGroup="valResComCat" Font-Size="XX-Small" />
                                                <asp:RegularExpressionValidator ID="revaltxtPriority" ValidationExpression="^\d+$" ValidationGroup="valResComCat"
                                                    ControlToValidate="txtPriority" runat="server" ForeColor="Red" ErrorMessage="*Enter Only Numbers." Font-Size="XX-Small"
                                                    Display="Dynamic" />
                                            </EditItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Description">
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("Descr") %>' ID="txtDescr" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                            </InsertItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" Text='<%# Bind("Descr") %>' ID="txtDescr" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
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
                                        <asp:CommandField ShowInsertButton="true" InsertText="Submit" ValidationGroup="valResComCat" ButtonType="Button"
                                            ControlStyle-CssClass="btn btn-outline-primary btn-sm" />
                                        <asp:CommandField ShowEditButton="true" EditText="Update" ValidationGroup="valResComCat" ButtonType="Button"
                                            ControlStyle-CssClass="btn btn-outline-primary btn-sm" />

                                    </Fields>
                                </asp:DetailsView>

                                <asp:SqlDataSource runat="server" ID="sqldvwResComCat" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                    InsertCommand="ResComCat_Dvw_Ins_AdminG" InsertCommandType="StoredProcedure"
                                    SelectCommand="ResComCat_Dvw_Sel_AdminG" SelectCommandType="StoredProcedure"
                                    UpdateCommand="ResComCat_Dvw_Upd_AdminG" UpdateCommandType="StoredProcedure">
                                    <InsertParameters>
                                        <asp:Parameter Name="CountryId" Type="Int32" DefaultValue="1" />
                                        <asp:Parameter Name="Cat" Type="String" />
                                        <asp:Parameter Name="Descr" Type="String" />
                                        <asp:Parameter Name="Priority" Type="Int32" DefaultValue="1" />
                                        <asp:Parameter Name="CrBY" Type="String" />
                                        <asp:Parameter Name="CrDt" Type="DateTime" />
                                        <asp:Parameter Name="CrByIP" Type="String" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="gvwResComCat" Name="Id" PropertyName="SelectedValue" Type="Int32" />
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="Cat" Type="String" />
                                        <asp:Parameter Name="Descr" Type="String" />
                                        <asp:Parameter Name="Priority" Type="Int32" DefaultValue="1" />
                                        <asp:Parameter Name="IsDel" Type="Boolean" />
                                        <asp:Parameter Name="ModBy" Type="String" />
                                        <asp:Parameter Name="ModDt" Type="DateTime" />
                                        <asp:Parameter Name="ModByIP" Type="String" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>


                                <asp:GridView ID="gvwResComCat" runat="server" AutoGenerateColumns="False"
                                    DataKeyNames="Id" OnSelectedIndexChanged="gvwResComCat_SelectedIndexChanged"
                                    EmptyDataText="There is no data to show." CssClass="table table-bordered table-responsive-sm table-sm table-condensed table-striped"
                                    DataSourceID="sqlgvwResComCat">
                                    <Columns>
                                        <asp:TemplateField HeaderText="#">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Category">

                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# Eval("Cat") %>' ID="lblCat"></asp:Label>
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

                                <asp:SqlDataSource runat="server" ID="sqlgvwResComCat" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                    SelectCommand="ResComCat_Gvw_Sel_AdminG" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

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
