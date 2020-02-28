$(document).ready(function () {
    datepicker();
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (evt, args) {
        datepicker();
    });
});

function datepicker() {

    $(".date-picker").datepicker({
        changeMonth: true,
        changeYear: true,
        yearRange: '-70:+0',
        maxDate: new Date(),
        dateFormat: 'dd M yy'
    }).val();
}