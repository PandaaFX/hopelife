ddrop = {}

$(function() {
    window.addEventListener("message", function(event) {
        var v = event.data;

        if (v.app == "ddrop" && v.task == "load") {
            ddrop.load(v.html, v.images)
        } 
    })
});

ddrop.show = function () { 
    $(".ddropcontainer").css({
        "display": "flex"
    })
    $(".ddropcontainer").fadeIn(0)
    $(".ddrop").fadeIn(400)

 }

 ddrop.hide = function () { 
    $(".ddrop").fadeOut(400)
    setTimeout(() => {
        $(".ddropcontainer").fadeOut(0)
    }, 400);
 }

ddrop.load = function (html, images) { 
    $("#ddrop-messages").html(html)
    $("#ddrop-images").html('')
    $("#ddrop-images").append(images)

    ddrop.show()
 }

 $(document).on('click', '#ddrop-accept', function() {
    ddrop.hide()
    sendData("ddrop:accept")
});

$(document).on('click', '#ddrop-decline', function() {
    ddrop.hide()
    sendData("ddrop:decline")
});

$(document).on('click', '.ddrop-image', function() {
    var image =  $(this).attr('src');
    $(".image-preview").fadeIn(500)

    document.getElementById("image-preview-image").src=image;
});


info = {}

info.show = function () { 
    $(".infocontainer").css({
        "display": "flex"
    })

    $(".infocontainer").fadeIn(0)
    $(".infocontainer").css({
        "background": "rgba(255, 255, 255, 0.4)"
    }, 400)
    $(".info").fadeIn(400)

 }

info.hide = function () { 
    $(".info").fadeOut(400)
    $(".infocontainer").css({
        "background": "rgba(255, 255, 255, 0.0)"
    },400)
    setTimeout(() => {
        $(".infocontainer").fadeOut(0)
    }, 400);
 }

 info.load = function (html) { 
    $("#info-messages").html(html)

    info.show()
 }

 $(document).on('click', '#info-accept', function() {
    info.hide()
});