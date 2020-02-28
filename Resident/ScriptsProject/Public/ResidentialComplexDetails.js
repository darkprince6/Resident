$(document).ready(function () {
    largeImage();
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (evt, args) {
        largeImage();
    });
});

//Enlarge Zoom on tooltip
function largeImage() {
    $(".img-large").tooltip({
        track: true,
        delay: 0,
        showURL: false,
        fade: 500,
        bodyHandler: function () {
            return $($(this).next().html());
        },
        showURL: false
    });
}