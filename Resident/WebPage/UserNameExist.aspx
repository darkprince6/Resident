<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserNameExist.aspx.cs" Inherits="Resident.WebPage.UserNameExist" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/notify/0.4.2/notify.js"></script>
    <script src="https://kit.fontawesome.com/5f92b8c4a8.js"></script>
    <style>
        .checkmark__circle {
            stroke-dasharray: 166;
            stroke-dashoffset: 166;
            stroke-width: 2;
            stroke-miterlimit: 10;
            stroke: #7ac142;
            fill: none;
            animation: stroke 0.6s cubic-bezier(0.65, 0, 0.45, 1) forwards;
        }

        .checkmark {
            width: 18px;
            height: 18px;
            border-radius: 50%;
            display: block;
            stroke-width: 6;
            stroke: #fff;
            stroke-miterlimit: 10;
            margin: 10% auto;
            box-shadow: inset 0px 0px 0px #7ac142;
            animation: fill .4s ease-in-out .4s forwards, scale .3s ease-in-out .9s both;
        }

        .checkmark__check {
            transform-origin: 50% 50%;
            stroke-dasharray: 48;
            stroke-dashoffset: 48;
            animation: stroke 0.3s cubic-bezier(0.65, 0, 0.45, 1) 0.8s forwards;
        }

        @keyframes stroke {
            100% {
                stroke-dashoffset: 0;
            }
        }

        @keyframes scale {
            0%, 100% {
                transform: none;
            }

            50% {
                transform: scale3d(1.1, 1.1, 1);
            }
        }

        @keyframes fill {
            100% {
                box-shadow: inset 0px 0px 0px 30px #7ac142;
            }
        }
    </style>
    <script>
        $(document).ready(function () {

            $('.txtCrux').keyup(function () {
                var userName = $(this).val();
                var divElement = $('.divUserCheckAlert');
                var divIcon = $('.checkmark');
                var complexId = 1;

                if (userName.length >= 3) {
                    $.ajax({
                        url: '/Services/UserExist.asmx/UserNameExists',
                        method: 'post',
                        data: { userName: userName, complexId:complexId },
                        dataType: 'json',
                        success: function (data) {
                            if (data.UserNameInUse == "Matched") {
                                divElement.removeClass('alert-danger');
                                divElement.html("<strong> <i class='fas fa-check-circle mr-1'></i>" + data.UserName + "!</strong> matched")
                                divElement.addClass('alert-success');
                                divElement.fadeIn();
                                divIcon.fadeIn();

                                $('.txtCrux').css('border-color', '#28a745');
                                $('.txtCrux').css('box-shadow', '0 0 0 0.2rem rgba(40, 167, 69, 0.25)');
                                $(".txtCrux:focus").css('border-color', '28a745');
                            }
                            else if (data.UserNameInUse == "Not-Matched") {
                                divElement.removeClass('alert-success');
                                divElement.html("<strong> <i class='fas fa-times-circle mr-1'></i>" + data.UserName + "!</strong> not matched")
                                divElement.addClass('alert-danger');
                                divElement.fadeIn();
                                divIcon.fadeOut();

                                $('.txtCrux').css('border-color', '#FF0000');
                                $('.txtCrux').css('box-shadow', 'inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 8px rgba(255, 0, 0, 0.6)');
                            }
                            else {
                                divElement.removeClass('alert-success');
                                divElement.html("<strong> <i class='fas fa-times-circle mr-1'></i>" + data.UserName + "!</strong> already use")
                                divElement.addClass('alert-danger');
                                divElement.fadeIn();
                                divIcon.fadeOut();

                                $('.txtCrux').css('border-color', '#FF0000');
                                $('.txtCrux').css('box-shadow', 'inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 8px rgba(255, 0, 0, 0.6)');
                            }
                        },
                        error: function (err) {
                            console.log(err);
                        }
                    });
                }
                else {
                    divElement.fadeOut();
                    divIcon.fadeOut();
                    $('.txtCrux').css('border-color', '#6265e4 ');
                    $('.txtCrux').css('box-shadow', '0 0 5px rgba(98, 101, 228, 1)');

                }
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div>
            <div class="row mt-3" style="min-height: 700px">
                <div class="col-sm-2">
                </div>
                <div class="col-sm-8">
                    <div class="card bg-white">
                        <div class="card-header text-white" style="padding: .75rem 1.25rem; background-color: #899097">
                            <h6>User Exist Check</h6>
                        </div>
                        <div class="card-body">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Label AssociatedControlID="txtCrux" runat="server" Text="User ID:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>

                                    <div class="input-group input-group-sm mb-2">
                                        <asp:TextBox ID="txtCrux" runat="server" Placeholder="... enter a user Name" CssClass="form-control form-control-sm txtCrux">
                                        </asp:TextBox>
                                        <div class="input-group-append divIcon">
                                            <span class="input-group-text bg-white text-success border-0">
                                                <%--<i class="fas fa-user-check"></i>--%>
                                                <svg class="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52" style="display:none">
                                                    <circle class="checkmark__circle" cx="26" cy="26" r="25" fill="none"/>
                                                    <path class="checkmark__check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/></svg>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="divUserCheckAlert p-1 mb-1 border-0 alert" style="font-size: 10px">
                                    </div>
                                    <a href="../Image/alert.svg">Avik Mondal is a good boy</a>
                                    <div class="form-group m-2px">
                                        <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-outline-dark btn-sm" Text="Submit" OnClick="btnSubmit_Click" />
                                    </div>


                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>

                <div class="col-sm-2">
                </div>
            </div>
        </div>
    </form>
</body>
</html>
