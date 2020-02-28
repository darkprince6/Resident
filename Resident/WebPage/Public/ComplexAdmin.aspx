<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ComplexAdmin.aspx.c s" Inherits="Resident.WebPage.Public.ComplexAdmin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet" href="../../ContentProject/Public/ResidentialComplexDetails.css" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="../../ScriptPlugIn/jquery.tooltip.js"></script>
    <script src="../../ScriptsProject/Public/ComplexPublic.js"></script>
    <style>
        .bg-transparent{
            background-color: transparent;
            cursor:pointer;
        }
    </style>
</head>
<body style="background: linear-gradient(to right, #ffefba, #ffffff)">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

            <div class="container" style="margin-top: 10px">
                <div class="row">
                    <div class="col-sm-2"></div>
                    <div class="col-sm-8">
                        <div class="card bg-light text-dark">
                            <div class="card-body">
                                <asp:Repeater runat="server" ID="repComplex" DataSourceID="sqlComplex">
                                    <ItemTemplate>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <asp:Image ID="imgLogo" runat="server" ImageUrl='<%# Eval("Logo") %>' CssClass="rounded img-fluid img-large pointer-cursor" />
                                                <%--tooltip Image--%>
                                                <div id="tooltip" style="display: none;">
                                                    <table style="margin: auto">
                                                        <tr>
                                                            <td>
                                                                <asp:Image ID="imgLarge" Width="250px" Height="150px" ImageUrl='<%#Eval("Logo") %>' runat="server" CssClass="img-thumbnail" /></td>
                                                        </tr>
                                                    </table>

                                                </div>

                                            </div>
                                            <div class="col-sm-8">
                                                <h4>
                                                    <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                                    <span class="fa fa-building-o" style="color: gray"></span>
                                                    <asp:HiddenField ID="hdnId" runat="server" Value='<%# Eval("Id") %>' />
                                                    <span runat="server" visible='<%#(Eval("Abbr")).ToString()!=""? true:false %>' style="font-size: 20px">
                                                        <%# " (" + Eval("Abbr") + ")" %>
                                                    </span>
                                                </h4>
                                                <h6>
                                                    <asp:Label ID="lblCat" runat="server" Text='<%# Eval("Cat") %>'></asp:Label>

                                                </h6>
                                                <h6>
                                                    <asp:Label ID="lblFoundedYr" runat="server" Text='<%# Eval("FoundedYr") %>'></asp:Label>

                                                </h6>
                                            </div>
                                        </div>


                                        <div class="row">
                                            <div class="col-sm-6">
                                                <h4>
                                                    <asp:Label runat="server" ForeColor="Navy" Text="Address"></asp:Label>
                                                    <span class="fa fa-address-card-o" style="color: navy" aria-hidden="true"></span>

                                                </h4>
                                                <h6 style="margin: auto" runat="server" visible='<%#(Eval("RCAAddress1")).ToString()!=""? true:false %>'>Address:-
                                                    <%# Eval("RCAAddress1") %>
                                                    <span visible='<%#(Eval("RCAAddress2")).ToString()!=""? true:false %>'>
                                                        <%# ", " +Eval("RCAAddress2") %>
                                                    </span>
                                                </h6>

                                                <h6 style="margin: auto" runat="server" visible='<%#(Eval("Landmark")).ToString()!=""? true:false %>'>
                                                    <%# Eval("Landmark") %>
                                                </h6>
                                                <h6 style="margin: auto" runat="server" visible='<%#(Eval("Country")).ToString()!=""? true:false %>' class="text-dark">
                                                    <span runat="server" visible='<%#(Eval("District")).ToString()!=""? true:false %>'>
                                                        <%# Eval("District") %> , 
                                                    </span>
                                                    <span runat="server" visible='<%#(Eval("State1")).ToString()!=""? true:false %>'>
                                                        <%# Eval("State1") %> ,
                                                    </span>
                                                    <span runat="server" visible='<%#(Eval("Country")).ToString()!=""? true:false %>'>
                                                        <%# Eval("Country") %>
                                                    </span>
                                                </h6>
                                                <h6 style="margin-bottom: 10px" runat="server" visible='<%#(Eval("RCAPinCode")).ToString()!=""? true:false %>'>Postal Code:-
                                                    <%# Eval("RCAPinCode") %>
                                                </h6>
                                            </div>

                                            <div class="col-sm-6">
                                                <h4>
                                                    <asp:Label ID="lblPS" runat="server" Text='<%# Eval("PoliceStation") %>' ForeColor="Navy"></asp:Label>
                                                    <span class="fa fa-shield" style="color: navy" runat="server" visible='<%#(Eval("PoliceStation")).ToString()!=""? true:false %>'></span>

                                                </h4>
                                                <h6 style="margin: auto" runat="server" visible='<%#(Eval("Address1")).ToString()!=""? true:false %>'>Address:-
                                                    <%# Eval("Address1") %>
                                                    <span visible='<%#(Eval("Address2")).ToString()!=""? true:false %>'>
                                                        <%# ", " +Eval("Address2") %>
                                                    </span>
                                                </h6>
                                                <h6 style="margin-bottom: 10px" runat="server" visible='<%#(Eval("PinCode")).ToString()!=""? true:false %>'>PIN:-
                                                    <%# Eval("PinCode") %>
                                                </h6>
                                                <h6 style="margin: auto" runat="server" visible='<%#(Eval("Phone1")).ToString()!=""? true:false %>'>
                                                    <i class="fa fa-phone text-success" aria-hidden="true"></i>
                                                    <%# Eval("Phone1") %>
                                                    <span visible='<%#(Eval("Phone2")).ToString()!=""? true:false %>'>
                                                        <%# " / " +Eval("Phone2") %>
                                                    </span>
                                                </h6>
                                                <h6 style="margin: auto" runat="server" visible='<%#(Eval("Email")).ToString()!=""? true:false %>'>
                                                    <i class="fa fa-envelope text-info" aria-hidden="true"></i>
                                                    <a href='<%# "mailto:"+ Eval("Email") %>' runat="server"><%# Eval("Email") %></a>

                                                </h6>
                                                <h6 style="margin: auto" runat="server" visible='<%#(Eval("Website")).ToString()!=""? true:false %>'>
                                                    <i class="fa fa-globe text-muted" aria-hidden="true"></i>
                                                    <a href='<%# "http://www." + Eval("Website") %>' runat="server" target="_blank"><%# "www." + Eval("Website") %></a>

                                                </h6>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>

                                <asp:SqlDataSource runat="server" ID="sqlComplex" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                    SelectCommand="SELECT 
                                                    RC.Id AS Id, RC.Name, RC.NameAlt, RC.Abbr, RC.Founded, RC.FoundedYr, RC.YearOrSem, 
                                                    RC.Logo, RC.CoverImg, RCC.Cat,
                                                    PS.PoliceStation, PS.Address1, PS.Address2, PS.PinCode, PS.Phone1, PS.Phone2, PS.Email, PS.Website,
                                                    RCA.Address1 AS RCAAddress1, RCA.Address2 AS RCAAddress2,
                                                    RCA.PinCode AS RCAPinCode, RCA.Landmark, C.Name AS Country, S.Name AS State1,D.Name AS District 
                                               FROM 
                                                    ResidentialComplex AS RC 
                                               INNER JOIN 
                                                    ResComCat AS RCC ON RC.ResComCatId = RCC.Id
                                               LEFT JOIN
													ResComPS AS PS ON PS.ResComId=RC.Id
                                               LEFT JOIN
													ResComAddress RCA ON RCA.ResComId=RC.Id
											   LEFT JOIN
													Democracy.dbo.Countries C ON C.Id=RC.CountryId
											  LEFT JOIN
													Democracy.dbo.States S ON S.Id=RC.StateId
											  LEFT JOIN
													Democracy.dbo.Districts D ON D.Id=RC.DistrictId
                                               WHERE 
                                                    (RC.Id = @Id) AND (RC.IsDel = 0)">
                                    <SelectParameters>
                                        <asp:QueryStringParameter QueryStringField="Id" Name="Id"></asp:QueryStringParameter>
                                    </SelectParameters>
                                </asp:SqlDataSource>

                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2"></div>
                </div>

                <div class="row">
                    <div class="col-sm-2"></div>
                    <div class="col-sm-8" style="margin-top: 10px">
                        <div class="card">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <div id="divNoLog" runat="server" visible="true">
                                        <div class="jumbotron m-0">
                                            <h1></h1>
                                            <h3 class="text-muted text-center">You need to be logged in!
                                            </h3>
                                        </div>

                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>

                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <div id="divButton" runat="server" visible="false">
                                        <ul class="nav nav-tabs" role="tablist">
                                            <li class="nav-item">
                                                <asp:Button CssClass="nav-link bg-transparent" runat="server" Text="Association" ID="btnAsso" OnClick="btnAsso_Click" />
                                            </li>
                                            <li class="nav-item">
                                                <asp:Button CssClass="nav-link bg-transparent" runat="server" Text="Posts" ID="btnPosts" OnClick="btnPosts_Click" />
                                            </li>
                                            <li class="nav-item">
                                                <asp:Button CssClass="nav-link bg-transparent" runat="server" Text="Office Berer" ID="btnOB" OnClick="btnOB_Click" />

                                            </li>
                                        </ul>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>

                            <div class="tab-content">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <div id="divAsso" runat="server" visible="false">
                                            <asp:DetailsView ID="dvwComAsso" runat="server" AutoGenerateRows="False" DefaultMode="Insert" DataKeyNames="Id"
                                                CssClass="table table-bordered table-condensed table-responsive-sm table-sm"
                                                OnItemInserting="dvwComAsso_ItemInserting" HeaderText="Enter Complex Associations details" HeaderStyle-ForeColor="#032e3a" HeaderStyle-BackColor="#d9edf7"
                                                OnItemInserted="dvwComAsso_ItemInserted" OnItemUpdating="dvwComAsso_ItemUpdating" OnItemUpdated="dvwComAsso_ItemUpdated" OnItemCommand="dvwComAsso_ItemCommand"
                                                DataSourceID="sqldvwComAsso">
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

                                            <asp:SqlDataSource runat="server" ID="sqldvwComAsso" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                InsertCommand="ResidentsAssociations_Dvw_Ins_AdminG" InsertCommandType="StoredProcedure"
                                                SelectCommand="ResidentsAssociations_Dvw_Sel_AdminG" SelectCommandType="StoredProcedure"
                                                UpdateCommand="ResidentsAssociations_Dvw_Upd_AdminG" UpdateCommandType="StoredProcedure">
                                                <InsertParameters>
                                                    <asp:Parameter Name="Name" Type="String" />
                                                    <asp:Parameter Name="NameAlt" Type="String" />
                                                    <asp:Parameter Name="Abbr" Type="String" />
                                                    <asp:QueryStringParameter QueryStringField="Id" Name="ResComId" Type="Int32" />
                                                    <asp:Parameter Name="StartDt" Type="DateTime" />
                                                    <asp:Parameter Name="StartYr" Type="Int32" />
                                                    <asp:Parameter Name="Logo" Type="String" />
                                                    <asp:Parameter Name="Image1" Type="String" />
                                                    <asp:Parameter Name="CrBY" Type="String" />
                                                    <asp:Parameter Name="CrDt" Type="DateTime" />
                                                    <asp:Parameter Name="CrByIP" Type="String" />
                                                </InsertParameters>
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="gvwComAsso" Name="Id" PropertyName="SelectedValue" Type="Int32" />
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

                                            <asp:GridView ID="gvwComAsso" runat="server" AutoGenerateColumns="False"
                                                DataKeyNames="Id" OnSelectedIndexChanged="gvwComAsso_SelectedIndexChanged"
                                                EmptyDataText="There is no data to show." CssClass="table table-bordered table-responsive-sm table-sm table-condensed table-striped"
                                                DataSourceID="sqlgvwComAsso">
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

                                            <asp:SqlDataSource runat="server" ID="sqlgvwComAsso" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                SelectCommand="ResidentsAssociations_Gvw_Sel_AdminG" SelectCommandType="StoredProcedure">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter QueryStringField="Id" Name="ResComId"></asp:QueryStringParameter>


                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </div>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:PostBackTrigger ControlID="dvwComAsso" />
                                    </Triggers>
                                </asp:UpdatePanel>

                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <div id="divPost" runat="server" visible="false">
                                            <asp:DropDownList ID="ddlAsso" runat="server" CssClass="form-control mb-1" DataSourceID="sqlddlAsso" DataTextField="Name"
                                                DataValueField="Id" OnDataBound="ddlAsso_DataBound" AutoPostBack="true" OnSelectedIndexChanged="ddlAsso_SelectedIndexChanged">
                                            </asp:DropDownList>

                                            <asp:SqlDataSource runat="server" ID="sqlddlAsso" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                SelectCommand="SELECT Id, Name FROM ResidentsAssociations WHERE (ResComId = @ResComId)">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter QueryStringField="Id" Name="ResComId"></asp:QueryStringParameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>

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
                                                    <asp:ControlParameter ControlID="ddlAsso" Name="AssoId" PropertyName="SelectedValue" Type="Int32" />
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
                                                    <asp:ControlParameter ControlID="ddlAsso" Name="AssoId" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>

                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <div id="divAssoOB" runat="server" visible="false">

                                            <asp:DropDownList ID="ddlAsso2" runat="server" CssClass="form-control mb-1" DataSourceID="sqlddlAsso2" DataTextField="Name" Visible="false"
                                                DataValueField="Id" OnDataBound="ddlAsso2_DataBound" AutoPostBack="true" OnSelectedIndexChanged="ddlAsso2_SelectedIndexChanged">
                                            </asp:DropDownList>

                                            <asp:SqlDataSource runat="server" ID="sqlddlAsso2" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                SelectCommand="SELECT Id, Name FROM ResidentsAssociations WHERE (ResComId = @ResComId)">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter QueryStringField="Id" Name="ResComId"></asp:QueryStringParameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                            <asp:DropDownList ID="ddlPost" runat="server" CssClass="form-control mb-1" DataTextField="PName" DataSourceID="sqlddlPost" Visible="false"
                                                DataValueField="Id" OnDataBound="ddlPost_DataBound" AutoPostBack="true" OnSelectedIndexChanged="ddlPost_SelectedIndexChanged">
                                            </asp:DropDownList>


                                            <asp:SqlDataSource runat="server" ID="sqlddlPost" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                SelectCommand="SELECT [Id], [PName] FROM [AssoPosts] WHERE ([AssoId] = @AssoId)">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlAsso2" PropertyName="SelectedValue" Name="AssoId" Type="Int32"></asp:ControlParameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>


                                            <asp:DetailsView ID="dvwAssoOB" runat="server" AutoGenerateRows="False" DefaultMode="Insert" DataKeyNames="Id"
                                                CssClass="table table-bordered table-condensed table-responsive-sm table-sm" Visible="false"
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
                                                    <asp:ControlParameter ControlID="ddlPost" Name="AssoPostId" PropertyName="SelectedValue" Type="Int32" />
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


                                            <asp:GridView ID="gvwAssoOB" runat="server" AutoGenerateColumns="False" Visible="false"
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
                                                    <asp:ControlParameter ControlID="ddlPost" Name="AssoPostId" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                        </div>
                                    </ContentTemplate>
                                     <Triggers>
                                        <asp:PostBackTrigger ControlID="dvwAssoOB" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </form>
</body>
</html>
