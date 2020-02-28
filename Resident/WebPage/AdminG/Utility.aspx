<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Utility.aspx.cs" Inherits="Resident.WebPage.AdminG.Utility" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.css" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.js"></script>

    <script>

        $(document).ready(function () {
            funNumber();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (evt, args) {
                funNumber();
            });
        });
        function alertmsg() {
            swal({
                title: 'Congratulations!',
                text: 'Successfully updated',
                type: 'success'
            });
        }

        (function ($) {
            $.fn.inputFilter = function (inputFilter) {
                return this.on("input keydown keyup mousedown mouseup select contextmenu drop", function () {
                    if (inputFilter(this.value)) {
                        this.oldValue = this.value;
                        this.oldSelectionStart = this.selectionStart;
                        this.oldSelectionEnd = this.selectionEnd;
                    } else if (this.hasOwnProperty("oldValue")) {
                        this.value = this.oldValue;
                        this.setSelectionRange(this.oldSelectionStart, this.oldSelectionEnd);
                    }
                });
            };
        }(jQuery));

        function funNumber() {

            $(".number-only").inputFilter(function (value) {
                return /^\d*$/.test(value);
            });
        }

        <%--function uploadComplete(sender) {
            $get("<%=lblMesg.ClientID%>").innerHTML = "File Uploaded Successfully";
        }

        function uploadError(sender) {
            $get("<%=lblMesg.ClientID%>").innerHTML = "File upload failed.";
        }--%>

