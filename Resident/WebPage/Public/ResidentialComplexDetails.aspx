<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResidentialComplexDetails.aspx.cs" Inherits="Resident.WebPage.Public.ResidentialComplexDetails" EnableEventValidation="false" %>

<%--<%@ OutputCache Duration="3600" VaryByParam="None" Location="ServerAndClient" VaryByCustom="Browser" NoStore="true"  %>--%>
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
    <script src="../../ScriptsProject/Public/ResidentialComplexDetails.js"></script>
</head>
<body style="background: linear-gradient(to right, #ffefba, #ffffff)">
    <form id="form1" runat="server">

        <asp:ScriptManager ID="SM1" runat="server"></asp:ScriptManager>

        <asp:Label ID="catchLabel" runat="server">

        </asp:Label>
        <br />
        <script>
            document.write("Client Time-: ", Date());
        </script>
        <div class="container" style="margin-top: 10px">
            <div class="row">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <div class="card bg-light text-dark">
                        <div class="card-body">
                            <asp:Repeater runat="server" ID="repResidentialComplex" DataSourceID="sqlRepResidentialComplex"
                                OnItemDataBound="repResidentialComplex_ItemDataBound">
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

                            <asp:SqlDataSource runat="server" ID="sqlRepResidentialComplex" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
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
                                    <asp:RouteParameter RouteKey="Id" Name="Id"></asp:RouteParameter>
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
                    <div class="card" style="background-image: linear-gradient(to right, #c9d6ff, #e2e2e2);">
                        <ul class="nav nav-tabs" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" data-toggle="tab" href="#divResidentsAssociations">Residents Associations</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" data-toggle="tab" href="#menu1">Menu 1</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" data-toggle="tab" href="#menu2">Menu 2</a>
                            </li>
                        </ul>

                        <!-- Tab panes -->
                        <div class="tab-content">
                            <div id="divResidentsAssociations" class="container tab-pane active">
                                <h3>Residents Associations</h3>
                                <asp:UpdatePanel runat="server" ID="upResidentsAssociations">
                                    <ContentTemplate>
                                        <asp:Repeater runat="server" ID="repResAsso"  OnItemDataBound="repResAsso_ItemDataBound" OnPreRender="repResAsso_PreRender">
                                            <ItemTemplate>
                                                <%-- <div id="divResAsso" style="cursor: pointer" onclick="document.getElementById('btnPosts').click()">--%>
                                                <div class="card bg-light text-dark card-hover"
                                                    style="background-image: linear-gradient(to right, #ece9e6, #ffffff); margin-bottom: 4px;">
                                                    <div class="card-body">
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <asp:Image ID="imgLogo" runat="server" ImageUrl='<%# Eval("Logo") %>' CssClass="img-fluid img-large pointer-cursor" />
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
                                                            <div class="col-sm-10">
                                                                <h4>
                                                                    <asp:HiddenField ID="hdnId2" runat="server" Value='<%# Eval("Id") %>' />

                                                                    <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                                                    <span runat="server" visible='<%#(Eval("Abbr")).ToString()!=""? true:false %>' style="font-size: 20px">
                                                                        <%# " (" + Eval("Abbr") + ")" %>
                                                                    </span>
                                                                    <div runat="server" visible='<%#(Eval("NameAlt")).ToString()!=""? true:false %>' style="font-size: 18px">
                                                                        <%# " (" + Eval("NameAlt") + ")" %>
                                                                    </div>
                                                                </h4>
                                                                <h6 runat="server" visible='<%#(Eval("StartDt")).ToString()!=""? true:false %>'>
                                                                    <asp:Label ID="lblStateDt" runat="server" Text='<%# Eval("StartDt","{0:dd MMM yyyy}") %>'></asp:Label>

                                                                </h6>
                                                                <h6>
                                                                    <asp:Label ID="lblStartYr" runat="server" Text='<%# Eval("StartYr") %>'></asp:Label>
                                                                    <asp:Button ID="btnPosts" runat="server" Text="Show" OnClick="btnPosts_Click" ClientIDMode="Static"
                                                                        CssClass="btn btn-outline-success btn-sm pull-right" />
                                                                </h6>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <%--</div>--%>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        <asp:HiddenField ID="hdnResComId" runat="server" />
                                        <asp:HiddenField ID="hdnAssoId" runat="server" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>


                                <asp:SqlDataSource runat="server" ID="SqlRepResAsso" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                    SelectCommand="SELECT 
                                                    Id, Name, NameAlt, Abbr, StartDt, StartYr, Logo, Image1 
                                               FROM 
                                                    ResidentsAssociations 
                                               WHERE 
                                                    (ResComId = @ResComId) AND (IsDel = 0)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hdnResComId" PropertyName="Value" Name="ResComId"></asp:ControlParameter>
                                    </SelectParameters>
                                </asp:SqlDataSource>

                                <div id="divRepPosts">
                                    <ul class="list-group">
                                        <asp:UpdatePanel runat="server" ID="upRepPosts">
                                            <ContentTemplate>
                                                <asp:Repeater ID="repPosts" runat="server" DataSourceID="sqlRepPosts">
                                                    <ItemTemplate>
                                                        <li class="list-group-item  list-group-item-light">

                                                            <%# Eval("PName") %>
                                                            <span runat="server" visible='<%#(Eval("Abbr")).ToString()!=""? true:false %>'>
                                                                <%# " (" + Eval("Abbr") + ")" %>
                                                            </span>
                                                            <span class="badge badge-secondary badge-pill pull-right">
                                                                <%# Eval("Numbers") %>

                                                            </span>
                                                        </li>

                                                    </ItemTemplate>

                                                    <FooterTemplate>
                                                        <li class="list-group-item  list-group-item-light" runat="server" visible='<%# bool.Parse((repPosts.Items.Count == 0).ToString()) %>'>No Record Found!
                                                           
                                                        </li>
                                                    </FooterTemplate>
                                                </asp:Repeater>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </ul>
                                    <asp:SqlDataSource ID="sqlRepPosts" runat="server" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                        SelectCommand="SELECT 
                                                             Id, PName, PnameAlt, Abbr, Numbers
                                                       FROM
                                                             AssoPosts
                                                       WHERE
                                                             IsDel=0 AND AssoId=@AssoId
                                                       ORDER BY
                                                             Numbers DESC">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="hdnAssoId" PropertyName="Value" Name="AssoId" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>

                                <asp:UpdatePanel runat="server" ID="upAssoOB">
                                    <ContentTemplate>
                                        <div id="divAssoOB" style="margin-top: 5px" runat="server" visible="false">
                                            <div class="card" style="margin-bottom: 5px">
                                                <div class="card-header text-white bg-dark">
                                                    Associate Office Bearer
                                                </div>
                                                <div class="card-body" style="padding: 1px">
                                                    <div class="row" style="padding-left: 15px; padding-right: 15px">
                                                        <asp:Repeater ID="RepAssoOB" runat="server" DataSourceID="sqlRepAssoOB" OnItemDataBound="RepAssoOB_ItemDataBound">

                                                            <ItemTemplate>
                                                                <%--<div class="card-columns">--%>
                                                                <div class="col-sm-6 col-md-4 col-xl-4" style="padding: 1px">

                                                                    <div class="card h-100 card-hover" style="margin-bottom: 0px; box-shadow: none">
                                                                        <asp:Image ID="img" runat="server" ImageUrl='<%# Eval("Image1") %>' Height="130px" CssClass="img-fluid img-large pointer-cursor" />
                                                                        <%--tooltip Image--%>
                                                                        <div id="tooltip" style="display: none;">
                                                                            <table style="margin: auto">
                                                                                <tr>

                                                                                    <td>
                                                                                        <asp:Image ID="imgLarge" Width="250px" Height="150px" ImageUrl='<%#Eval("Image1") %>' runat="server" CssClass="img-thumbnail" /></td>
                                                                                </tr>
                                                                            </table>

                                                                        </div>

                                                                        <div class="card-body" style="padding: 10px">
                                                                            <h6 class="card-title text-primary">
                                                                                <%# Eval("Name") %>
                                                                            </h6>

                                                                            <p class="card-text" style="font-size: small; margin-bottom: 0px">
                                                                                <div class="badge badge-pill badge-secondary">
                                                                                    <%# Eval("PName") %>
                                                                                </div>
                                                                                <div runat="server" style="font-size: small">
                                                                                    <span runat="server" visible='<%#(Eval("DateFrom")).ToString()!=""? true:false %>'>
                                                                                        <%# Eval("DateFrom","{0:dd MMM yyyy}") %>
                                                                                    </span>
                                                                                    <span runat="server" visible='<%#(Eval("DateTo")).ToString()!=""? true:false %>'>
                                                                                        <%# " - " + Eval("DateTo","{0:dd MMM yyyy}") %>
                                                                                    </span>
                                                                                </div>
                                                                                <div runat="server" visible='<%#(Eval("YearFrom")).ToString()!=""? true:false %>' style="font-size: small">
                                                                                    <span class="text-info">
                                                                                        <b>Year: </b>
                                                                                    </span>
                                                                                    <span runat="server" visible='<%#(Eval("YearFrom")).ToString()!=""? true:false %>'>
                                                                                        <%# Eval("YearFrom") %>
                                                                                    </span>
                                                                                    <span runat="server" visible='<%#(Eval("YearTo")).ToString()!=""? true:false %>'>
                                                                                        <%# " - " + Eval("YearTo") %>
                                                                                    </span>
                                                                                </div>
                                                                                <div runat="server" visible='<%#(Eval("DoB")).ToString()!=""? true:false %>' style="font-size: small">
                                                                                    <span class="text-info">
                                                                                        <b>Date of Birth: </b>
                                                                                    </span>
                                                                                    <span runat="server" visible='<%#(Eval("DoB")).ToString()!=""? true:false %>'>
                                                                                        <%# Eval("DoB","{0:dd MMM yyyy}") %>
                                                                                    </span>
                                                                                </div>
                                                                                <div runat="server" visible='<%#(Eval("Age")).ToString()!=""? true:false %>' style="font-size: small">
                                                                                    <span class="text-info">
                                                                                        <b>Age: </b>
                                                                                    </span>
                                                                                    <span runat="server" visible='<%#(Eval("Age")).ToString()!=""? true:false %>'>
                                                                                        <%# Eval("Age") %>
                                                                                    </span>
                                                                                </div>
                                                                            </p>
                                                                            <asp:HyperLink ID="hlOBProfile" runat="server" Target="_blank" Text="See Profile" class="btn btn-outline-primary btn-sm"
                                                                                NavigateUrl='<%# GetRouteUrl("AssoOBFeedRoute",
                                                                                                                                  new System.Web.Routing.RouteValueDictionary
                                                                                                                              {
                                                                                                                                {"ComplexName", Eval("Name").ToString().Replace(" ", "-") },
                                                                                                                                {"Name", Eval("Name").ToString().Replace(" ", "-") },
                                                                                                                                {"Id" , Eval("Id") }
                                                                                                                              }) %>'>
                                                                            </asp:HyperLink>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                <ul class="list-group" runat="server" visible='<%# bool.Parse((RepAssoOB.Items.Count == 0).ToString()) %>'>
                                                                    <li class="list-group-item  list-group-item-light border-0">No Record Found!
                                                                    </li>
                                                                </ul>
                                                            </FooterTemplate>
                                                        </asp:Repeater>
                                                    </div>
                                                </div>
                                            </div>

                                            <asp:SqlDataSource ID="sqlRepAssoOB" runat="server" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                SelectCommand="SELECT 
                                                        OB.Id, OB.Name, OB.DateFrom, OB.DateTo, OB.YearFrom, OB.YearTo, OB.DoB, OB.Age, OB.Image1, P.PName
                                                   FROM
                                                         AssoOfficeBearers OB
                                                   INNER JOIN AssoPosts P ON P.Id=OB.AssoPostId
                                                   WHERE
                                                        OB.IsDel=0 AND OB.AssoId=@AssoId">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="hdnAssoId" Name="AssoId" PropertyName="Value" />
                                                </SelectParameters>

                                            </asp:SqlDataSource>

                                        </div>

                                    </ContentTemplate>
                                </asp:UpdatePanel>

                                <asp:UpdatePanel runat="server" ID="upAssoSession">
                                    <ContentTemplate>
                                        <div id="divAssoSession" style="margin-top: 5px" runat="server" visible="false">
                                            <div class="card" style="margin-bottom: 1px">
                                                <div class="card-header text-white bg-dark">
                                                    Associate Session
                                                </div>
                                                <div class="card-body" style="padding: 1px">
                                                    <asp:Repeater ID="RepAssoSessions" runat="server" DataSourceID="sqlRepAssoSession" OnItemDataBound="RepAssoSessions_ItemDataBound" OnPreRender="RepAssoSessions_PreRender">
                                                        <ItemTemplate>
                                                            <div class="col-sm-12" style="padding: 1px">
                                                                <div class="card card-hover-two" style="margin-bottom: 0px; box-shadow: none">
                                                                    <div class="card-body" style="padding: 10px">
                                                                        <asp:HiddenField ID="hdnId3" runat="server" Value='<%# Eval("Id") %>' />
                                                                        <h6 class="card-title text-primary">Session No <span runat="server">
                                                                            <%# Container.ItemIndex+1 %>
                                                                        </span>: <%# Eval("SessionNumber") %> 
                                                                        </h6>
                                                                        <p class="card-text">
                                                                            <div runat="server" visible='<%#(Eval("DateConstituted")).ToString()!=""? true:false %>' style="font-size: small">
                                                                                <span class="text-info">
                                                                                    <b>Date: </b>
                                                                                </span>
                                                                                <span runat="server" visible='<%#(Eval("DateConstituted")).ToString()!=""? true:false %>'>
                                                                                    <%# Eval("DateConstituted", "{0:dd MMM yyyy}") %>
                                                                                </span>
                                                                                <span runat="server" visible='<%#(Eval("DateDissolved")).ToString()!=""? true:false %>'>
                                                                                    <%# " - " + Eval("DateDissolved", "{0:dd MMM yyyy}") %>
                                                                                </span>
                                                                            </div>
                                                                            <div runat="server" visible='<%#(Eval("YearConstituted")).ToString()!=""? true:false %>' style="font-size: small">
                                                                                <span class="text-info">
                                                                                    <b>Year: </b>
                                                                                </span>
                                                                                <span runat="server" visible='<%#(Eval("YearConstituted")).ToString()!=""? true:false %>'>
                                                                                    <%# Eval("YearConstituted") %>
                                                                                </span>
                                                                                <span runat="server" visible='<%#(Eval("YearDissolved")).ToString()!=""? true:false %>'>
                                                                                    <%# " - " + Eval("YearDissolved") %>
                                                                                </span>
                                                                            </div>
                                                                            <div runat="server" visible='<%#(Eval("ProjectedYear")).ToString()!=""? true:false %>' style="font-size: small">
                                                                                <span class="text-info">
                                                                                    <b>Projected: </b>
                                                                                </span>
                                                                                <span runat="server" visible='<%#(Eval("ProjectedMonth")).ToString()!=""? true:false %>'>
                                                                                    <%# System.Globalization.CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt32(Eval("ProjectedMonth"))).Substring(0,3) +" - " %>
                                                                                </span>
                                                                                <span runat="server" visible='<%#(Eval("ProjectedYear")).ToString()!=""? true:false %>'>
                                                                                    <%# Eval("ProjectedYear") %>
                                                                                </span>

                                                                            </div>
                                                                        </p>

                                                                        <asp:Button ID="btnAssoSession" runat="server" CssClass="btn btn-outline-primary btn-sm" Text="Show Election" OnClick="btnAssoSession_Click" Visible="false" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <ul class="list-group" runat="server" visible='<%# bool.Parse((RepAssoSessions.Items.Count == 0).ToString()) %>'>
                                                                <li class="list-group-item  list-group-item-light border-0">No Record Found!
                                                                </li>
                                                            </ul>
                                                        </FooterTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </div>

                                            <asp:SqlDataSource ID="sqlRepAssoSession" runat="server" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                SelectCommand="SELECT
                                                                    Id, SessionNumber, MortalState, DateConstituted, YearConstituted, 
                                                                    DateDissolved, YearDissolved, ProjectedYear, ProjectedMonth
                                                               FROM
                                                                    AssoSessions
                                                               WHERE 
                                                                    (IsDel=0) AND (AssoId=@AssoId)">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="hdnAssoId" Name="AssoId" PropertyName="Value" />

                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </div>

                                        <asp:HiddenField ID="hdnAssoSId" runat="server" />

                                    </ContentTemplate>
                                </asp:UpdatePanel>

                                <asp:UpdatePanel runat="server" ID="upAssoElec">
                                    <ContentTemplate>
                                        <div id="divAssoElec" style="margin-top: 5px" runat="server" visible="false">
                                            <div class="card" style="margin-bottom: 5px">
                                                <div class="card-header text-white bg-dark">
                                                    Associate Election
                                                </div>
                                                <div class="card-body" style="padding: 1px">
                                                    <ul class="list-group">
                                                        <asp:Repeater ID="RepAssoElec" runat="server" DataSourceID="sqlRepAssoElec"
                                                            OnItemDataBound="RepAssoElec_ItemDataBound" OnPreRender="RepAssoElec_PreRender">
                                                            <ItemTemplate>
                                                                <li class="list-group-item card-hover-two">
                                                                    <span class="text-primary">
                                                                        <h6><%# Eval("Name") %></h6>
                                                                        <asp:HiddenField ID="hdnId4" runat="server" Value='<%# Eval("Id") %>' />
                                                                    </span>
                                                                    <div runat="server" visible='<%#(Eval("DateStart")).ToString()!=""? true:false %>' style="font-size: small">
                                                                        <span class="text-secondary">
                                                                            <b>Polling Date: </b>
                                                                        </span>
                                                                        <span runat="server" visible='<%#(Eval("DateStart")).ToString()!=""? true:false %>'>
                                                                            <%# Eval("DateStart", "{0:dd MMM yyyy}") %>
                                                                        </span>
                                                                        <span runat="server" visible='<%#(Eval("DateFinish")).ToString()!=""? true:false %>'>
                                                                            <%# " - " + Eval("DateFinish", "{0:dd MMM yyyy}") %>
                                                                        </span>
                                                                    </div>
                                                                    <div runat="server" visible='<%#(Eval("CountingDate")).ToString()!=""? true:false %>' style="font-size: small">
                                                                        <span class="text-secondary">
                                                                            <b>Counting Date: </b>
                                                                        </span>
                                                                        <span runat="server" visible='<%#(Eval("CountingDate")).ToString()!=""? true:false %>'>
                                                                            <%# Eval("CountingDate","{0:dd MMM yyyy}") %>
                                                                        </span>
                                                                        <span runat="server" visible='<%#(Eval("CompletionDate")).ToString()!=""? true:false %>'>
                                                                            <%# " - " + Eval("CompletionDate","{0:dd MMM yyyy}") %>
                                                                        </span>
                                                                    </div>
                                                                    <p></p>
                                                                    <div>
                                                                        <asp:Button ID="btnAssoElec" runat="server" CssClass="btn btn-outline-primary btn-sm"
                                                                            Text="Show Candidate" OnClick="btnAssoElec_Click" />

                                                                    </div>
                                                                </li>
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                <ul class="list-group" runat="server" visible='<%# bool.Parse((RepAssoElec.Items.Count == 0).ToString()) %>'>
                                                                    <li class="list-group-item  list-group-item-light border-0">No Record Found!
                                                                    </li>
                                                                </ul>
                                                            </FooterTemplate>
                                                        </asp:Repeater>
                                                        <asp:HiddenField ID="hdnAssoElecId" runat="server" />
                                                    </ul>
                                                </div>
                                            </div>
                                            <asp:SqlDataSource ID="sqlRepAssoElec" runat="server" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                SelectCommand="SELECT
                                                             Id, Name, DateStart, DateFinish, CountingDate, CompletionDate
                                                        FROM
                                                             AssoElec
                                                        WHERE
                                                             (IsDel=0) AND (AssoId=@AssoId) AND (AssoSId=@AssoSId)">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="hdnAssoId" Name="AssoId" PropertyName="Value" />
                                                    <asp:ControlParameter ControlID="hdnAssoSId" Name="AssoSId" PropertyName="Value" />

                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>


                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <div id="divAssoElecPheses" style="margin-top: 5px" runat="server" visible="false">
                                            <div class="card" style="margin-bottom: 1px">
                                                <div class="card-header text-white bg-dark">
                                                    Election Phases
                                                </div>
                                                <div class="card-body" style="padding: 1px">
                                                    <asp:Repeater ID="RepAssoElecPheses" runat="server" DataSourceID="sqlRepAssoElecPheses">
                                                        <ItemTemplate>
                                                            <div class="col-sm-12" style="padding: 1px">
                                                                <div class="card" style="margin-bottom: 0px; box-shadow: none">
                                                                    <div class="card-body" style="padding: 10px">
                                                                        <asp:HiddenField ID="hdnId3" runat="server" Value='<%# Eval("Id") %>' />
                                                                        <h6 class="card-title text-primary">Phase No: 
                                                                    <span>
                                                                        <%# Eval("PhaseNum") %>
                                                                    </span>
                                                                        </h6>
                                                                        <p class="card-text">
                                                                            <div class="row">
                                                                                <div class="col-sm-6">
                                                                                    <div runat="server" visible='<%#(Eval("NotifyDate")).ToString()!=""? true:false %>' style="font-size: small">
                                                                                        <span class="text-secondary">
                                                                                            <b>Notify Date: </b>
                                                                                        </span>
                                                                                        <span runat="server" visible='<%#(Eval("NotifyDate")).ToString()!=""? true:false %>'>
                                                                                            <%# Eval("NotifyDate","{0:dd MMM yyyy}") %>
                                                                                        </span>
                                                                                    </div>
                                                                                    <div runat="server" visible='<%#(Eval("NomDateStart")).ToString()!=""? true:false %>' style="font-size: small">
                                                                                        <span class="text-secondary">
                                                                                            <b>Date: </b>
                                                                                        </span>
                                                                                        <span runat="server" visible='<%#(Eval("NomDateStart")).ToString()!=""? true:false %>'>
                                                                                            <%# Eval("NomDateStart","{0:dd MMM yyyy}") %>
                                                                                        </span>
                                                                                        <span runat="server" visible='<%#(Eval("NomDateFinish")).ToString()!=""? true:false %>'>
                                                                                            <%# " - " + Eval("NomDateFinish","{0:dd MMM yyyy}") %>
                                                                                        </span>
                                                                                    </div>
                                                                                    <div runat="server" visible='<%#(Eval("NomScrutiny")).ToString()!=""? true:false %>' style="font-size: small">
                                                                                        <span class="text-secondary">
                                                                                            <b>Scrutiny: </b>
                                                                                        </span>
                                                                                        <span runat="server" visible='<%#(Eval("NomScrutiny")).ToString()!=""? true:false %>'>
                                                                                            <%# Eval("NomScrutiny","{0:dd MMM yyyy}") %>
                                                                                        </span>
                                                                                    </div>
                                                                                    <div runat="server" visible='<%#(Eval("Withdrawal")).ToString()!=""? true:false %>' style="font-size: small">
                                                                                        <span class="text-secondary">
                                                                                            <b>Withdrawal Date: </b>
                                                                                        </span>
                                                                                        <span runat="server" visible='<%#(Eval("Withdrawal")).ToString()!=""? true:false %>'>
                                                                                            <%# Eval("Withdrawal","{0:dd MMM yyyy}") %>
                                                                                        </span>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-sm-6">
                                                                                    <div runat="server" visible='<%#(Eval("PollDate")).ToString()!=""? true:false %>' style="font-size: small">
                                                                                        <span class="text-secondary">
                                                                                            <b>Poll Date: </b>
                                                                                        </span>
                                                                                        <span runat="server" visible='<%#(Eval("PollDate")).ToString()!=""? true:false %>'>
                                                                                            <%# Eval("PollDate","{0:dd MMM yyyy}") %>
                                                                                        </span>
                                                                                    </div>
                                                                                    <div runat="server" visible='<%#(Eval("CountingDt")).ToString()!=""? true:false %>' style="font-size: small">
                                                                                        <span class="text-secondary">
                                                                                            <b>Counting Date: </b>
                                                                                        </span>
                                                                                        <span runat="server" visible='<%#(Eval("CountingDt")).ToString()!=""? true:false %>'>
                                                                                            <%# Eval("CountingDt","{0:dd MMM yyyy}") %>
                                                                                        </span>
                                                                                    </div>
                                                                                    <div runat="server" visible='<%#(Eval("Canvassing")).ToString()!=""? true:false %>' style="font-size: small">
                                                                                        <span class="text-secondary">
                                                                                            <b>Canvassing: </b>
                                                                                        </span>
                                                                                        <span runat="server" visible='<%#(Eval("Canvassing")).ToString()!=""? true:false %>'>
                                                                                            <%# Eval("Canvassing") %>
                                                                                        </span>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <ul class="list-group" runat="server" visible='<%# bool.Parse((RepAssoElecPheses.Items.Count == 0).ToString()) %>'>
                                                                <li class="list-group-item  list-group-item-light border-0">No Record Found!
                                                                </li>
                                                            </ul>
                                                        </FooterTemplate>
                                                    </asp:Repeater>

                                                </div>
                                            </div>

                                            <asp:SqlDataSource ID="sqlRepAssoElecPheses" runat="server" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                SelectCommand="SELECT 
                                                             Id, PhaseNum, NotifyDate, NomDateStart, NomDateFinish, NomScrutiny,
                                                             Withdrawal, Canvassing, PollDate, CountingDt, TimeDesc
                                                        FROM
                                                             AssoElecPhases
                                                        WHERE
                                                             (IsDel=0) AND (AssoElecId=@AssoElecId)">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="hdnAssoElecId" Name="AssoElecId" PropertyName="Value" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>

                                <asp:UpdatePanel ID="upAssoECandi" runat="server">
                                    <ContentTemplate>
                                        <div id="divAssoECandi" style="margin-top: 5px" runat="server" visible="false">
                                            <div class="card" style="margin-bottom: 5px">
                                                <div class="card-header text-white bg-dark">
                                                    Election Candidate
                                                </div>
                                                <div class="card-body" style="padding: 1px">
                                                    <%-- <div class="row" style="padding-left: 15px; padding-right: 15px">--%>
                                                    <asp:Repeater ID="RepAssoECandiPost" runat="server" DataSourceID="sqlRepAssoECandiPost" OnItemDataBound="RepAssoECandiPost_ItemDataBound">
                                                        <ItemTemplate>
                                                            <div class="card" style="margin-bottom: 1px; border-radius: unset">
                                                                <div class="card-header bg-info text-white text-center" style="padding: 2px; border-radius: unset">
                                                                    <%# Eval("PName") %>
                                                                    <asp:HiddenField ID="hdnId5" runat="server" Value='<%# Eval("Id") %>' />
                                                                </div>
                                                                <div class="card-body" style="padding: 1px">
                                                                    <div class="row" style="padding-left: 15px; padding-right: 15px">
                                                                        <asp:Repeater ID="RepAssoECandi" runat="server">
                                                                            <ItemTemplate>
                                                                                <div class="col-sm-6 col-md-4 col-xl-4" style="padding: 1px">
                                                                                    <div class="card h-100 card-hover" style="margin-bottom: 0px; box-shadow: none">
                                                                                        <asp:Image ID="img" runat="server" ImageUrl='<%# Eval("Img") %>' Height="130px" CssClass="img-fluid img-large pointer-cursor" />
                                                                                        <%--tooltip Image--%>
                                                                                        <div id="tooltip" style="display: none;">
                                                                                            <table style="margin: auto">
                                                                                                <tr>

                                                                                                    <td>
                                                                                                        <asp:Image ID="imgLarge" Width="250px" Height="150px" ImageUrl='<%#Eval("Img") %>' runat="server" CssClass="img-thumbnail" /></td>
                                                                                                </tr>
                                                                                            </table>

                                                                                        </div>
                                                                                        <div class="card-body" style="padding: 10px">
                                                                                            <h6 class="card-title text-primary">
                                                                                                <%# Eval("NameFirst") %>
                                                                                                <span runat="server" visible='<%#(Eval("NameMiddle")).ToString()!=""? true:false %>'>
                                                                                                    <%# "  " + Eval("NameMiddle") %>
                                                                                                </span>
                                                                                                <span runat="server" visible='<%#(Eval("NameLast")).ToString()!=""? true:false %>'>
                                                                                                    <%# "  " + Eval("NameLast") %>
                                                                                                </span>
                                                                                            </h6>
                                                                                            <p class="card-text" style="font-size: small; margin-bottom: 0px">

                                                                                                <span runat="server" visible='<%# Convert.ToInt32(Eval("Votes"))!=0? true:false %>'>
                                                                                                    <asp:Image ID="imgVotes" runat="server" Width="20px" ImageAlign="Middle" ImageUrl="~/Image/Public/Vote Icon.png" />
                                                                                                </span>
                                                                                                <span class="badge badge-pill badge-secondary" runat="server" visible='<%# Convert.ToInt32(Eval("Votes"))!=0? true:false %>'>
                                                                                                    <%# Eval("Votes") %>
                                                                                                </span>
                                                                                                <span class="badge badge-pill badge-success" runat="server" visible='<%# Convert.ToBoolean(Eval("Winner"))!=false? true:false %>'>Winner
                                                                                                </span>
                                                                                                <span class="badge badge-pill badge-warning" runat="server" visible='<%# Convert.ToBoolean(Eval("Withdrawn"))!=false? true:false %>'>Withdrawn
                                                                                                </span>
                                                                                                <span class="badge badge-pill badge-danger" runat="server" visible='<%# Convert.ToBoolean(Eval("Disqualified"))!=false? true:false %>'>Disqualified
                                                                                                </span>

                                                                                                <div runat="server" visible='<%#(Eval("DoB")).ToString()!=""? true:false %>' style="font-size: small">
                                                                                                    <span class="text-info">
                                                                                                        <b>Date of Birth: </b>
                                                                                                    </span>
                                                                                                    <span runat="server" visible='<%#(Eval("DoB")).ToString()!=""? true:false %>'>
                                                                                                        <%# Eval("DoB","{0:dd MMM yyyy}") %>
                                                                                                    </span>
                                                                                                </div>
                                                                                                <div runat="server" visible='<%#(Eval("Age")).ToString()!=""? true:false %>' style="font-size: small">
                                                                                                    <span class="text-info">
                                                                                                        <b>Age: </b>
                                                                                                    </span>
                                                                                                    <span runat="server" visible='<%#(Eval("Age")).ToString()!=""? true:false %>'>
                                                                                                        <%# Eval("Age") %>
                                                                                                    </span>
                                                                                                </div>

                                                                                                <div>
                                                                                                    <span class="fa fa-heart" style="color: coral;" data-toggle="tooltip"></span>
                                                                                                    <span class="badge badge-pill badge-dark" style="font-size: x-small">
                                                                                                        <%# Eval("SupportVotes") %>
                                                                                                    </span>

                                                                                                    <span class="fa-stack" style="color: coral; margin-right: -8px;" data-toggle="tooltip">
                                                                                                        <i class="fa fa-heart fa-stack-1x"></i>
                                                                                                        <i class="fa fa-bolt fa-stack-1x fa-inverse"></i>
                                                                                                    </span>
                                                                                                    <span class="badge badge-pill badge-dark" style="font-size: x-small">
                                                                                                        <%# Eval("SupportVotesInactive") %>
                                                                                                    </span>

                                                                                                </div>

                                                                                                <div runat="server" visible='<%#(Eval("Affidavit")).ToString()!=""? true:false %>' style="font-size: small">

                                                                                                    <asp:HyperLink ID="hlAffidavit" runat="server" NavigateUrl="#">
                                                                                                    <i class="fa fa-file-pdf-o" style="color: red"></i>
                                                                                                        Affidavit
                                                                                                    </asp:HyperLink>
                                                                                                </div>



                                                                                            </p>
                                                                                            <span>
                                                                                                <a href="#" class="btn btn-outline-primary btn-sm" style="margin-bottom: 2px">Support</a>
                                                                                            </span>
                                                                                            <a href="#" class="btn btn-outline-primary btn-sm">See Profile</a>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </ItemTemplate>
                                                                        </asp:Repeater>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <%--<div class="card-columns">--%>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <ul class="list-group" runat="server" visible='<%# bool.Parse((RepAssoECandiPost.Items.Count == 0).ToString()) %>'>
                                                                <li class="list-group-item  list-group-item-light border-0">No Record Found!
                                                                </li>
                                                            </ul>
                                                        </FooterTemplate>
                                                    </asp:Repeater>
                                                    <asp:HiddenField ID="hdnAssoECandiPost" runat="server" />
                                                </div>
                                                <%--</div>--%>
                                            </div>

                                            <asp:SqlDataSource ID="sqlRepAssoECandiPost" runat="server" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                SelectCommand="SELECT 
                                                                    DISTINCT P.Id, P.PName
                                                               FROM
                                                                     AssoPosts P
                                                               INNER JOIN AssoECandi EC ON P.Id=EC.AssoPostId
                                                               WHERE
                                                                    (EC.IsDel=0) AND (EC.AssoEId=@AssoEId)">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="hdnAssoElecId" Name="AssoEId" PropertyName="Value" />
                                                </SelectParameters>

                                            </asp:SqlDataSource>

                                        </div>

                                    </ContentTemplate>
                                </asp:UpdatePanel>

                            </div>
                            <div id="menu1" class="container tab-pane fade">
                                <br />
                                <h3>Menu 1</h3>
                                <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                            </div>
                            <div id="menu2" class="container tab-pane fade">
                                <br />
                                <h3>Menu 2</h3>
                                <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2"></div>

                </div>
            </div>

        </div>
    </form>
</body>
</html>
