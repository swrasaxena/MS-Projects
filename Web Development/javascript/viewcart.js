$(document).ready(function () {
    $(".login").hide();
});
function deleteConfirm() {
    var confirmDelete = confirm("Are you sure you want to delete seleted Item(s)?");
    if (confirmDelete)
        return true;
    else
        return false;
}