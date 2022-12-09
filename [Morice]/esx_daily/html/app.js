function display(bool) {
    if (bool) {
        $(".main__container").fadeIn();
    } else {
        $(".main__container").fadeOut();
    }
}

$(document).keyup(function(event) {
    if (event.key === 'Escape') {
        display(false)
        $.post('https://esx_daily/close', JSON.stringify({}));
    }
});

window.addEventListener('message', function(event) {
    if (event.data.type == "showUI") {
        openingAnimation(event.data.access)
    }
});

function openingAnimation(index) {
    if (index) {
        display(true)
    } else {
        $.post('https://esx_daily/close', JSON.stringify({}));
    }
}

function claim() {
    display(false)
    $.post('https://esx_daily/close', JSON.stringify({}));
    $.post('https://esx_daily/claim', JSON.stringify({}));
}

display(false);