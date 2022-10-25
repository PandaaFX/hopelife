garage = {
    home: {},
    car : {},
    tabopen:"#garage-home",
    lasttabopen: null,
    loaded: false
}

$(function() {
    $("#garageicon").fadeOut(0)

    window.addEventListener("message", function(event) {
        var v = event.data;

        if (v.app == "garage" && v.task == "showicon") {
            $("#garageicon").fadeIn(0)
        }  

        if (v.app == "garage" && v.task == "load") {
            garage.home.load(v.html)
            garage.loaded = true
            $("#garage-searchbar-val").val('')
        }  

        if (v.app == "garage" && v.task == "car:load") {
            garage.car.load(v.data)
        }  

        if (v.app == "garage" && v.task == "close") {
            if (Main.openapp == "garage") {
                Home()
                garage.open("#garage-home")
            }
        }  
    })

    var searchbar = document.forms['garage-searchbar'].querySelector('input');
	searchbar.addEventListener('keyup', function(e) {
		const term = e.target.value.toLocaleLowerCase();
		var notAvailable = document.getElementById('notAvailable');
		var hasResults = false;

		$(".garage-element").each(function() {
			var e = $(this)
			var vehicle = e.children("div.vehicle.name").html()
			var plate = e.children("div.vehicle.plate").html()
	
			if (vehicle.toString().toLowerCase().includes(term.toString()) || plate.toString().toLowerCase().includes(term.toString())) {
				$(this).show(0);
			} else {
				$(this).hide(0);
			}
		})

	});
});

garage.show = function() {
    if (garage.loaded == false) {
        sendData("garage:loaduserdata")
    }

    ShowHomebar()

    $("#garage").css({
        "z-index": "2"
    })
    $("#garage").animate({
        "left": "0%"
    })

    Main.openapp = "garage"
}

garage.hide = function() {
    $("#phone-homebar").hide(500)
}

var inaction = false
garage.open = function(newopen) {
    if (inaction == true) return
    if (newopen == garage.tabopen) return
    inaction = true
    setTimeout(function(){
        $(garage.tabopen).animate({
            "margin-left": "100%"
        })
        $(newopen).css({
            "margin-left": "0%",
            "margin-right": "100%"
        })
        setTimeout(function(){
            $(newopen).animate({
                "margin-right": "0%"
            }, 500)
        }, 10)
        garage.lasttabopen = garage.tabopen 
        garage.tabopen = newopen
        setTimeout(() => {
            inaction = false
        }, 200);
    }, 10)
}

// home
garage.home.load = function (html) {
    $("#garage-container").html("")
    $("#garage-container").html(html)

    $('.garage-element').sort(function(a, b) {
		if (a.textContent < b.textContent) {
		  return -1;
		} else {
		  return 1;
		}
	  }).appendTo('#garage-container');
      setTimeout(() => {
        $('.garage-element').sort(function(a, b) {
            if ($(a).data("category") < $(b).data("category")) {
              return -1;
            } else {
              return 1;
            }
          }).appendTo('#garage-container');
      }, 10);

      
    $(".garage-element").each(function (index, element) {
		// element == this
		var e = $(this)
		var icon  = e.children("div.icon")
		var img = icon.children('img')
		var iconsrc  = icon.children('img').attr('src');

		checkImage(iconsrc, function(){}, function(){ 
			icon.children('img').attr('src', "./images/icons/example.png");
		 } );

		 if (img.css("background-color") == "rgba(0, 0, 0, 0)") {
			img.addClass("example")
		 }
	});
}

function checkImage(imageSrc, good, bad) {
    var img = new Image();
    img.onload = good; 
    img.onerror = bad;
    img.src = imageSrc;
}

$(document).on('click', '.garage-element', function() {
    var e = $(this)
    var id = e.data("id")

    sendData("garage:car:load", {
        id : id
    })
    garage.open("#garage-car")

    var icon  = e.children("div.icon")
	var iconcolor = icon.children('img').css("background-color")

    $("#garage-car-header").css("background-color", iconcolor)
});