</script>

    <style>
        .custom-file-label {
            height: unset;
        }

            .custom-file-label::after {
                height: unset;
                border-left: unset;
            }

        .custom-control-label::before {
            top: 0px;
        }

        .custom-control-label::after {
            top: 0px;
        }

        input,
        input::-webkit-input-placeholder {
            font-size: xx-small;
        }

        textarea,
        textarea::-webkit-input-placeholder {
            font-size: xx-small;
        }

        .width-auto{
            width:auto;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="container">
            <div class="row mt-5">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <div class="card text-center">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-2"></div>
                                <div class="col-sm-8">
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>

                                            <asp:DropDownList ID="ddlUtilityCat" runat="server" CssClass="form-control form-control-sm" AutoPostBack="true"
                                                DataSourceID="SqlddlUtilityCat" OnSelectedIndexChanged="ddlUtilityCat_SelectedIndexChanged" AppendDataBoundItems="true"
                                                DataTextField="Name" DataValueField="Id">
                                                <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource runat="server" ID="SqlddlUtilityCat" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                SelectCommand="SELECT [Id], [Name] FROM [UtilityCat]"></asp:SqlDataSource>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="col-sm-2"></div>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-2"></div>

            </div>

            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div id="divUtilityView" runat="server" visible="false">
                        <div class="row mt-2">
                            <div class="col-sm-2"></div>
                            <div class="col-sm-8">
                                <div class="card">
                                    <div class="card-body">

                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <asp:Label ID="lblName" AssociatedControlID="txtName" runat="server" CssClass="small" Text="Name"></asp:Label>
                                                    <i class="fas fa-asterisk" style="font-size: 5px; color: crimson"></i>

                                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control form-control-sm" Placeholder="..enter a name"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtName"
                                                        runat="server" Display="Dynamic" ValidationGroup="valUtility" Font-Size="XX-Small" SetFocusOnError="true" />
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <asp:Label ID="lblPostalCode" AssociatedControlID="txtPostalCode" runat="server" CssClass="small" Text="Postal Code"></asp:Label>
                                                <i class="fas fa-asterisk" style="font-size: 5px; color: crimson"></i>

                                                <asp:TextBox ID="txtPostalCode" runat="server" CssClass="form-control form-control-sm number-only" Placeholder="..enter a postal code"></asp:TextBox>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtPostalCode"
                                                    runat="server" Display="Dynamic" ValidationGroup="valUtility" Font-Size="XX-Small" SetFocusOnError="true" />
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-sm-6">
                                                <asp:Label ID="lblAddress1" AssociatedControlID="txtAddress1" runat="server" CssClass="small" Text="Address Line1"></asp:Label>
                                                <i class="fas fa-asterisk" style="font-size: 5px; color: crimson"></i>

                                                <asp:TextBox ID="txtAddress1" runat="server" CssClass="form-control form-control-sm" Placeholder="..enter address1" TextMode="MultiLine"></asp:TextBox>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtAddress1"
                                                    runat="server" Display="Dynamic" ValidationGroup="valUtility" Font-Size="XX-Small" SetFocusOnError="true" />
                                            </div>
                                            <div class="col-sm-6">
                                                <asp:Label ID="lblAddress2" AssociatedControlID="txtAddress2" runat="server" CssClass="small" Text="Address Line2"></asp:Label>
                                                <asp:TextBox ID="txtAddress2" runat="server" CssClass="form-control form-control-sm" Placeholder="..enter address2" TextMode="MultiLine"></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-sm-6">

                                                <asp:Label ID="lblMobile1" AssociatedControlID="txtMobile1" runat="server" CssClass="small" Text="Mobile"></asp:Label>
                                                <i class="fas fa-asterisk" style="font-size: 5px; color: crimson"></i>

                                                <div class="input-group input-group-sm">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text" id="">
                                                            <asp:Label ID="lblMobileCode1" runat="server" Text="+91" Font-Size="Small"></asp:Label>
                                                        </span>
                                                    </div>
                                                    <asp:TextBox ID="txtMobile1" runat="server" CssClass="form-control form-control-sm number-only" Placeholder="..enter mobile number"></asp:TextBox>
                                                </div>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtMobile1"
                                                    runat="server" Display="Dynamic" ValidationGroup="valUtility" Font-Size="XX-Small" SetFocusOnError="true" />

                                                <asp:RegularExpressionValidator ID="regxMobileNumberValid" runat="server" ValidationExpression="^[0-9]*$"
                                                    ForeColor="Crimson" ControlToValidate="txtMobile1" Display="Dynamic" ValidationGroup="valUtility" Font-Size="XX-Small" SetFocusOnError="true" ErrorMessage="Invalid Email Format"></asp:RegularExpressionValidator>

                                            </div>
                                            <div class="col-sm-6">

                                                <div class="form-group ">
                                                    <asp:Label ID="lblPhone1" AssociatedControlID="txtPhone1" runat="server" CssClass="small" Text="Phone">
                                                    </asp:Label>
                                                    <asp:TextBox ID="txtPhone1" runat="server" CssClass="form-control form-control-sm" Placeholder="..enter a phone number"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-sm-6">

                                                <div class="form-group ">
                                                    <asp:Label ID="lblEmail1" AssociatedControlID="txtEmail1" runat="server" CssClass="small" Text="Email">
                                                    </asp:Label>
                                                    <asp:TextBox ID="txtEmail1" runat="server" CssClass="form-control form-control-sm" Placeholder="..enter an email" TextMode="Email"></asp:TextBox>
                                                    <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                        ForeColor="Crimson" ControlToValidate="txtEmail1" Display="Dynamic" ValidationGroup="valUtility" Font-Size="XX-Small" SetFocusOnError="true" ErrorMessage="Invalid Email Format"></asp:RegularExpressionValidator>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">

                                                <div class="form-group">
                                                    <asp:Label ID="lblWebsite1" AssociatedControlID="txtWebsite" runat="server" CssClass="small" Text="Website"></asp:Label>
                                                    <asp:TextBox ID="txtWebsite" runat="server" CssClass="form-control form-control-sm" Placeholder="..enter a website"></asp:TextBox>

                                                    <asp:RegularExpressionValidator ID="regxWebsiteVal" ControlToValidate="txtWebsite"
                                                        ForeColor="Crimson" Display="Dynamic" ValidationGroup="valUtility" Font-Size="XX-Small" SetFocusOnError="true" ErrorMessage="Invalid URL"
                                                        ValidationExpression="(([\w]+:)?\/\/)?(([\d\w]|%[a-fA-f\d]{2,2})+(:([\d\w]|%[a-fA-f\d]{2,2})+)?@)?([\d\w][-\d\w]{0,253}[\d\w]\.)+[\w]{2,4}(:[\d]+)?(\/([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)*(\?(&?([-+_~.\d\w]|%[a-fA-f\d]{2,2})=?)*)?(#([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)?$" runat="server" />

                                                </div>

                                            </div>

                                        </div>

                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <asp:Label ID="lblImage1" AssociatedControlID="ajaxUpload" runat="server" CssClass="small" Text="Image"></asp:Label>
                                                    <%--<div class="custom-file">
                                                        <asp:FileUpload ID="fuImage1" runat="server" accept="image/*" CssClass="custom-file-input" />
                                                        <asp:Label AssociatedControlID="fuImage1" CssClass="custom-file-label" runat="server" Font-Size="X-Small">Choose File</asp:Label>
                                                    </div>--%>


                                                    <%--<asp:RegularExpressionValidator ID="revalfuImage1" ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.png|.jpg|.bmp|.gif|.jpeg|.tft|.PNG|.JPG|.BMP|.GIF|.JPEG|.TFT)$"
                                                        ControlToValidate="ajaxfuImage1" runat="server" ForeColor="Red" ErrorMessage="*Invalid Image Extension." Font-Size="XX-Small"
                                                        Display="Dynamic" ValidationGroup="valUtility" />--%>

                                                    <%--<ajax:AsyncFileUpload ID="ajaxfuImage1" runat="server" OnClientUploadComplete="uploadComplete"
                                                        Width="400px" UploaderStyle="Modern" CompleteBackColor="White"
                                                        UploadingBackColor="#CCFFFF" OnUploadedComplete="ajaxfuImage1_UploadedComplete" />
                                                    <br />
                                                    <asp:Label ID="lblMesg" runat="server" Text=""></asp:Label>--%>
                                                    <ajax:AjaxFileUpload ID="ajaxUpload" runat="server" MaximumNumberOfFiles="1" Font-Size="X-Small" ClearFileListAfterUpload="true"
                                                         OnUploadComplete="ajaxUpload_UploadComplete" AllowedFileTypes="jpeg,jpg,png,gif" MaxFileSize="1024" />

                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <asp:Label ID="lblLogo2" AssociatedControlID="fuLogo2" runat="server" CssClass="small" Text="Logo"></asp:Label>
                                                    <div class="custom-file">
                                                        <asp:FileUpload ID="fuLogo2" runat="server" accept="image/*" CssClass="custom-file-input" />
                                                        <asp:Label AssociatedControlID="fuLogo2" CssClass="custom-file-label" runat="server" Font-Size="X-Small">Choose File</asp:Label>
                                                    </div>
                                                    <asp:RegularExpressionValidator ID="revalfuLogo2" ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.png|.jpg|.bmp|.gif|.jpeg|.tft|.PNG|.JPG|.BMP|.GIF|.JPEG|.TFT)$"
                                                        ControlToValidate="fuLogo2" runat="server" ForeColor="Red" ErrorMessage="*Invalid Image Extension." Font-Size="XX-Small"
                                                        Display="Dynamic" ValidationGroup="valUtility" />

                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="custom-control custom-checkbox">
                                                    <input type="checkbox" class="custom-control-input" id="customCheck" runat="server" clientidmode="Static" />
                                                    <label class="custom-control-label" for="customCheck" style="font-size: x-small">Terms And Condition</label>
                                                </div>
                                                <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-outline-success btn-sm float-right" Text="Submit" OnClick="btnSubmit_Click" ValidationGroup="valUtility" />
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row mt-2">
                            <div class="col-sm-2"></div>
                            <div class="col-sm-8">
                                <div class="card bg-light text-dark">
                                    <div class="card-body mb-2">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <asp:Repeater ID="RepUtility" runat="server" DataSourceID="SqlRepUtility">

                                                    <ItemTemplate>
                                                        <div class="card mb-2">
                                                            <div class="card-body">
                                                                <asp:HiddenField ID="hdnId" runat="server" Value='<%# Eval("Id") %>' />

                                                                <h5 class="card-title"><%# Eval("Name") %></h5>
                                                                <p class="card-text">
                                                                    <div>
                                                                        Address: <span>
                                                                            <%# Eval("Addr1") %>
                                                                        </span>
                                                                        <span runat="server" visible='<%#(Eval("Addr2")).ToString()!=string.Empty? true:false %>'>, <%# Eval("Addr2") %>
                                                                        </span>
                                                                        <span>- <%# Eval("PostalCode") %>
                                                                        </span>
                                                                    </div>
                                                                    <div>
                                                                        Contact No : 
                                                                    <span runat="server" visible='<%#(Eval("Phone")).ToString()=="False"? true:false %>' class="text-danger">/ <%# Eval("Phone") %>

                                                                    </span>

                                                                        <span>
                                                                            <%# Eval("Mobile") %>
                                                                        </span>
                                                                    </div>

                                                                    <div>
                                                                        <span runat="server" visible='<%#(Eval("Email")).ToString()!=string.Empty? true:false %>'>Email:- <a href='<%# "mailto:"+ Eval("Email") %>' runat="server"><%# Eval("Email") %></a>

                                                                        </span>
                                                                    </div>

                                                                    <div>
                                                                        <span runat="server" visible='<%#(Eval("Website")).ToString()!=string.Empty? true:false %>'>Website: <%# Eval("Website") %>
                                                                            <a href='<%# "http://www." + Eval("Website") %>' runat="server" target="_blank"><%# "www." + Eval("Website") %></a>

                                                                        </span>
                                                                    </div>

                                                                </p>
                                                            </div>
                                                        </div>
                                                    </ItemTemplate>


                                                </asp:Repeater>

                                                <asp:SqlDataSource runat="server" ID="SqlRepUtility" ConnectionString='<%$ ConnectionStrings:Residence4UmDBContext %>'
                                                    SelectCommand="Utility_View" SelectCommandType="StoredProcedure">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="ddlUtilityCat" Name="CatId" PropertyName="SelectedValue" Type="Int32"></asp:ControlParameter>
                                                        <asp:Parameter Name="ComplexId" Type="Int32" DefaultValue="1" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>
