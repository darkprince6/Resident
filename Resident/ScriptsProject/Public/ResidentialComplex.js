$(document).ready(function () {
    checking();
    GetComplex();
    //GetComplex2();
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (evt, args) {
        checking();
        GetComplex();
        //GetComplex2();
    });
});


function GetComplex2() {
    $("#txtResCom").autocomplete({
        source: function (request, response) {
            $.ajax({
                url: "WebPage/Service/Complex.asmx/GetComplex",
                data: "{ 'prefix': '" + request.term + "'}",
                dataType: "JSON",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d.length > 0) {
                        response($.map(data.d, function (item) {
                            return {
                                label: item.split('-')[0],
                                val: item.split('-')[1]
                            }
                        }))
                    } else {
                        //If no records found, set the default "No match found" item with value -1.
                        response([{ label: 'No results found.', val: -1 }]);
                    }
                },
                error: function (response) {
                    alert(response.responseText);
                },
                failure: function (response) {
                    alert(response.responseText);
                }
            });
        },
        select: function (e, i) {
            if (i.item.val === -1) {
                //Clear the AutoComplete TextBox.
                $(this).val("");
                return false;
            }
            else {
                $("#hdnResCom").val(i.item.val);
            }
        },
        minLength: 1
    });
}


function GetComplex() {
    highlightAutoComplete();
    $("#txtResCom").autocomplete({
        highlightClass: "bold-text",
        source: function (request, response) {
            $.ajax({
                url: "../../WebPage/Service/Complex.asmx/GetComplex",
                data: "{ 'prefix': '" + request.term + "','countryid':'" + $("#ddlC option:selected").val() +"'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                autoFocus: true,
                success: function (data) {
                    if (data.d.length > 0) {
                        response($.map(data.d, function (item) {
                            return {
                                label: item.split('-')[0],
                                val: item.split('-')[1]
                            };
                        }));
                        $("#hlSubmit").removeAttr("href", false);
                        $("#hlSubmit").removeClass("disabled", true);
                    } else {
                        //If no records found, set the default "No match found" item with value -1.
                        response([{ label: 'No results found.', val: -1 }]);
                        $("#hdnResCom").val("");
                        $("#hlSubmit").removeAttr("href", false);
                        $("#hlSubmit").addClass("disabled", false);
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
                $("#hlSubmit").removeAttr("href", false);
                $("#hlSubmit").addClass("disabled", false);
                return false;
            }
            else {

                $("#hdnResCom").val(i.item.val);
                var _complexId = i.item.val;
                var _complexName = i.item.label.replace(/\s/g, '-');
                $("#hlSubmit").attr("href", "Complex/" + _complexName + "/" + _complexId);
                $("#hlSubmit").removeClass("disabled", true);


            }
        },
        minLength: 2
    });
}

function checking() {
    $('#txtResCom').keyup(function () {
        if ($(this).val() === '') {
            $("#hlSubmit").removeAttr("href", false);
            $("#hlSubmit").addClass("disabled", false);
        }
    });
    $('#txtResCom').on('#txtResCom propertychange cut', function () {
        $("#hlSubmit").removeAttr("href", false);
        $("#hlSubmit").addClass("disabled", false);
    });
}

function highlightAutoComplete() {
    $.widget("app.autocomplete", $.ui.autocomplete, {
        // Which class get's applied to matched text in the menu items.
        options: {
            highlightClass: "ui-state-highlight"
        },
        _renderItem: function (ul, item) {

            // Replace the matched text with a custom span. This
            // span uses the class found in the "highlightClass" option.
            var re = new RegExp("(" + this.term + ")", "gi"),
                cls = this.options.highlightClass,
                template = "<span class='" + cls + "'>$1</span>",
                label = item.label.replace(re, template),
                $li = $("<li/>").appendTo(ul);

            // Create and return the custom menu item content.
            $("<span/>").attr("href", "#")
                .html(label)
                .appendTo($li);

            return $li;
        }
    });
}