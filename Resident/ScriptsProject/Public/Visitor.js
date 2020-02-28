$(document).ready(function () {

    //#region DateFormat
    var dateFormat = function () {
        var token = /d{1,4}|m{1,4}|yy(?:yy)?|([HhMsTt])\1?|[LloSZ]|"[^"]*"|'[^']*'/g,
            timezone = /\b(?:[PMCEA][SDP]T|(?:Pacific|Mountain|Central|Eastern|Atlantic) (?:Standard|Daylight|Prevailing) Time|(?:GMT|UTC)(?:[-+]\d{4})?)\b/g,
            timezoneClip = /[^-+\dA-Z]/g,
            pad = function (val, len) {
                val = String(val);
                len = len || 2;
                while (val.length < len) val = "0" + val;
                return val;
            };

        // Regexes and supporting functions are cached through closure
        return function (date, mask, utc) {
            var dF = dateFormat;

            // You can't provide utc if you skip other args (use the "UTC:" mask prefix)
            if (arguments.length === 1 && Object.prototype.toString.call(date) === "[object String]" && !/\d/.test(date)) {
                mask = date;
                date = undefined;
            }

            // Passing date through Date applies Date.parse, if necessary
            date = date ? new Date(date) : new Date;
            if (isNaN(date)) throw SyntaxError("invalid date");

            mask = String(dF.masks[mask] || mask || dF.masks["default"]);

            // Allow setting the utc argument via the mask
            if (mask.slice(0, 4) === "UTC:") {
                mask = mask.slice(4);
                utc = true;
            }

            var _ = utc ? "getUTC" : "get",
                d = date[_ + "Date"](),
                D = date[_ + "Day"](),
                m = date[_ + "Month"](),
                y = date[_ + "FullYear"](),
                H = date[_ + "Hours"](),
                M = date[_ + "Minutes"](),
                s = date[_ + "Seconds"](),
                L = date[_ + "Milliseconds"](),
                o = utc ? 0 : date.getTimezoneOffset(),
                flags = {
                    d: d,
                    dd: pad(d),
                    ddd: dF.i18n.dayNames[D],
                    dddd: dF.i18n.dayNames[D + 7],
                    m: m + 1,
                    mm: pad(m + 1),
                    mmm: dF.i18n.monthNames[m],
                    mmmm: dF.i18n.monthNames[m + 12],
                    yy: String(y).slice(2),
                    yyyy: y,
                    h: H % 12 || 12,
                    hh: pad(H % 12 || 12),
                    H: H,
                    HH: pad(H),
                    M: M,
                    MM: pad(M),
                    s: s,
                    ss: pad(s),
                    l: pad(L, 3),
                    L: pad(L > 99 ? Math.round(L / 10) : L),
                    t: H < 12 ? "a" : "p",
                    tt: H < 12 ? "am" : "pm",
                    T: H < 12 ? "A" : "P",
                    TT: H < 12 ? "AM" : "PM",
                    Z: utc ? "UTC" : (String(date).match(timezone) || [""]).pop().replace(timezoneClip, ""),
                    o: (o > 0 ? "-" : "+") + pad(Math.floor(Math.abs(o) / 60) * 100 + Math.abs(o) % 60, 4),
                    S: ["th", "st", "nd", "rd"][d % 10 > 3 ? 0 : (d % 100 - d % 10 !== 10) * d % 10]
                };

            return mask.replace(token, function ($0) {
                return $0 in flags ? flags[$0] : $0.slice(1, $0.length - 1);
            });
        };
    }();

    // Some common format strings
    dateFormat.masks = {
        "default": "ddd mmm dd yyyy HH:MM:ss",
        shortDate: "m/d/yy",
        mediumDate: "mmm d, yyyy",
        longDate: "mmmm d, yyyy",
        fullDate: "dddd, mmmm d, yyyy",
        shortTime: "h:MM TT",
        mediumTime: "h:MM:ss TT",
        longTime: "h:MM:ss TT Z",
        isoDate: "yyyy-mm-dd",
        isoTime: "HH:MM:ss",
        isoDateTime: "yyyy-mm-dd'T'HH:MM:ss",
        isoUtcDateTime: "UTC:yyyy-mm-dd'T'HH:MM:ss'Z'"
    };

    // Internationalization strings
    dateFormat.i18n = {
        dayNames: [
            "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat",
            "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
        ],
        monthNames: [
            "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
            "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"
        ]
    };

    // For convenience...
    Date.prototype.format = function (mask, utc) {
        return dateFormat(this, mask, utc);
    };

    //#endregion 

    //#region Select
    var pageIndex = 1;
    var pageCount;
    var IsNoMoreImages = false;
    // var repUtilityEmail;
    $(window).scroll(function () {
        //if ($(window).scrollTop() == $(document).height() - $(window).height()) {
        if (!IsNoMoreImages) {
            if ($(window).scrollTop() + $(window).innerHeight() >= $(document).height() - 100) {
                $(".loader").show().delay(1000).queue(function () {
                    GetRecords();
                    $(this).dequeue();
                    $(".loader").hide();
                });
            }
        }

    });
    function GetRecords() {
        pageIndex++;
        if (pageIndex === 2 || pageIndex <= pageCount) {
            $(".loader").show();
            $.ajax({
                type: "POST",
                url: "Visitor.aspx/GetVisitor",
                data: '{pageIndex: ' + pageIndex + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    console.log(response.d);
                },
                error: function (response) {
                    console.log(response.d);
                }
            });
        } else {
            if (!IsNoMoreImages) {
                $(".loader").hide();
                IsNoMoreImages = true;
                $("#divVisitor").append('<br /><div class="text-center small text-secondery"><b>No more data to show...</b><div>');

            }
        }
    }

    function OnSuccess(response) {
        var xmlDoc = $.parseXML(response.d);
        var xml = $(xmlDoc);
        pageCount = parseInt(xml.find("PageCount").eq(0).find("PageCount").text());
        var visitors = xml.find("Visitor");
        function uuidv4() {
            return ([1e7] + -1e3 + -4e3 + -8e3 + -1e11).replace(/[018]/g, c =>
                (c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16)
            );
        }
        visitors.each(function () {
            var visitor = $(this);
            var div_id = $(".div-visitor div").eq(0).eq(0).attr("id", "div_" + uuidv4());
            var _div = div_id.clone(true);
            //var _div = $(".div-visitor div").eq(0).eq(0).clone(true);
            // var visitorId = visitor.find("Id").text();
            $(".rowNumber", _div).html(visitor.find("RowNumber").text());
            $(".id", _div).html(visitor.find("Id").text());
            $(".hdnId", _div).val(visitor.find("Id").text());
            $(".cardId", _div).attr("id", visitor.find("Name").text());
            $(".name", _div).html(visitor.find("Name").text());
            $(".image1", _div).attr("src", visitor.find("Image1").text().replace("~", ""));
            $(".totalNumber", _div).html(visitor.find("TotalNumber").text());
            $(".cat", _div).html(visitor.find("Cat").text());
            $(".fromDate", _div).html(visitor.find("FromDate").text());
            $(".toDate", _div).html(visitor.find("ToDate").text());
            $(".descr", _div).html(visitor.find("Descr").text());
            $(".nameOfUser", _div).html(visitor.find("NameOfUser").text());
            $(".crDt", _div).html(visitor.find("CrDt").text());
            $(".div-visitor").append(_div);

        });

        $('.div-visitor div').each(function () {
            if ($(this).find('.toDate').html() !== '') {
                $(this).find('.linkUpdate').remove();
            }
            if ($(this).find('.image1').attr("src") === '') {
                $(this).find('.image1').remove();
            }
        });
        $(".loader").hide();
    }

    //#endregion


    //#region Update
    function alertMsgForVisitorToDate() {
        swal({
            title: '',
            text: 'Successfully Updated',
            type: 'success'
        });
    }

    function PrintElem(elem) {
        var mywindow = window.open('', 'PRINT', 'height=400,width=600');

        mywindow.document.write('<html><head><title>' + document.title + '</title>');
        mywindow.document.write('</head><body >');
        mywindow.document.write('<h1>' + document.title + '</h1>');
        mywindow.document.write(document.getElementById(elem).innerHTML);
        mywindow.document.write('</body></html>');

        mywindow.document.close(); // necessary for IE >= 10
        mywindow.focus(); // necessary for IE >= 10*/

        mywindow.print();
        mywindow.close();

        return true;
    }

    $(".linkUpdate").click(function () {
        var visitorId = $(this).closest('.div-visitor div').find('.hdnId').val();
        $(".hdnModalId").val(visitorId);
        $(".txtToDate").val('');

        var uniqueDiv = $(this).parent().parent().attr("id");
        $(".hdnUniqueDiv").val(uniqueDiv);
        //$('.updateVisitorModal').modal('show');

        //var divToPrint = document.getElementById(uniqueDiv);
        //newWin = window.open("");
        //newWin.document.write(divToPrint.outerHTML);
        //newWin.print();
        //newWin.close();

        //var divToPrint = document.getElementById(uniqueDiv);
        //newWin = window.open("", '', 'height=400,width=800');
        //newWin.document.write('DIV Contents');
        //newWin.document.write(divToPrint.outerHTML);
        //newWin.print();
        //newWin.close();

        var mywindow = window.open('', 'PRINT', 'height=400,width=600');

        mywindow.document.write('<html><head><title>' + document.title + '</title>');
        mywindow.document.write('</head><body >');
        mywindow.document.write('<h1>' + document.title + '</h1>');
        mywindow.document.write(document.getElementById(uniqueDiv).innerHTML);
        mywindow.document.write('</body></html>');

        mywindow.document.close(); // necessary for IE >= 10
        mywindow.focus(); // necessary for IE >= 10*/

        mywindow.print();
        mywindow.close();

        return true;

    });

    $(".btnSubmitDate").click(function () {
        var visitorId = $(".hdnModalId").val();
        var toDate = $(".txtToDate").val();
        var uniqueDiv = $(".hdnUniqueDiv").val();

        if (visitorId !== 0) {
            if (toDate.length > 0) {
                $.ajax({
                    type: "POST",
                    url: "Visitor.aspx/UpdateVisitor",
                    data: '{visitorId: ' + visitorId + ', toDate: ' + JSON.stringify(toDate) + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        if (r.d) {
                            $('.updateVisitorModal').modal('hide');
                            $('.div-visitor').find("#" + uniqueDiv).find(".toDate").text(dateFormat(toDate, "mmm d yyyy h:MM TT"));
                            //$('.div-visitor').find("#" + uniqueDiv).find(".linkUpdate").fadeOut(1000, function () {
                            $('.div-visitor').find("#" + uniqueDiv).find(".linkUpdate").fadeOut("3000");
                            // $('.div-visitor').find("#" + uniqueDiv).find(".linkUpdate").remove();

                            //});
                            // alertMsgForVisitorToDate();

                           
                        }
                    }
                    ,
                    failure: function (response) {
                        console.log(response.d);
                    },
                    error: function (response) {
                        console.log(response.d);
                    }
                });
            }
            else {
                $(".txtToDate").focus();
            }
        }
        else {
            return false;
        }
    });
    //#endregion

    //#region Remove
    $(".linkRemove").click(function () {
        var visitorId = $(this).closest('.div-visitor div').find('.hdnId').val();
        $(".hdnModalId").val(visitorId);
        var uniqueDiv = $(this).parent().parent().attr("id");
        $(".hdnUniqueDiv").val(uniqueDiv);
        $('.removeVisitorModal').modal('show');
    });

    $(".btnRemoveVisitor").click(function () {
        var visitorId = $(".hdnModalId").val();
        var uniqueDiv = $(".hdnUniqueDiv").val();
        //alert(visitorId);
        if (visitorId !== 0) {
            $.ajax({
                type: "POST",
                url: "Visitor.aspx/RemoveVisitor",
                data: '{visitorId: ' + JSON.stringify(visitorId) + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    if (r.d) {
                        $('.div-visitor').find("#" + uniqueDiv).fadeOut(1000, function () {
                            $('.div-visitor').find("#" + uniqueDiv).remove();
                        });
                        $('.removeVisitorModal').modal('hide');

                    }
                }
                ,
                failure: function (response) {
                    console.log(response.d);
                },
                error: function (response) {
                    console.log(response.d);
                }
            });
        }
        else {
            return false;
        }
    });
    //#endregion


    //$('.div-visitor div').each(function () {
    //    if ($(this).find('.toDate').html() !== '') {
    //        $(this).find('.linkUpdate').remove();
    //    }
    //    else {
    //        $(this).find('.linkUpdate').prop('disabled', false);
    //    }
    //});
});





