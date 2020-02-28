$(document).ready(function () {
    numberOnly();
    datepicker();
    uploader();
    GetOB();
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (evt, args) {
        numberOnly();
        datepicker();
        uploader();
        GetOB();
    });
});

function numberOnly() {
    $(".input-number").keypress(function (e) {
        //if the letter is not digit then display error and don't type anything
        if (e.which !== 8 && e.which !== 0 && (e.which < 48 || e.which > 57)) {
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
        if (fileName !== '') {
            $(this).next('.custom-file-label').html(fileName);
        }
        else {
            $(this).next('.custom-file-label').html("Choose File");
        }
    });
}

function GetOB() {
    //highlightAutoComplete();
    $(".txt-OB").autocomplete({
       // highlightClass: "bold-text",
        source: function (request, response) {
            $.ajax({
                url: "../../WebPage/Service/Complex.asmx/GetOB",
                data: "{ 'prefix': '" + request.term + "','complexid':'1'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                autoFocus: true,
                success: function (data) {
                    if (data.d.length > 0) {
                        response($.map(data.d, function (item) {
                            return {
                                label: item.split('-')[0],
                                val: item.split('-')[1],
                                value: item.split('-')[3]
                            };
                        }));
                      
                    } else {
                        //If no records found, set the default "No match found" item with value -1.
                        response([{ label: 'No results found.', val: -1 }]);
                       
                    }
                }
                ,
                error: function (response) {
                    alert(response.responseText);
                },
                failure: function (response) {
                    alert(response.responseText);
                }
            });
        },
        select: function (e, i) {
            if (i.item.val === -1 || i.item.label === null) {
                //Clear the AutoComplete TextBox.
                $(this).val("");
                return false;
            }
        },
        minLength: 2
    });
}
