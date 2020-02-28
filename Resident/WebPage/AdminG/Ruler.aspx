<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Ruler.aspx.cs" Inherits="Resident.WebPage.AdminG.Ruler" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.5.7/flatpickr.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.js"></script>
    <script src="https://kit.fontawesome.com/5f92b8c4a8.js"></script>

    <script>
        function CustvalRules_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkRules.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }

        function alertMsgForRules() {
            swal({
                title: 'Congratulations!',
                text: 'Successfully Inserted Data',
                type: 'success'
            });
        }

        function alertMsgForRulesUpd() {
            swal({
                title: 'Congratulations!',
                text: 'Successfully Updated Data',
                type: 'success'
            });
        }

        function openModalForRemove() {
            $('.open-modal-for-remove').modal('show');
        }

        function closeModalForRemove() {
            $('.open-modal-for-remove').modal('hide');
        }
        //$(document).ready(function () {
        //    GetMeeting();
        //    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (evt, args) {
        //        GetMeeting();
        //    });
        //});

        //function GetMeeting() {
        //    //highlightAutoComplete();
        //    $("#txtMeeting").autocomplete({
        //        //highlightClass: "bold-text",
        //        source: function (request, response) {
        //            $.ajax({
        //                url: "../../WebPage/Service/Meeting.asmx/GetMeeting",
        //                data: "{ 'prefix': '" + request.term + "','complexId':'1'}",
        //                dataType: "json",
        //                type: "POST",
        //                contentType: "application/json; charset=utf-8",
        //                autoFocus: true,
        //                success: function (data) {
        //                    if (data.d.length > 0) {
        //                        response($.map(data.d, function (item) {
        //                            return {
        //                                label: item.split('-')[0],
        //                                val: item.split('-')[1]
        //                            };
        //                        }));
        //                        $("#btnSubmit").removeAttr("href", false);
        //                        $("#btnSubmit").removeClass("disabled", true);
        //                    } else {
        //                        //If no records found, set the default "No match found" item with value -1.
        //                        response([{ label: 'No results found.', val: -1 }]);
        //                        $("#hdnMeetingId").val("");
        //                        $("#btnSubmit").removeAttr("href", false);
        //                        $("#btnSubmit").addClass("disabled", false);
        //                    }
        //                }
        //                ,
        //                error: function (response) {
        //                    alert(response.responseText);
        //                },
        //                failure: function (response) {
        //                    alert(response.responseText);
        //                }
        //            });
        //        },
        //        select: function (e, i) {
        //            if (i.item.val === -1 || i.item.label === null) {
        //                //Clear the AutoComplete TextBox.
        //                $(this).val("");
        //                $("#btnSubmit").removeAttr("href", false);
        //                $("#btnSubmit").addClass("disabled", false);
        //                return false;
        //            }
        //            else {

        //                $("#hdnMeetingId").val(i.item.val);
        //                //var _complexId = i.item.val;
        //                //var _complexName = i.item.label.replace(/\s/g, '-');
        //                //$("#hlSubmit").attr("href", "Complex/" + _complexName + "/" + _complexId);
        //                //$("#hlSubmit").removeClass("disabled", true);


        //            }
        //        },
        //        minLength: 2
        //    });
        //}



    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="SM1" runat="server"></asp:ScriptManager>
        <div class="container">
            <div class="row">
                <div class="col-md-2">
                </div>
                <div class="col-md-8">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-body">
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <div class="row" id="divEntryForRules" runat="server" visible="true">
                                                <asp:HiddenField ID="hdnPixel" runat="server" />
                                                <div class="col-sm-12">
                                                    <div class="form-group m-2px">
                                                        <asp:Label AssociatedControlID="ddlRulesCat" runat="server" Text="Choose a Rule Category: *" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                                        <asp:DropDownList ID="ddlRulesCat" runat="server" CssClass="form-control form-control-sm" Font-Size="Small" DataSourceID="SqlDdlRulesCat"
                                                            DataTextField="Name" DataValueField="Id" AppendDataBoundItems="true">
                                                            <asp:ListItem Text="--Select--"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="ddlRulesCat"
                                                            runat="server" Display="Dynamic" ValidationGroup="valRules" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        <asp:SqlDataSource runat="server" ID="SqlDdlRulesCat" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                            SelectCommand="SELECT [Id], [Name] FROM [RulerCat] WHERE ([ComplexId] = @ComplexId) AND IsDel=0">
                                                            <SelectParameters>
                                                                <asp:QueryStringParameter QueryStringField="ComplexId" Name="ComplexId" Type="Int32"></asp:QueryStringParameter>
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </div>

                                                    <div class="form-group m-2px">
                                                        <asp:Label AssociatedControlID="txtTitle" runat="server" Text="Title: *" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                                        <asp:TextBox ID="txtTitle" runat="server" Placeholder="... enter a title" CssClass="form-control form-control-sm"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtTitle"
                                                            runat="server" Display="Dynamic" ValidationGroup="valRules" Font-Size="XX-Small" SetFocusOnError="true" />
                                                    </div>
                                                     <div class="form-group m-2px">
                                                        <asp:Label AssociatedControlID="txtDescr" runat="server" Text="Description:" Font-Size="Small"></asp:Label>
                                                        <asp:TextBox ID="txtDescr" runat="server" Placeholder="... enter a description" CssClass="form-control form-control-sm" 
                                                            TextMode="MultiLine" Height="50"></asp:TextBox>
                                                    </div>

                                                    <div class="custom-control custom-checkbox m-1">
                                                        <input type="checkbox" class="custom-control-input chk-rules" id="chkRules" runat="server" clientidmode="static" />
                                                        <label class="custom-control-label" for="chkRules">Terms And Condition</label>
                                                    </div>

                                                    <div>
                                                        <asp:CustomValidator runat="server" ID="CustvalRules" EnableClientScript="true"
                                                            Display="Dynamic" Font-Size="X-Small" ForeColor="Crimson"
                                                            ValidationGroup="valRules" OnServerValidate="CustValRules_ServerValidate"
                                                            ErrorMessage="* Required" ClientValidationFunction="CustvalRules_ClientValidate"></asp:CustomValidator>
                                                    </div>


                                                    <asp:Label ID="lblErroMsg" runat="server" ForeColor="Crimson" Font-Size="Small" Visible="false">
                                                                    <i class="fas fa-exclamation-triangle mr-1"></i> Failed to submit data. Please try again
                                                    </asp:Label>

                                                    <div>
                                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm"
                                                            ValidationGroup="valRules" OnClick="btnSubmit_Click" />

                                                        <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-outline-success btn-sm" Visible="false"
                                                            ValidationGroup="valRules" OnClick="btnUpdate_Click" />

                                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-outline-danger btn-sm"
                                                            OnClick="btnCancel_Click" />
                                                    </div>
                                                    <div>
                                                        <asp:Label runat="server" ID="lblNoLog" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You are not logged-in or session has expired."></asp:Label>
                                                        <asp:Label runat="server" ID="lblNoAdmin" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the governing association of this complex to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                        <asp:Label runat="server" ID="lblNoAdminCom" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the committee you have selected to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                        <asp:Label runat="server" ID="lblNoAdminActG" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the activity group you have selected to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                        <asp:Label runat="server" ID="lblNotAttached" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You are not an authorised owner / resident of this complex. So you can't schedule a meeting inside it."></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Repeater ID="RepRules" runat="server" DataSourceID="SqlRepRules">
                                        <ItemTemplate>
                                            <asp:HiddenField ID="hdnRulesId" runat="server" Value='<%# Eval("Id") %>' />
                                            <asp:HiddenField ID="hdnRulerCatId" runat="server" Value='<%# Eval("RulerCatId") %>' />

                                            <div class="card mb-2">
                                                <div class="card-body p-2">
                                                    <h6 class="card-title m-0">
                                                        <asp:Label ID="lblTitle" runat="server" Text='<%# Eval("Title") %>' ForeColor="SaddleBrown"></asp:Label>
                                                    </h6>
                                                    <div class="card-text m-0">
                                                        <asp:Label ID="lblDescr" runat="server" Text='<%# Eval("Descr") %>'
                                                            ForeColor="SaddleBrown" Visible='<%#(Eval("Descr")).ToString()!=""? true:false %>'></asp:Label>

                                                        <div class="h6 mb-0">
                                                            <span>Category:-</span>
                                                            <span>
                                                                <asp:Label ID="lblRulesCat" runat="server" Font-Size="X-Small" Text='<%# Eval("RulesCat") %>'> </asp:Label>
                                                            </span>
                                                        </div>
                                                        <div class="h6 mb-0">
                                                            <asp:Label runat="server" class="text-muted" Font-Size="XX-Small"
                                                                Text='<%# Eval("ModDt").ToString() =="" ? "Listed On: "+Eval("CrDt","{0:dd MMM yyyy hh:mm tt}"): "Updated On: "+Eval("ModDt", "{0:dd MMM yyyy hh:mm tt}") %>'>
                                                                        
                                                            </asp:Label>
                                                        </div>
                                                    </div>
                                                    <asp:LinkButton ID="lbtnEdit" runat="server" CssClass="card-link btn-sm text-primary"
                                                        Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'
                                                        OnClick="lbtnEdit_Click" Font-Size="Small">
                                                                    <i class="far fa-edit"></i> Edit
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="lbtnRemove" runat="server" CssClass="card-link btn-sm text-danger" OnClick="lbtnRemove_Click" Font-Size="Small"
                                                        Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'>
                                                                    <i class="far fa-trash-alt"></i> Remove
                                                    </asp:LinkButton>
                                                    <asp:Label runat="server" CssClass="text-danger" Font-Size="10px" Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>Removed</asp:Label>
                                                    <asp:LinkButton ID="lbtnReinclude" runat="server" CssClass="card-link btn-sm text-warning" OnClick="lbtnReinclude_Click" Font-Size="Small"
                                                        Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>
                                                                   <i class="fas fa-undo"></i> Re-include
                                                    </asp:LinkButton>
                                                </div>

                                            </div>

                                            </div>
                                            </div>

                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepRules.Items.Count == 0).ToString()) %>'>
                                                <li class="list-group-item  list-group-item-light small">No record listed as of now!
                                                </li>
                                            </ul>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                    <asp:SqlDataSource runat="server" ID="SqlRepRules" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                        SelectCommand="Rules_Sel_ForRep" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:QueryStringParameter QueryStringField="ComplexId" Name="ComplexId" Type="Int32"></asp:QueryStringParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>
        </div>

         <div class="modal fade open-modal-for-remove" id="ModelForRemove" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblTitleForRemove" runat="server">Remove this category</asp:Label>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card">
                                    <div class="card-body card-body-modal-popup">
                                        <div class="row">
                                            <asp:UpdatePanel runat="server">
                                                <ContentTemplate>
                                                    <asp:LinkButton ID="lbtnSubmitForRemove" runat="server"
                                                        CssClass="btn btn-outline-danger btn-sm float-right" OnClick="lbtnSubmitForRemove_Click">
                                                                        <i class="fas fa-check mr-1"></i>Yes
                                                    </asp:LinkButton>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                            <button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">
                                                <i class="fas fa-times mr-1"></i>No
                                            </button>

                                        </div>

                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
