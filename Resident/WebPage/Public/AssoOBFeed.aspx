<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssoOBFeed.aspx.cs" Inherits="Resident.WebPage.Public.AssoOBFeed" %>

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
<body style="background: linear-gradient(to right, #ffefba, #ffffff)">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="SM1" runat="server"></asp:ScriptManager>
        <div class="container" style="margin-top: 10px">
            <div class="row">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <div class="card bg-light text-dark">
                        <div class="card-body">
                            <%-- <asp:Repeater runat="server" ID="repResidentialComplex" DataSourceID="sqlRepResidentialComplex"
                                OnItemDataBound="repResidentialComplex_ItemDataBound">
                                <ItemTemplate>
                                    <div class="row">
                                        <div class="col-sm-4">
                                            <asp:Image ID="imgLogo" runat="server" ImageUrl='<%# Eval("Logo") %>' CssClass="rounded img-fluid img-large pointer-cursor" />
                                            
                                            <div id="tooltip" style="display: none;">
                                                <table style="margin: auto">
                                                    <tr>

                                                        <td>
                                                            <asp:Image ID="imgLarge" Width="250px" Height="150px" ImageUrl='<%#Eval("Logo") %>' runat="server" CssClass="img-thumbnail" /></td>
                                                    </tr>
                                                </table>

                                            </div>

                                        </div>
                                        <div class="col-sm-4">
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
                                        <div class="col-sm-4">
                                            <h4>
                                                <asp:Label ID="lblPS" runat="server" Text='<%# Eval("PoliceStation") %>' ForeColor="Navy"></asp:Label>
                                                <span class="fa fa-shield" style="color: navy" runat="server" visible='<%#(Eval("PoliceStation")).ToString()!=""? true:false %>'></span>

                                            </h4>
                                            <h6 runat="server" visible='<%#(Eval("Address1")).ToString()!=""? true:false %>'>Address:-
                                                    <%# Eval("Address1") %>
                                                <span visible='<%#(Eval("Address2")).ToString()!=""? true:false %>'>
                                                    <%# ", " +Eval("Address2") %>
                                                </span>
                                            </h6>
                                            <h6 runat="server" visible='<%#(Eval("PinCode")).ToString()!=""? true:false %>'>PIN:-
                                                    <%# Eval("PinCode") %>
                                            </h6>
                                            <h6 runat="server" visible='<%#(Eval("Phone1")).ToString()!=""? true:false %>'>Phone:-
                                                     <%# Eval("Phone1") %>
                                                <span visible='<%#(Eval("Phone2")).ToString()!=""? true:false %>'>
                                                    <%# " / " +Eval("Phone2") %>
                                                </span>
                                            </h6>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>

                            <asp:SqlDataSource runat="server" ID="sqlRepResidentialComplex" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                SelectCommand="SELECT 
                                                    RC.Id AS Id, RC.Name, RC.NameAlt, RC.Abbr, RC.Founded, RC.FoundedYr, RC.YearOrSem, 
                                                    RC.Logo, RC.CoverImg, RCC.Cat,
                                                    RCP.PoliceStation, RCP.Address1, RCP.Address2, RCP.PinCode, RCP.Phone1, RCP.Phone2
                                               FROM 
                                                    ResidentialComplex AS RC 
                                               INNER JOIN 
                                                    ResComCat AS RCC ON RC.ResComCatId = RCC.Id
                                               LEFT JOIN
													ResComPS AS RCP ON RCP.ResComId=RC.Id
                                               WHERE 
                                                    (RC.Id = @Id) AND (RC.IsDel = 0)">
                                <SelectParameters>
                                    <asp:RouteParameter RouteKey="Id" Name="Id"></asp:RouteParameter>
                                </SelectParameters>
                            </asp:SqlDataSource>--%>
                            AssoOBFeed
                            <asp:HyperLink ID="hplDemo" runat="server" Text="Demo"></asp:HyperLink>

                        </div>
                    </div>
                </div>
                <div class="col-sm-2"></div>
            </div>
        </div>
    </form>
</body>
</html>
