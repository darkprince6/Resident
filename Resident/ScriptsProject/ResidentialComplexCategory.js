$(document).ready(function () {
    numberOnly();
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (evt, args) {
        numberOnly();
    });
});


function numberOnly() {
    $(".input-number").keypress(function (e) {
        //if the letter is not digit then display error and don't type anything
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            //display error message
            $(".errmsg").html("Digits only").show().fadeOut("slow");
            return false;
        }
    });
}