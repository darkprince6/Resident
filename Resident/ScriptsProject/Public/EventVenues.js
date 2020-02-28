
$(document).ready(function () {
    maxLength250();
    datePickerFrom();
    datePickerTo();
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (evt, args) {
        maxLength250();
        datePickerFrom();
        datePickerTo();
    });
});


function maxLength250 () {
    $('[data-charcount="true"]').charcount({
        errFontColor: 'red',
        okFontColor: 'green',
        FontSize: 'xx-small',
        NumOfCharOfAlert: 20,
        isAlwaysOn: false
    });
}


function datePickerFrom() {
    $(".date-picker-from").flatpickr({
        altInput: true,
        altFormat: "F j, Y",
        dateFormat: "Y-m-d"
    });
}

function datePickerTo() {
    $(".date-picker-to").flatpickr({
        altInput: true,
        altFormat: "F j, Y",
        dateFormat: "Y-m-d"
    });
}

//#region EventVeues
function openVenueModal() {
    $('.open-venue-modal').modal('show');
}

function closeVenueModal() {
    $('.open-venue-modal').modal('hide');
}
function alertMsgForVenue() {
    swal({
        title: 'Congratulations!',
        text: 'Successfully Submited Venue',
        type: 'success'
    });
}


function openVenueModalForEdit() {
    $('.open-venue-modal-for-edit').modal('show');
}

function closeVenueModalForEdit() {
    $('.open-venue-modal-for-edit').modal('hide');
}
function alertMsgForVenueForEdit() {
    swal({
        title: 'Congratulations!',
        text: 'Successfully Updated Venue',
        type: 'success'
    });
}

function openVenueModalForRemove() {
    $('.open-venue-modal-for-remove').modal('show');
}

function closeVenueModalForRemove() {
    $('.open-venue-modal-for-remove').modal('hide');
}

//#endregion
