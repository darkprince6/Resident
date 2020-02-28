
// #region Image
function openImageModal() {
    $('.openattachimagemodal').modal('show');
}
function closeImageModal() {
    $('.openattachimagemodal').modal('hide');
}
// #endregion

// #region PostOffice
function openPOInsModal() {
    $('.post-office-ins').modal('show');
}
function closePOInsModal() {
    $('.post-office-ins').modal('hide');
}

function openPOUpdModal() {
    $('.post-office-upd').modal('show');
}
function closePOUpdModal() {
    $('.post-office-upd').modal('hide');
}

function alertMsgForPOIns() {
    swal({
        title: 'Congratulations!',
        text: 'Successfully Inserted Data',
        type: 'success'
    });
}

function alertMsgForPOUpd() {
    swal({
        title: 'Congratulations!',
        text: 'Successfully Updated Data',
        type: 'success'
    });
}
// #endregion