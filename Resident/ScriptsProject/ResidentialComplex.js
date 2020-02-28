

$(document).ready(function () {
    numberOnly();
    datepicker();
    uploader();
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (evt, args) {
        numberOnly();
        datepicker();
        uploader();
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

function datepicker() {
    
    $(".date-picker").datepicker({
        changeMonth: true,
        changeYear: true,
        yearRange: '-70:+0', 
        maxDate: new Date(),
        dateFormat: 'dd M yy'
    }).val();
}
function uploader() {
    $('.custom-file-input').on('change', function () {
        //get the file name
        var fileName = $(this).val();
        //replace the "Choose a file" label
        fileName = fileName.replace("C:\\fakepath\\", "");
        if (fileName != '') {
            $(this).next('.custom-file-label').html(fileName);
        }
        else {
            $(this).next('.custom-file-label').html("Choose File");
        }
    });
}
