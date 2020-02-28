<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ComplexDetails.aspx.cs" Inherits="Resident.WebPage.AdminG.ComplexDetails" %>

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
    <script src="<%=ResolveUrl("~/ScriptsProject/ComplexDetails.js")%>"></script>
    <script>
        function CustValPO_I_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkPO_I.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }
        function CustValPO_U_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkPO_U.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server"></asp:ScriptManager>
        <div class="container">
            <div class="row">
                <div class="col-md-2">
                </div>
                <div class="col-md-8 mb-0">
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="image-tab" data-toggle="tab" href="#image" role="tab" aria-controls="image" aria-selected="true">
                                <i class="far fa-image text-danger mr-1"></i>Image
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="postOffice-tab" data-toggle="tab" href="#postOffice" role="tab" aria-controls="postOffice" aria-selected="false">
                                <i class="fas fa-mail-bulk text-danger mr-1"></i>Post Office
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="policeStation-tab" data-toggle="tab" href="#policeStation" role="tab" aria-controls="policeStation" aria-selected="false">
                                <i class="fas fa-user-shield text-danger mr-1"></i>Police Station
                            </a>
                        </li>
                    </ul>
                    <div class="tab-content mt-3" id="myTabContent">
                        <div class="tab-pane fade show active" id="image" role="tabpanel" aria-labelledby="image-tab">
                            <div class="text-center">
                                <asp:LinkButton ID="lbtnAddImage" runat="server" CssClass="btn btn-warning btn-sm mr-1" OnClick="lbtnAddImage_Click">
                                <i class="far fa-image text-danger mr-1"></i> Add Image</asp:LinkButton>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="postOffice" role="tabpanel" aria-labelledby="postOffice-tab">

                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <div class="text-center mb-2">
                                        <asp:LinkButton ID="lbtnAddPost" runat="server" CssClass="btn btn-warning btn-sm mr-1" OnClick="lbtnAddPost_Click">
                                <i class="fas fa-mail-bulk text-danger mr-1"></i> Add Post Office</asp:LinkButton>
                                    </div>

                                    <div id="divPostRepeater">
                                        <asp:HiddenField ID="hdnPixelPost" runat="server" />

                                        <asp:Repeater ID="RepPostOffice" runat="server" DataSourceID="SqlRepPostOffice">
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnPostId" runat="server" Value='<%# Eval("Id") %>' />
                                                <div class='<%#(Eval("IsDel")).ToString()!="True"? "card mt-1 mb-1 border-success":"card mt-1 mb-1 border-danger" %>'>
                                                    <div class="card">

                                                        <div class="card-body">
                                                            <h6 class="card-title m-0">
                                                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>' ForeColor="SaddleBrown" Font-Size="Smaller"></asp:Label>
                                                            </h6>

                                                            <div class="card-text m-0">
                                                                <div class="indent-text-30px line-hight-1p3">
                                                                    <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("Address") %>' Font-Size="13px" CssClass="text-justify"></asp:Label>
                                                                </div>
                                                                <div>
                                                                    <asp:Label ID="lblPostalCode" runat="server" Text='<%# Eval("PostalCode") %>' Font-Size="13px"></asp:Label>
                                                                </div>
                                                                <div>
                                                                    <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>' Font-Size="13px"></asp:Label>
                                                                </div>
                                                                <div>
                                                                    <asp:Label ID="lblWebsite" runat="server" Text='<%# Eval("Website") %>' Font-Size="13px"></asp:Label>
                                                                </div>
                                                                <div>
                                                                    <asp:Label ID="lblPhone1" runat="server" Text='<%# Eval("Phone1") %>' Font-Size="13px"></asp:Label>
                                                                </div>
                                                                <div>
                                                                    <asp:Label ID="lblPhone2" runat="server" Text='<%# Eval("Phone2") %>' Font-Size="13px"></asp:Label>
                                                                </div>
                                                                <div class="h6 mb-0">
                                                                    <asp:Label runat="server" class="text-muted" Font-Size="XX-Small"
                                                                        Text='<%# Eval("ModDt").ToString() =="" ? "Listed On: "+Eval("CrDt","{0:dd MMM yyyy hh:mm tt}"): "Updated On: "+Eval("ModDt", "{0:dd MMM yyyy hh:mm tt}") %>'>
                                                                        
                                                                    </asp:Label>
                                                                </div>

                                                                <div class="h6 mb-0">
                                                                    <asp:Label runat="server" class="text-danger" Font-Size="X-Small" Text="Removed from active display" Visible='<%# Eval("IsDel").ToString()=="True"?true:false %>'></asp:Label>

                                                                </div>
                                                            </div>

                                                            <asp:LinkButton ID="lbtnEditPO" CssClass="card-link text-primary small" runat="server" Visible='<%# Eval("IsDel").ToString()=="True"?false:true %>'
                                                                OnClick="lbtnEditPO_Click"><i class="far fa-edit"></i> Edit</asp:LinkButton>

                                                        </div>

                                                    </div>
                                                </div>

                                            </ItemTemplate>
                                            <FooterTemplate>

                                                <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepPostOffice.Items.Count == 0).ToString()) %>'>
                                                    <li class="list-group-item  list-group-item-light small"><i class="fas fa-exclamation-triangle mr-1"></i>No data fount!
                                                    </li>
                                                </ul>
                                            </FooterTemplate>
                                        </asp:Repeater>

                                        <asp:SqlDataSource runat="server" ID="SqlRepPostOffice" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                            SelectCommand="ComplexPO_Sel_ForRep" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:QueryStringParameter QueryStringField="ComplexId" Name="ComplexId"></asp:QueryStringParameter>
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>

                        <div class="tab-pane fade" id="policeStation" role="tabpanel" aria-labelledby="policeStation-tab">
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                </div>
            </div>
        </div>


        <div class="modal fade openattachimagemodal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content text-center">
                    <div class="alert alert-light fade show mb-0 p-2" role="alert">
                        <div class="p-1" style="background-image: -webkit-linear-gradient(left, rgba(244, 133, 125, 0.8), rgba(202, 202, 202, 0.6), rgba(0,0,0,0));">
                            <span class="alert-heading h6 small" style="font-weight: 600; color: black">Attach image to this paragraph !</span>
                            <span>
                                <button type="button" class="close text-danger" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;
                                    </span>

                                </button>
                            </span>
                        </div>
                        <ul class="nav nav-tabs mb-2 mt-2 text-center" id="imageDetailsTab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link nav-link-padding active btn-sm" id="upload-tab" data-toggle="tab" href="#upload" role="tab" aria-controls="upload" aria-selected="true">
                                    <i class="far fa-image mr-1 text-danger"></i>Upload image
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link nav-link-padding btn-sm" id="previmg-tab" data-toggle="tab" href="#previmg" role="tab" aria-controls="previmg" aria-selected="true">
                                    <i class="fas fa-sd-card text-danger mr-1"></i>Select from gallery</a>
                            </li>
                        </ul>
                        <div class="tab-content" id="imageDetailsTabContent">
                            <div class="tab-pane fade show active" id="upload" role="tabpanel" aria-labelledby="upload-tab">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <div id="divAddImage">
                                            <asp:HiddenField ID="hdnComplexId" runat="server" />
                                            <div class="card mt-2">
                                                <div class="card-body text-left">
                                                    <div class="form-group m-2px">
                                                        <asp:Label AssociatedControlID="fuImage" runat="server" Text="Image:" Font-Size="Small" ForeColor="SaddleBrown"></asp:Label>
                                                        <div class="custom-file">
                                                            <asp:FileUpload ID="fuImage" runat="server" accept="image/*" CssClass="custom-file-input image-complex" onchange="showPreviewForComplex(this); imgUploadForComplex();" />
                                                            <asp:Label AssociatedControlID="fuImage" CssClass="custom-file-label" runat="server">... choose an image file</asp:Label>
                                                        </div>
                                                        <progress class="progress-complex" style="display: none"></progress>

                                                        <div id="divImageComplexView" class="card div-image-complex-view" style="display: none" runat="server">
                                                            <div class="card-body" style="padding: .25rem">
                                                                <img id="imgpreview" width="50" class="rounded img-complex-preview" src="" style="border-width: 0px;" />
                                                                <asp:LinkButton ID="lbtnImageComplexRemove" CssClass="btn btn-link text-danger" runat="server" Font-Size="X-Small" OnClick="lbtnImageComplexRemove_Click"><i class="far fa-trash-alt"></i> Remove</asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <asp:RegularExpressionValidator runat="server" ControlToValidate="fuImage" ValidationExpression="^.+\.((jpg)|(JPG)|(gif)|(GIF)|(jpeg)|(JPEG)|(png)|(PNG)|(bmp)|(BMP))$"
                                                        ErrorMessage="Enter only (jpg, jpeg, bmp, png, gif)" Display="Dynamic" ForeColor="Crimson" Font-Size="XX-Small" ValidationGroup="vgrImage"></asp:RegularExpressionValidator>

                                                    <div class="form-group m-2px">
                                                        <div class="custom-control custom-checkbox m-1">
                                                            <input type="checkbox" class="custom-control-input" id="chkImg" runat="server" clientidmode="static" />
                                                            <label class="custom-control-label" for="chkImg">I declare that the contents posted by me are true to the best of my knowledge and belief.</label>
                                                        </div>

                                                        <asp:CustomValidator ID="CustValImg" runat="server" ErrorMessage="* Please check the responsibility clause." Display="Dynamic" OnServerValidate="CustValImg_ServerValidate"
                                                            ClientValidationFunction="CustValImg_ClientValidate" ValidationGroup="vgrImage" ForeColor="Crimson" Font-Size="XX-Small"></asp:CustomValidator>
                                                    </div>

                                                    <div class="form-group m-2px">
                                                        <asp:Label ID="lblErrorMsg" runat="server" Visible="false" CssClass="text-danger lbl-error-msg" Font-Size="X-Small">
                                                                <i class="fas fa-exclamation-triangle"></i> This image can't be uploded. Kindly select another image
                                                        </asp:Label>
                                                        <asp:Button ID="btnImageByFileSubmit" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm btn-sleek float-right" OnClick="btnImageByFileSubmit_Click" ValidationGroup="vgrImage" />
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>

                            <div class="tab-pane" id="previmg" role="tabpanel" aria-labelledby="previmg-tab">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <div id="divGalleryImage">
                                            <div class="card mt-2 border-0">
                                                <div class="card-body text-center p-2">
                                                </div>
                                            </div>
                                        </div>

                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="modal fade post-office-ins" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="alert alert-light fade show mb-0 p-2" role="alert">
                        <div class="p-1 bg-gradient">
                            <span class="alert-heading h6 small" style="font-weight: 600; color: black">Enter Post Office</span>
                            <span>
                                <button type="button" class="close text-danger" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;
                                    </span>
                                </button>
                            </span>
                        </div>

                        <div class="mt-1">

                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtNamePO_I" runat="server" Text="Post Office:" Font-Size="Small" CssClass="text-danger mb-0"></asp:Label>
                                        <asp:TextBox ID="txtNamePO_I" runat="server" Placeholder="...enter a post office name in your complex"
                                            CssClass="form-control form-control-sm" Font-Size="Small"></asp:TextBox>
                                        <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtNamePO_I" BackColor="Yellow"
                                            runat="server" Display="Dynamic" ValidationGroup="valPostOffice_I" Font-Size="XX-Small" SetFocusOnError="true" />
                                    </div>

                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtAddressPO_I" runat="server" Text="Address:" Font-Size="Small" CssClass="text-danger mb-0"></asp:Label>
                                        <asp:TextBox ID="txtAddressPO_I" runat="server" Placeholder="...enter a post office address" TextMode="MultiLine" Height="80"
                                            CssClass="form-control form-control-sm" Font-Size="Small" data-charcount="true" data-maxlen="250"></asp:TextBox>
                                        <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtAddressPO_I" BackColor="Yellow"
                                            runat="server" Display="Dynamic" ValidationGroup="valPostOffice_I" Font-Size="XX-Small" SetFocusOnError="true" />
                                    </div>

                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtPostalPO_I" runat="server" Text="Postal Code:" Font-Size="Small" CssClass="text-danger mb-0"></asp:Label>
                                        <asp:TextBox ID="txtPostalPO_I" runat="server" Placeholder="...enter postal code" MaxLength="6"
                                            CssClass="form-control form-control-sm number-only" Font-Size="Small"></asp:TextBox>
                                        <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtPostalPO_I" BackColor="Yellow"
                                            runat="server" Display="Dynamic" ValidationGroup="valPostOffice_I" Font-Size="XX-Small" SetFocusOnError="true" />
                                    </div>

                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtEmailPO_I" runat="server" Text="Email:" Font-Size="Small" CssClass="text-danger mb-0"></asp:Label>
                                        <asp:TextBox ID="txtEmailPO_I" runat="server" Placeholder="...enter an emailid"
                                            CssClass="form-control form-control-sm" Font-Size="Small"></asp:TextBox>
                                        <asp:RegularExpressionValidator runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                            ErrorMessage="Invalid Email Format" ForeColor="Crimson" ControlToValidate="txtEmailPO_I" BackColor="Yellow"
                                            Display="Dynamic" ValidationGroup="valPostOffice_I" Font-Size="XX-Small" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                    </div>

                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtWebsitePO_I" runat="server" Text="Website:" Font-Size="Small" CssClass="mb-0"></asp:Label>
                                        <asp:TextBox ID="txtWebsitePO_I" runat="server" Placeholder="...enter a website"
                                            CssClass="form-control form-control-sm" Font-Size="Small"></asp:TextBox>
                                        <asp:RegularExpressionValidator runat="server" ValidationExpression="(([\w]+:)?\/\/)?(([\d\w]|%[a-fA-f\d]{2,2})+(:([\d\w]|%[a-fA-f\d]{2,2})+)?@)?([\d\w][-\d\w]{0,253}[\d\w]\.)+[\w]{2,4}(:[\d]+)?(\/([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)*(\?(&?([-+_~.\d\w]|%[a-fA-f\d]{2,2})=?)*)?(#([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)?$"
                                            ErrorMessage="Website is Missing" ForeColor="Crimson" ControlToValidate="txtWebsitePO_I" BackColor="Yellow"
                                            Display="Dynamic" ValidationGroup="valPostOffice_I" Font-Size="XX-Small" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                    </div>

                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtPhone1PO_I" runat="server" Text="Phone:" Font-Size="Small" CssClass="mb-0"></asp:Label>
                                        <asp:TextBox ID="txtPhone1PO_I" runat="server" Placeholder="...enter an phone number"
                                            CssClass="form-control form-control-sm" Font-Size="Small"></asp:TextBox>
                                    </div>

                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtPhone2PO_I" runat="server" Text="Phone:" Font-Size="Small" CssClass="mb-0"></asp:Label>
                                        <asp:TextBox ID="txtPhone2PO_I" runat="server" Placeholder="...enter an phone number"
                                            CssClass="form-control form-control-sm" Font-Size="Small"></asp:TextBox>
                                    </div>

                                    <div class="custom-control custom-checkbox m-1">
                                        <input type="checkbox" class="custom-control-input" id="chkPO_I" runat="server" clientidmode="static" />
                                        <label class="custom-control-label" for="chkPO_I">I declare that the contents posted by me are true to the best of my knowledge and belief.</label>
                                    </div>

                                    <div>
                                        <asp:CustomValidator runat="server" ID="CustValPO_I" EnableClientScript="true" BackColor="Yellow"
                                            Display="Dynamic" Font-Size="XX-Small" ForeColor="Crimson"
                                            ValidationGroup="valPostOffice_I" OnServerValidate="CustValPO_I_ServerValidate"
                                            ClientValidationFunction="CustValPO_I_ClientValidate" ErrorMessage="* Required"></asp:CustomValidator>
                                    </div>

                                    <div class="form-group m-2px">
                                        <asp:Label ID="lblErrorMsgPO_I" runat="server" Visible="false" CssClass="text-danger lbl-error-msg" Font-Size="X-Small">
                                                                <i class="fas fa-exclamation-triangle"></i> The data failed to upload. Kindly try again
                                        </asp:Label>
                                    </div>

                                    <div class="form-group m-2px">
                                        <asp:Button ID="btnSubmitPO_I" runat="server" CssClass="btn btn-outline-success btn-sm" Text="Submit" ValidationGroup="valPostOffice_I" OnClick="btnSubmitPO_I_Click" />
                                        <asp:Button ID="btnCancelPO_I" runat="server" CssClass="btn btn-outline-danger btn-sm" Text="Cancel" ValidationGroup="valPostOffice_I" OnClick="btnCancelPO_I_Click" />

                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade post-office-upd" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="alert alert-light fade show mb-0 p-2" role="alert">
                        <div class="p-1 bg-gradient">
                            <span class="alert-heading h6 small" style="font-weight: 600; color: black">Enter Post Office</span>
                            <span>
                                <button type="button" class="close text-danger" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;
                                    </span>
                                </button>
                            </span>
                        </div>

                        <div class="mt-1">

                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtNamePO_U" runat="server" Text="Post Office:" Font-Size="Small" CssClass="text-danger mb-0"></asp:Label>
                                        <asp:TextBox ID="txtNamePO_U" runat="server" Placeholder="...enter a post office name in your complex"
                                            CssClass="form-control form-control-sm" Font-Size="Small"></asp:TextBox>
                                        <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtNamePO_U" BackColor="Yellow"
                                            runat="server" Display="Dynamic" ValidationGroup="valPostOffice_U" Font-Size="XX-Small" SetFocusOnError="true" />
                                    </div>

                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtAddressPO_U" runat="server" Text="Address:" Font-Size="Small" CssClass="text-danger mb-0"></asp:Label>
                                        <asp:TextBox ID="txtAddressPO_U" runat="server" Placeholder="...enter a post office address" TextMode="MultiLine" Height="80"
                                            CssClass="form-control form-control-sm" Font-Size="Small" data-charcount="true" data-maxlen="250"></asp:TextBox>
                                        <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtAddressPO_U" BackColor="Yellow"
                                            runat="server" Display="Dynamic" ValidationGroup="valPostOffice_U" Font-Size="XX-Small" SetFocusOnError="true" />
                                    </div>

                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtPostalPO_U" runat="server" Text="Postal Code:" Font-Size="Small" CssClass="text-danger mb-0"></asp:Label>
                                        <asp:TextBox ID="txtPostalPO_U" runat="server" Placeholder="...enter postal code" MaxLength="6"
                                            CssClass="form-control form-control-sm number-only" Font-Size="Small"></asp:TextBox>
                                        <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtPostalPO_U" BackColor="Yellow"
                                            runat="server" Display="Dynamic" ValidationGroup="valPostOffice_U" Font-Size="XX-Small" SetFocusOnError="true" />
                                    </div>

                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtEmailPO_U" runat="server" Text="Email:" Font-Size="Small" CssClass="text-danger mb-0"></asp:Label>
                                        <asp:TextBox ID="txtEmailPO_U" runat="server" Placeholder="...enter an emailid"
                                            CssClass="form-control form-control-sm" Font-Size="Small"></asp:TextBox>
                                        <asp:RegularExpressionValidator runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                            ErrorMessage="Invalid Email Format" ForeColor="Crimson" ControlToValidate="txtEmailPO_U" BackColor="Yellow"
                                            Display="Dynamic" ValidationGroup="valPostOffice_U" Font-Size="XX-Small" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                    </div>

                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtWebsitePO_U" runat="server" Text="Website:" Font-Size="Small" CssClass="mb-0"></asp:Label>
                                        <asp:TextBox ID="txtWebsitePO_U" runat="server" Placeholder="...enter a website"
                                            CssClass="form-control form-control-sm" Font-Size="Small"></asp:TextBox>
                                        <asp:RegularExpressionValidator runat="server" ValidationExpression="(([\w]+:)?\/\/)?(([\d\w]|%[a-fA-f\d]{2,2})+(:([\d\w]|%[a-fA-f\d]{2,2})+)?@)?([\d\w][-\d\w]{0,253}[\d\w]\.)+[\w]{2,4}(:[\d]+)?(\/([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)*(\?(&?([-+_~.\d\w]|%[a-fA-f\d]{2,2})=?)*)?(#([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)?$"
                                            ErrorMessage="Website is Missing" ForeColor="Crimson" ControlToValidate="txtWebsitePO_U" BackColor="Yellow"
                                            Display="Dynamic" ValidationGroup="valPostOffice_U" Font-Size="XX-Small" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                    </div>

                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtPhone1PO_U" runat="server" Text="Phone:" Font-Size="Small" CssClass="mb-0"></asp:Label>
                                        <asp:TextBox ID="txtPhone1PO_U" runat="server" Placeholder="...enter an phone number"
                                            CssClass="form-control form-control-sm" Font-Size="Small"></asp:TextBox>
                                    </div>

                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtPhone2PO_U" runat="server" Text="Phone:" Font-Size="Small" CssClass="mb-0"></asp:Label>
                                        <asp:TextBox ID="txtPhone2PO_U" runat="server" Placeholder="...enter an phone number"
                                            CssClass="form-control form-control-sm" Font-Size="Small"></asp:TextBox>
                                    </div>

                                    <div class="custom-control custom-checkbox m-1">
                                        <input type="checkbox" class="custom-control-input" id="chkPO_U" runat="server" clientidmode="static" />
                                        <label class="custom-control-label" for="chkPO_U">I declare that the contents posted by me are true to the best of my knowledge and belief.</label>
                                    </div>

                                    <div>
                                        <asp:CustomValidator runat="server" ID="CustValPO_U" EnableClientScript="true"
                                            Display="Dynamic" Font-Size="XX-Small" ForeColor="Crimson"
                                            ValidationGroup="valPostOffice_U" OnServerValidate="CustValPO_U_ServerValidate" BackColor="Yellow"
                                            ClientValidationFunction="CustValPO_U_ClientValidate" ErrorMessage="* Required"></asp:CustomValidator>
                                    </div>

                                    <div class="form-group m-2px">
                                        <asp:Label ID="lblErrorMsgPO_U" runat="server" Visible="false" CssClass="text-danger lbl-error-msg" Font-Size="X-Small">
                                                                <i class="fas fa-exclamation-triangle"></i> The data failed to upload. Kindly try again
                                        </asp:Label>
                                    </div>

                                    <div class="form-group m-2px">
                                        <asp:Button ID="btnSubmitPO_U" runat="server" CssClass="btn btn-outline-success btn-sm" Text="Submit" ValidationGroup="valPostOffice_U" OnClick="btnSubmitPO_U_Click" />
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>

                        </div>
                    </div>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
