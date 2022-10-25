let check = null;
  $(function () {
    $(".marry").hide()
    $(".adoption").hide()
    window.addEventListener('message', function(event) {
        var item = event.data;
        
        if(item.action == "marry") {
            if(item.status == true) {
                check = "marry"
                $(".content").fadeIn(500)
                $(".marry").show()
            } else if(item.status == false) {
                check = null
                $(".content").fadeOut(500)
                $(".marry").hide()
            }
        } else if(item.action == "adoption") {
            if(item.status == true) {
                check = "adoption"
                $(".content").fadeIn(500)
                $(".adoption").show()
            } else if(item.status == false) {
                check = null
                $(".content").fadeOut(500)
                $(".adoption").hide()
            }
        }
    })
});

function closeuis() {
    $(".content").fadeOut(500)
    $(".marry").hide()
    $(".adoption").hide()
    if(check == "marry") {
        $.post("https://Marry/marry-close", JSON.stringify({}))
        check = null
    } else if(check == "adoption") {
        $.post("https://Marry/adoption-close", JSON.stringify({}))
        check = null
    } else {
        return
    }
}

function clickheiraten() {
    $.post("http://Marry/marry-yes", JSON.stringify({}))
    closeuis() 
}

function clickadoption() {
    $.post("http://Marry/adoption-yes", JSON.stringify({}))
    closeuis() 
}
$(document).keyup(function(event) {
    if (event.which === 27) {
        closeuis()
    }
});
