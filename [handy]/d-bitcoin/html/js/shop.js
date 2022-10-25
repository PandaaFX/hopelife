$(function() {
    window.addEventListener("message", function(event) {
        var v = event.data;
        if (v.loadShop == true) {
            LoadShop(v.html)
        } 
    });
});

function LoadShop(html) {
    $(".shopsection").children().detach();
    $(".shopsection").append(html);
}

var oldid = "CPU"

$(document).on('click', '.shopheaderelement', function() {
    var id = $(this).data("id")

    $(".shopheaderelement").each(function() {
        if ($(this).data("id") == oldid) {
            $(this).removeClass("shopactive");
        }
    })
    
    $(this).addClass("shopactive")
    oldid = id
    sendData("shop:load", {
        id: id
    })
});

$(document).on('click', '#shop-buy', function() {
    var name = $(this).parent().parent().data("name")

    sendData("shop:buy", {
        name: name,
        id: oldid
    })
});