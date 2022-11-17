$(".ui_container").hide();

window.addEventListener('message', (event) => {
    if (event.data.type == "enableui") {
       if (event.data.enable) {
            $(".ui_container").show();
            console.log("open")
       } else {
            $(".ui_container").hide();
        }
    }
});

document.onkeyup = function (data) {
    if (data.which == 27) { // Escape key
        $.post('http://esx_identity/escape', JSON.stringify({}));
    }
};

function submit() {
    var date = $(".input_alter").val();
    var dateCheck = new Date($(".input_alter").val());
    var curSex = $(".input_geschlecht").val()


    if (dateCheck == "Invalid Date") {
        date = "invalid";
    }

    if (curSex != "M" && curSex != "F") {
        curSex = "invalid";
    }

    $.post('http://esx_identity/register', JSON.stringify({
        firstname: $(".input_vorname").val(),
        lastname: $(".input_nachname").val(),
        dateofbirth: date,
        sex: curSex,
        height: $(".input_größe").val(),
    }));    
}