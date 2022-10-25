var reqVPCNET = "https://pc.copnet.li";

$(document).ready(function() {

window.addEventListener('message', function(event) {
    if(event.data.type == "Enable")
    {
        var tabWrap = $(".tab-wrap");

        reqVPCNET = event.data.site;
        tabContainer = "#copnet";
        copnetframe = "#copnet";

        $(copnetframe).find("iframe").attr('src', event.data.site);
        $(copnetframe).css("visibility","visible");
    }
    else
    {
        $(copnetframe).css("visibility","hidden");
    }
});


document.addEventListener('keyup', function (data) {

    if (data.which == 27) {
        setTimeout(function() {
            fetch(`https://${GetParentResourceName()}/NUIFocusOff`, {
                method: 'POST',                 
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8'
                },
                bosy: JSON.stringify({close: true})
            }).then(resp => resp.json()).then(resp => console.log(resp))
        }, 20);
    }   ;

    $('.dot').click(function() {
        if (this.id == 'off') {
            fetch(`https://${GetParentResourceName()}/NUIFocusOff`, {
                method: 'POST',                 
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8'
                },
                bosy: JSON.stringify({close: true})
            }).then(resp => resp.json()).then(resp => console.log(resp))
            
        } else if (this.id == 'reset') {
            $(copnetframe).find("iframe").attr('src', reqVPCNET);
        }

    });



});


});