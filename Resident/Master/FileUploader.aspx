<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Public.master" AutoEventWireup="true" CodeBehind="FileUploader.aspx.cs" Inherits="Resident.Master.FileUploader" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cp1" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/exif-js/2.3.0/exif.js"></script>
    <style>
        .rotate-90 {
            -moz-transform: rotate(90deg);
            -webkit-transform: rotate(90deg);
            -o-transform: rotate(90deg);
            transform: rotate(90deg);
        }

        .rotate-180 {
            -moz-transform: rotate(180deg);
            -webkit-transform: rotate(180deg);
            -o-transform: rotate(180deg);
            transform: rotate(180deg);
        }

        .rotate-270 {
            -moz-transform: rotate(270deg);
            -webkit-transform: rotate(270deg);
            -o-transform: rotate(270deg);
            transform: rotate(270deg);
        }

        .flip {
            -moz-transform: scaleX(-1);
            -webkit-transform: scaleX(-1);
            -o-transform: scaleX(-1);
            transform: scaleX(-1);
        }

        .flip-and-rotate-90 {
            -moz-transform: rotate(90deg) scaleX(-1);
            -webkit-transform: rotate(90deg) scaleX(-1);
            -o-transform: rotate(90deg) scaleX(-1);
            transform: rotate(90deg) scaleX(-1);
        }

        .flip-and-rotate-180 {
            -moz-transform: rotate(180deg) scaleX(-1);
            -webkit-transform: rotate(180deg) scaleX(-1);
            -o-transform: rotate(180deg) scaleX(-1);
            transform: rotate(180deg) scaleX(-1);
        }

        .flip-and-rotate-270 {
            -moz-transform: rotate(270deg) scaleX(-1);
            -webkit-transform: rotate(270deg) scaleX(-1);
            -o-transform: rotate(270deg) scaleX(-1);
            transform: rotate(270deg) scaleX(-1);
        }
    </style>
    <div class="container">
        <div class="row">
            <div class="col-sm-2"></div>
            <div class="col-sm-8">
                <div class="card">
                    <div class="card-body">
                        <div class="form-group">
                            <div class="custom-file">
                                <input type="file" class="custom-file-input" id="customFile">
                                <label class="custom-file-label" for="customFile">Choose file</label>
                            </div>
                        </div>
                        <div class="form-group" style="display: none" id="divImgPreview">
                            <img id="imgUser" src="#" width="100" class="img-thumbnail" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-2"></div>

        </div>
    </div>
    <script>
        $(document).ready(function () {
            $(".custom-file-input").on("change", function () {
                var fileName = $(this).val().split("\\").pop();
                $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
            });

            $("#customFile").change(function () {
                readURLimg(this);
            });
        });
        function readURLimg(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    var img = $('#imgUser')
                    img.attr('src', e.target.result).width('50%').height('auto');
                    fixExifOrientation(img)
                    $('#divImgPreview').show();
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
        function fixExifOrientation($img) {
            $img.on('load', function () {
                EXIF.getData($img[0], function () {
                    console.log('Exif=', EXIF.getTag(this, "Orientation"));
                    switch (parseInt(EXIF.getTag(this, "Orientation"))) {
                        case 1:
                            alert("error");
                        case 2:
                            $img.addClass('flip'); break;
                        case 3:
                            $img.addClass('rotate-180'); break;
                        case 4:
                            $img.addClass('flip-and-rotate-180'); break;
                        case 5:
                            $img.addClass('flip-and-rotate-270'); break;
                        case 6:
                            $img.addClass('rotate-90'); break;
                        case 7:
                            $img.addClass('flip-and-rotate-90'); break;
                        case 8:
                            $img.addClass('rotate-270'); break;
                    }
                });
            });
        }
    </script>
</asp:Content>
