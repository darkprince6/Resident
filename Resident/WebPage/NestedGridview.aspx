<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NestedGridview.aspx.cs" Inherits="Resident.WebPage.NestedGridview" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <script type="text/javascript">
        var pageIndex = 1;
        var pageCount;
        var IsNoMoreImages = false;
        $(window).scroll(function () {
            //if ($(window).scrollTop() == $(document).height() - $(window).height()) {

            if (($(window).scrollTop() + $(window).innerHeight()) >= $(document).height() - 100) {
                $(".loader").show().delay(2000).queue(function () {
                    GetRecords();
                    $(this).dequeue();
                    $(".loader").hide();
                });
            }
        });
        function GetRecords() {
            pageIndex++;
            if (pageIndex == 2 || pageIndex <= pageCount) {
                $(".loader").show();
                $.ajax({
                    type: "POST",
                    url: "NestedGridview.aspx/GetUtility",
                    data: '{pageIndex: ' + pageIndex + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccess,
                    failure: function (response) {
                        alert(response.d);
                    },
                    error: function (response) {
                        alert(response.d);
                    }
                });
            } else {
                if (!IsNoMoreImages) {
                    $(".loader").hide();
                    IsNoMoreImages = true;
                    $("#divUtility").append('<br /><div class="text-center small text-secondery"><b>No more data to show...</b><div>');

                }
            }
        }
        function OnSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            pageCount = parseInt(xml.find("PageCount").eq(0).find("PageCount").text());
            var utilities = xml.find("Utility");
            utilities.each(function () {
                var utility = $(this);
                var table = $("#divUtility table").eq(0).find('td').eq(0).clone(true);
                var table = $("[id$=GvwUtility] tr").eq(0).find("td").eq(0).clone(true);
                var utilityId = utility.find("Id").text();
                $(".id", table).html(utility.find("Id").text());
                $(".name", table).html(utility.find("Name").text());
                NestedData(utilityId, table);
                $("[id$=GvwUtility]").append(table).append("<br/>");
                //$("[id$=GvwUtility]").append(table).append("<br/>");
            });
            $(".loader").hide();
        }
        function NestedData(utilityId, table) {
            $.ajax({
                type: "POST",
                url: "NestedGridview.aspx/GetUtilityEmail",
                data: '{utilityId: "' + utilityId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (respon) {
                    var xmlDoc = $.parseXML(respon.d);
                    var xml = $(xmlDoc);
                    var utilityEmails = xml.find("UtilityEmail");
                    utilityEmails.each(function () {
                        var utilityEmail = $(this);
                        //var repUtilityEmail = $('#divUtilityEmail table').eq(0).clone(true);
                        var repUtilityEmail = $('#divUtilityEmail').eq(0).clone(true);
                        $(".utilityId", repUtilityEmail).html(utilityEmail.find("UtilityId").text());
                        $(".email", repUtilityEmail).html(utilityEmail.find("Email").text());
                        $(table).append(repUtilityEmail).append("<br/>");
                    });
                },
                failure: function (respon) {
                    alert(respon.d);
                },
                error: function (respon) {
                    alert(respon.d);
                }
            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row mt-5">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <div id="divUtility">
                        <asp:GridView runat="server" ID="GvwUtility" OnRowDataBound="GvwUtility_RowDataBound" ShowHeader="false" AutoGenerateColumns="false"
                            GridLines="None" CssClass="table table-bordered table-striped" Font-Size="Small" DataKeyNames="Id">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>

                                        <span class="id">
                                            <%# Eval("Id")%><br />
                                        </span>
                                        <span class="name">
                                            <%# Eval("Name")%><br />
                                        </span>
                                        <asp:HiddenField ID="hdnUtilityId" Value='<%# Eval("Id") %>' runat="server" />

                                        <div id="divUtilityEmail">
                                            <asp:GridView runat="server" ID="GvwUtilityEmail" GridLines="None" ShowHeader="false" AutoGenerateColumns="false"
                                                CssClass="table table-bordered table-striped" Font-Size="Small" DataKeyNames="Id">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>

                                                            <span class="utilityId">
                                                                <%# Eval("UtilityId")%><br />
                                                            </span>
                                                            <span class="email">
                                                                <%# Eval("Email")%><br />
                                                            </span>

                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>

                    <div class="loader text-center" style="display: none">
                        <div class="spinner-grow spinner-grow-sm"></div>
                        <div class="spinner-grow spinner-grow-sm"></div>
                        <div class="spinner-grow spinner-grow-sm"></div>
                    </div>
                </div>
                <div class="col-sm-2"></div>
            </div>
        </div>
    </form>
</body>
</html>
