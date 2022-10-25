$(function() {
    window.addEventListener("message", function(event) {
        var v = event.data;

        if (v.showNotification == true) {
            ShowNotif(v.html, v.length, v.id)
        }
    });
});

function ShowNotif(data, length, id) {
    let $notification = data;
    $('.notification').append($notification);
    
    let notification2 = $("#" + id);
    setTimeout(function() {
        notification2.fadeOut(250)
        $.when(notification2.fadeOut()).done(function() {
            notification2.remove()
        });
    }, length != null ? length : 2500);
}

$(document).on('click', '#notification-hide', function() {
    var notification = $(this).parent().parent().parent()

    notification.fadeOut(500)
});