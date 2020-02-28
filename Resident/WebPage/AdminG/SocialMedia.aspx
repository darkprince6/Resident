<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SocialMedia.aspx.cs" Inherits="Resident.WebPage.AdminG.SocialMedia" %>

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
    <script src="https://kit.fontawesome.com/5f92b8c4a8.js"></script>
    <script>
        function CustvalSocial_ServerValidate(sender, args) {
            if (document.getElementById("<%=chkSocial.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }

        function alertMsgForSocial() {
            swal({
                title: 'Congratulations!',
                text: 'Successfully Inserted Data',
                type: 'success'
            });
        }

        function openSocialModal() {
            $('.addSocialMedia').modal('show');
        }

        function closeSocialModal() {
            $('.addSocialMedia').modal('hide');
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="container">
            <div class="row">
                <div class="col-sm-2"></div>

                <div class="col-sm-8">
                    <div class="card">
                        <div class="card-body" runat="server">
                            <div class="row">
                                <div class="col-md-12">
                                    <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:Repeater ID="RepSMList" runat="server" DataSourceID="SqlRepRepSMList">
                                                <ItemTemplate>
                                                    <asp:HiddenField ID="hdnSocialId" runat="server" Value='<%# Eval("Id") %>' />
                                                    <asp:HiddenField ID="hdnName" runat="server" Value='<%# Eval("Name") %>' />
                                                    <asp:HiddenField ID="hdnIcon" runat="server" Value='<%# Eval("Icon") %>' />

                                                    <asp:LinkButton ID="lbtnIcon" runat="server" ForeColor="Crimson" OnClick="lbtnIcon_Click">
                                                        <i class='<%# Eval("Icon") %>' runat="server" id="iIcon"></i><%# Eval("Icon") %>
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepSMList.Items.Count == 0).ToString()) %>'>
                                                        <li class="list-group-item  list-group-item-light small">No record listed as of now!
                                                        </li>
                                                    </ul>
                                                </FooterTemplate>
                                            </asp:Repeater>
                                            <asp:SqlDataSource runat="server" ID="SqlRepRepSMList" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                SelectCommand="SELECT [Id], [Name], [Icon] FROM [SocialMediaList] WHERE IsDel=0"></asp:SqlDataSource>
                                            <br />
                                            <br />

                                            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemDataBound="Repeater1_ItemDataBound">
                                                <ItemTemplate>
                                                    <div class="card">
                                                        <div class="card-body">
                                                           <%-- <asp:Label ID="lbl" runat="server" Text='<%# Eval("Color") %>'></asp:Label>
                                                            <a href='<%# Eval("Email") %>' id="lnk" runat="server"><%# Eval("Email") %></a>--%>
                                                            <a href='<%# "mailto:"+ Eval("Color") %>' runat="server"><%# Eval("Color") %></a>
                                                            <asp:HyperLink ID="lnkColor" runat="server" NavigateUrl='<%# Eval("Color") %>' Text='<%# Eval("Color") %>'>
                                                            </asp:HyperLink>
                                                            
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((Repeater1.Items.Count == 0).ToString()) %>'>
                                                        <li class="list-group-item  list-group-item-light small">No record listed as of now!
                                                        </li>
                                                    </ul>
                                                </FooterTemplate>
                                            </asp:Repeater>
                                            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                SelectCommand="SELECT DISTINCT p.Name,
                                                                  STUFF((SELECT distinct ',' + p1.[NameAlt]
                                                                         FROM RulerCat p1
                                                                         WHERE p.Name = p1.Name
                                                                            FOR XML PATH(''), TYPE
                                                                            ).value('.', 'NVARCHAR(MAX)')
                                                                        ,1,1,'') Color
                                                                FROM RulerCat p;"></asp:SqlDataSource>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-2"></div>

            </div>
        </div>

        <div class="modal fade addSocialMedia" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="alert alert-light fade show mb-0" role="alert">

                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>

                        <h6 class="alert-heading">Warning!</h6>
                        <%-- <p>
                           <i class="fas fa-exclamation-triangle text-danger mr-1"></i> Are you want to remove from current list?
                        </p>--%>
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <asp:HiddenField ID="hdnSocialPixel" runat="server" />
                                <asp:HiddenField ID="hdnSocialName" runat="server" />
                                <asp:HiddenField ID="hdnSocialIcon" runat="server" />
                                <div class="form-group m-2px">
                                    <asp:Label AssociatedControlID="txtLink" runat="server" Text="Link: *" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                    <asp:TextBox ID="txtLink" runat="server" Placeholder="... enter a link" CssClass="form-control form-control-sm"></asp:TextBox>
                                    <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtLink"
                                        runat="server" Display="Dynamic" ValidationGroup="valSocial" Font-Size="XX-Small" SetFocusOnError="true" />
                                </div>

                                <div class="form-group m-2px">
                                    <asp:Label AssociatedControlID="txtDescr" runat="server" Text="Description" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                    <asp:TextBox ID="txtDescr" runat="server" Placeholder="... enter a description" CssClass="form-control form-control-sm" TextMode="MultiLine"></asp:TextBox>
                                </div>

                                <div class="custom-control custom-checkbox m-1">
                                    <input type="checkbox" class="custom-control-input" id="chkSocial" runat="server" clientidmode="static" />
                                    <label class="custom-control-label" for="chkSocial">Terms And Condition</label>
                                </div>

                                <div>
                                    <asp:CustomValidator runat="server" ID="CustvalSocial" EnableClientScript="true"
                                        Display="Dynamic" Font-Size="X-Small" ForeColor="Crimson"
                                        ValidationGroup="valSocial" OnServerValidate="CustvalSocial_ServerValidate"
                                        ErrorMessage="* Required" ClientValidationFunction="CustvalSocial_ClientValidate"></asp:CustomValidator>
                                </div>

                                <asp:Label ID="lblErroMsg" runat="server" ForeColor="Crimson" Font-Size="Small" Visible="false">
                                                                    <i class="fas fa-exclamation-triangle mr-1"></i> Failed to submit data. Please try again
                                </asp:Label>


                                <asp:LinkButton ID="lbtnSocialSubmit" runat="server"
                                    CssClass="btn btn-outline-success btn-sm " OnClick="lbtnSocialSubmit_Click">
                                                                        Submit
                                </asp:LinkButton>

                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
