
//#region Check Staff
function openStaffCheckModal() {
    $('.staffCheckModal').modal('show');
}

function closeStaffCheckModal() {
    $('.staffCheckModal').modal('hide');
}
function alertMsgForStaffCheck() {
    swal({
        title: 'Congratulations!',
        text: 'Successfully Sent to admin',
        type: 'success'
    });
}


//#endregion

//#region Approve Staff
function openStaffApproveModal() {
    $('.staffApproveModal').modal('show');
}

function closeStaffApproveModal() {
    $('.staffApproveModal').modal('hide');
}
function alertMsgForStaffApprove() {
    swal({
        title: 'Congratulations!',
        text: 'Successfully Approved by admin',
        type: 'success'
    });
}
//#endregion

//#region Descline Staff
function openStaffDeclineModal() {
    $('.staffDeclineModal').modal('show');
}

function closeStaffDeclineModal() {
    $('.staffDeclineModal').modal('hide');
}
function alertMsgForStaffDecline() {
    swal({
        title: '',
        text: 'Sorry! Rejected by admin',
        type: 'warning'
    });
}
//#endregion