// car
$(document).on('click', '#garage-car-home', function() {
    garage.open("#garage-home")
    SlideUpPage.hide()
});

garage.car.load = function (data) {
    $("#garage-car-head-name").html(data.name)
    var namelength = data.name.length

    if (namelength < 10) {
        $("#garage-car-head-name").css('font-size', "5vh")
    } else if (namelength < 15) {
        $("#garage-car-head-name").css('font-size', "3.5vh")
    } else if (namelength < 18) {
        $("#garage-car-head-name").css('font-size', "2.75vh")
    } else if (namelength < 30) {
        $("#garage-car-head-name").css('font-size', "2vh")
    }

    $("#garage-car-head-plate").html(data.plate)

    if (data.parked == true) {
        $("#garage-car-actions").hide(0)
        SlideUpPage.hide()
    }

    if (data.parked == false) {
        $("#garage-car-actions").show(0)
        var e = $("#garage-car-lock")
        var headline =  e.children("div.headline")
        var icon =  e.children("img.bgimage")

        if (data.locked == true) {
            e.removeClass("lock")
            e.addClass("unlock")

           headline.html("UNLOCK")
           icon.attr("src", "./images/icons/unlock.png")
        } else {
            e.removeClass("unlock")
            e.addClass("lock")

            headline.html("LOCK")
            icon.attr("src", "./images/icons/lock.png")
        }

    }

    if (data.enginestate == true) {
        var e = $("#garage-engine-lock")
        var headline =  e.children("div.headline")
        
        e.removeClass("engine")
        e.addClass("lock")

       headline.html("TURNOFF ENGINE")
    } else {
        var e = $("#garage-engine-lock")
        var headline =  e.children("div.headline")
        e.removeClass("lock")
        e.addClass("engine")

        headline.html("START ENGINE")
    }

    if (data.lightstate == true) {
        var e = $("#garage-car-light")

        e.removeClass("light")
        e.addClass("lock")

    } else {
        var e = $("garage-car-light")
        e.removeClass("lock")
        e.addClass("light")
    }

    var array = data.doors

    $(".garage-car-door").each(function (index, ce) {
        var e = $(this)
        e.hide(0)
    });

    array.forEach(element => {
        var door = element.index
        var state = element.isopen

        $(".garage-car-door").each(function (index, ce) {
            var e = $(this)
            if (e.data("door") == door ) {
                e.show(0)
                if (state == true) {
                    e.removeClass("unlock")
                    e.addClass("lock")
                } else {
                    e.removeClass("lock")
                    e.addClass("unlock")
                }
            }
        });
    });

    var array = data.windows

    array.forEach(element => {
        var door = element.index
        var state = element.state

        $(".garage-car-window").each(function (index, ce) {
            var e = $(this)
            
            if (e.data("window") == door ) {
                if (state == false) {
                    e.removeClass("unlock")
                    e.addClass("lock")
                } else {
                    e.removeClass("lock")
                    e.addClass("unlock")
                }
            }
        });
    });

    $("#garage-car-plate").html(data.plate)
    $("#garage-car-mileage").html(data.mileage)
    $("#garage-car-price").html(data.price)
    $("#garage-car-age").html(data.age)

    garage.car.setdoorstatus(data.doors)

    $(".garage-car-action").each(function (index, element) {
       var e = $(this)
        var type = e.data("type")
       if (data.enabled[type]) {
           e.show(0)
       } else
        e.hide(0)
    });
}
var action = false

