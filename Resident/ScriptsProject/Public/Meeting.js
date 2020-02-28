
$(document).ready(function () {
    timePicker();
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (evt, args) {
        timePicker();
    });
});


function timePicker() {

    $(".time-picker").datepicker({
        enableTime: true,
        noCalendar: true,
        dateFormat: "H:i"
    }).val();
}



//#region Agenda
function openAgendaModal() {
    $('.open-agenda-modal').modal('show');
}

function closeAgendaModal() {
    $('.open-agenda-modal').modal('hide');
}
function alertMsgForAgenda() {
    swal({
        title: 'Congratulations!',
        text: 'Successfully Submited Agenda',
        type: 'success'
    });
}


function openAgendaModalForEdit() {
    $('.open-agenda-modal-for-edit').modal('show');
}

function closeAgendaModalForEdit() {
    $('.open-agenda-modal-for-edit').modal('hide');
}
function alertMsgForAgendaForEdit() {
    swal({
        title: 'Congratulations!',
        text: 'Successfully Updated Agenda',
        type: 'success'
    });
}

function openAgendaModalForRemove() {
    $('.open-agenda-modal-for-remove').modal('show');
}

function closeAgendaModalForRemove() {
    $('.open-agenda-modal-for-remove').modal('hide');
}

//#endregion

//#region Attendance
function openAttendanceModal() {
    $('.open-attendance-modal').modal('show');
}

function closeAttendanceModal() {
    $('.open-attendance-modal').modal('hide');
}
function alertMsgForAttendance() {
    swal({
        title: 'Congratulations!',
        text: 'Successfully Submited Attendance',
        type: 'success'
    });
}


function openAttendanceModalForEdit() {
    $('.open-attendance-modal-for-edit').modal('show');
}

function closeAttendanceModalForEdit() {
    $('.open-attendance-modal-for-edit').modal('hide');
}
function alertMsgForAttendanceForEdit() {
    swal({
        title: 'Congratulations!',
        text: 'Successfully Updated Attendance',
        type: 'success'
    });
}

function openAttendanceModalForRemove() {
    $('.open-attendance-modal-for-remove').modal('show');
}

function closeAttendanceModalForRemove() {
    $('.open-attendance-modal-for-remove').modal('hide');
}

//#endregion

//#region Minutes
function openMinutesModal() {
    $('.open-minutes-modal').modal('show');
}

function closeMinutesModal() {
    $('.open-minutes-modal').modal('hide');
}
function alertMsgForMinutes() {
    swal({
        title: 'Congratulations!',
        text: 'Successfully Submited Minutes',
        type: 'success'
    });
}

function openMinutesModalForEdit() {
    $('.open-minutes-modal-for-edit').modal('show');
}

function closeMinutesModalForEdit() {
    $('.open-minutes-modal-for-edit').modal('hide');
}
function alertMsgForMinutesForEdit() {
    swal({
        title: 'Congratulations!',
        text: 'Successfully Updated Minutes',
        type: 'success'
    });
}

function openMinutesModalForRemove() {
    $('.open-minutes-modal-for-remove').modal('show');
}

function closeMinutesModalForRemove() {
    $('.open-minutes-modal-for-remove').modal('hide');
}

//#endregion

//#region Decisions
function openDecisionsModal() {
    $('.open-decisions-modal').modal('show');
}

function closeDecisionsModal() {
    $('.open-decisions-modal').modal('hide');
}
function alertMsgForDecisions() {
    swal({
        title: 'Congratulations!',
        text: 'Successfully Submited Decisions',
        type: 'success'
    });
}

function openDecisionsModalForEdit() {
    $('.open-decisions-modal-for-edit').modal('show');
}

function closeDecisionsModalForEdit() {
    $('.open-decisions-modal-for-edit').modal('hide');
}
function alertMsgForDecisionsForEdit() {
    swal({
        title: 'Congratulations!',
        text: 'Successfully Updated Decisions',
        type: 'success'
    });
}

function openDecisionsModalForRemove() {
    $('.open-decisions-modal-for-remove').modal('show');
}

function closeDecisionsModalForRemove() {
    $('.open-decisions-modal-for-remove').modal('hide');
}


//#endregion