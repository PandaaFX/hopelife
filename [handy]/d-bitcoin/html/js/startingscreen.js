$(function() {
    window.addEventListener("message", function(event) {
        var v = event.data;
        if (v.startscreen) {
            showBody()
            Startloadingscreen(v.time)
        } else if(v.hidestartscreen) {
            $(".startingscreen").fadeOut(500)
        }
    });
});



function Startloadingscreen(time) {
    $(".startingscreen").show(0)
    $(".phone-startscreen-loadingbar-inner").animate({
        "width": "100%",
    }, time)
}