$(document).on('click', '.garage-car-action', function() {
    if(action == true) return
    action = false

   var type = $(this).data("type")
    var e = $(this)
    var headline =  e.children("div.headline")
    var icon =  e.children("img.bgimage")
   if (type == "lock") {
        var action = "lock";
        if (e.hasClass("lock")) {
            e.removeClass("lock")
            e.addClass("unlock")

           headline.html("UNLOCK")
           icon.attr("src", "./images/icons/unlock.png")
        } else {
            action = "unlock"
            e.removeClass("unlock")
            e.addClass("lock")

            headline.html("LOCK")
            icon.attr("src", "./images/icons/lock.png")
        }

        sendData("garage:lock", {
            action : action
        })
   }

   if (type == "window") {
        id = "garage-car"
        $("#" + id).animate({ scrollTop: 0 }, 400);
        SlideUpPage.show("garage-window", "-25%")
   }

   if (type == "door") {
        id = "garage-car"
        $("#" + id).animate({ scrollTop: 0 }, 400);
        SlideUpPage.show("garage-door", "-20%")
    }

    if (type == "waypoint") {
        sendData("garage:waypoint")
    }

    if (type == "engine") {
        var action = "start";
        if (e.hasClass("engine")) {
            e.removeClass("engine")
            e.addClass("lock")

           headline.html("TURNOFF ENGINE")
           
        } else {
            action = "unlock"
            e.removeClass("lock")
            e.addClass("engine")

            headline.html("START ENGINE")
            action = "turnoff"
        }

        sendData("garage:engine", {
            action : action
        })
    }

    if (type == "light") {
        var action = "start";
        if (e.hasClass("light")) {
            e.removeClass("light")
            e.addClass("lock")
           
        } else {
            e.removeClass("lock")
            e.addClass("light")

        }

        sendData("garage:light")
    }

    if (type == "horn") {
        var action = "start";
        if (e.hasClass("horn")) {
            e.removeClass("horn")
            e.addClass("lock")

            sendData("garage:horn")

           
            setTimeout(() => {
                e.removeClass("lock")
                e.addClass("horn")
            }, 3000);
        } 

    }

    setTimeout(() => {
        action = false 
    }, 400);
});

$(document).on('click', '.garage-car-window', function() {
    if(action == true) return
    action = false
    var window = $(this).data("window")
     var e = $(this)
     var icon =  e.children("img.bgimage")

    var action = "lock";
    if (e.hasClass("lock")) {
        e.removeClass("lock")
        e.addClass("unlock")

     icon.attr("src", "./images/icons/unlock.png")
    } else {
        action = "unlock"
        e.removeClass("unlock")
        e.addClass("lock")

        icon.attr("src", "./images/icons/lock.png")
    }

    sendData("garage:window", {
        window : window
    })

    setTimeout(() => {
        action = false 
    }, 400);
 });

garage.car.setdoorstatus = function (data) { 
    data.forEach(element => {
        $(".garage-car-door").each(function (i, e2) {
            var e = $(this)

           if (element.index == e.data("door")) {
                var icon =  e.children("img.bgimage")
                var action = "lock";
                if (element.isopen == false) {
                    e.removeClass("lock")
                    e.addClass("unlock")
            
                    icon.attr("src", "./images/icons/unlock.png")
                } else {
                    action = "unlock"
                    e.removeClass("unlock")
                    e.addClass("lock")
            
                    icon.attr("src", "./images/icons/lock.png")
                }
           }
        });
    });
 }

 $(document).on('click', '.garage-car-door', function() {
    if(action == true) return
    action = false
    var door = $(this).data("door")
     var e = $(this)
     var icon =  e.children("img.bgimage")

    var action = "lock";
    if (e.hasClass("lock")) {
        e.removeClass("lock")
        e.addClass("unlock")

     icon.attr("src", "./images/icons/unlock.png")
    } else {
        action = "unlock"
        e.removeClass("unlock")
        e.addClass("lock")

        icon.attr("src", "./images/icons/lock.png")
    }

    sendData("garage:door", {
        door : door
    })

    setTimeout(() => {
        action = false 
    }, 400);
 });