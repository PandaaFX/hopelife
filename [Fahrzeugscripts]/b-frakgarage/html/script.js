// HIDE ELEMS
function hideElem(arg) {
    $('.'+ arg +'').hide();
}

function hideAll() {
    $('#ui').hide();
    $(".fx-green-l").hide();
    $(".fx-green-r").hide();
    $(".hex-green-l").hide();
    $(".hex-green-r").hide();
    $(".no-vehicles").hide();
    $(".gang-stock").hide();
    $(".garage-page").hide();
    $(".buy-page").hide();
    $(".parkout-page").hide();
    $(".parkout-list").empty();
    $(".buy-list").empty();
}

function showElem(arg) {
    $('.'+ arg +'').show();
}

var fav_active = false;

$(".car-black").hide()

function addFav(fav) {
    if (fav_active = !fav_active) {
        fav_active = true;
        $(fav).css("color", "#FFDC5F");
        var elem = $(fav).closest("li");
        $(elem).prependTo(".parkout-list")

    } else {
        fav_active = false;
        $(fav).css("color", "#FFFFFF");
    }
}

let selectedCar = {}

function selectCar(car, carname, carid, carprice) {
    selectedCar = {
        label: carid,
        name: carname,
        price: carprice
    }
    $.post(`https://`+ GetParentResourceName() +`/selectCar`, JSON.stringify({
        carname: selectedCar.label
    }));
    document.getElementById("summe").innerHTML = formatMoney(carprice)
    $(".buy-vehicle").css("background-color", ("rgb(0, 0, 0, 0.25)"))
    $(".buy-vehicle").css("color", ("#FFFFFF"))
    $(".buy-car-price").css("color", "#BDFF69")
    $(".car-black").hide()
    $(".car-white").show()
    $(car).css("background-color", "rgba(255, 255, 255, 0.85)")
    $(car).css("color", "#252525")
    $(car).find(".buy-car-price").css("color", "#FC4755")
    $(car).find(".car-white").hide()
    $(car).find(".car-black").show()
}

function noVehicles() {
    console.log("lol")
    $(".s-bar").hide();
    $(".parkout-list").hide();
    $(".no-vehicles").show();
}


$(function() 
{


    // Buttons
    $(".back-btn").click(function()
    {
        $(".garage-page").fadeIn(200);
        $(".parkout-page").fadeOut(200);
        $(".parkout-list").empty();
        document.getElementById("summe").innerHTML = "NICHTS AUSGEWÄHLT"

        $(".buy-list").empty();
    })
    $(".back-btn-buy").click(function()
    {
        $.post(`https://`+ GetParentResourceName() +`/closeCam`, JSON.stringify({}));
        document.getElementById("summe").innerHTML = "NICHTS AUSGEWÄHLT"
        $(".parkout-list").empty();
        $(".buy-list").empty();
        $(".garage-page").fadeIn(200);
        $(".buy-page").fadeOut(200);
    })

    // Hover FX
    $(".garage-page-l").mouseenter(function()
    {
        $(".fx-green-l").fadeIn(250);
        $(".hex-white-l").fadeOut(250);
        $(".hex-green-l").fadeIn(250);
    })
    
    $(".garage-page-l").mouseleave(function() 
    {
        $(".fx-green-l").fadeOut(250);
        $(".hex-green-l").fadeOut(250);
        $(".hex-white-l").fadeIn(250);
    })
    
    $(".garage-page-r").mouseenter(function()
    {
        $(".fx-green-r").fadeIn(250);
        $(".hex-white-r").fadeOut(250);
        $(".hex-green-r").fadeIn(250);
    })
    
    $(".garage-page-r").mouseleave(function() 
    {
        $(".fx-green-r").fadeOut(250);
        $(".hex-green-r").fadeOut(250);
        $(".hex-white-r").fadeIn(250);
    })

    // Parking

    $(".garage-page-l").click(function()
    {
        $(".garage-page").fadeOut(200)
        $(".parkout-page").fadeIn(200)
        $.post(`https://`+ GetParentResourceName() +`/addCarsToGarage`, JSON.stringify({}));
    })

    // Buy Page
    $(".garage-page-r").click(function()
    {
        $(".garage-page").fadeOut(200)
        $(".buy-page").fadeIn(200)
        $.post(`https://`+ GetParentResourceName() +`/addCarsToShop`, JSON.stringify({}));
    })

    $(document).ready(function(){
        $(".searchbar").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $(".parkout-list li").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });

    hideAll()
    
    
})

window.addEventListener('message', function(event) {
    if (event.data.type == "openGaragePage") {
        $('#ui').show()
        showElem("garage-page")   
    }
    if (event.data.type == "addCarToGarage") {
        addCarToGarage(event.data.carName, event.data.carId, event.data.carplate, event.data.carstatus)
    }

    if (event.data.type == "noVehiclesPage") {
        noVehicles()
    }

    if (event.data.type == "addCarToShop") {
        addCarToShop(event.data.carName, event.data.carId, event.data.carPrice)
        document.getElementById("title").innerHTML = event.data.frakname + " DEALERSHIP" 
        setTimeout(() => {
            $(".car-black").hide()
            $(".car-white").show()
        }, 50);
    }  
});

function formatMoney(price) {
    return new Intl.NumberFormat('en-US', {style: 'currency',currency: 'USD', minimumFractionDigits: 2}).format(price);
}

function addCarToGarage(carname, carid, carplate, carstatus) {
    $(".parkout-list").show();
    $('.parkout-list').append(`
        <li class="car-element"><div class="car-icon"><img src="./assets/img/garage/car-icon.png"></div><div class="carname"><h2>` + carname + carstatus +` </h2></div><div class="park-buttons"><a class="park-btn" onclick="spawnCar('`+ carname +`', '`+ carid +`','`+ carplate +`')"><p>Ausparken</p></a><a onclick="parkCar('`+ carname +`', '`+ carid +`','`+ carplate +`')" class="spawn-btn"><p>`+carplate+`</p></a></div><div class="fav-add"><i onclick="addFav(this)" class="bi bi-bookmark-star-fill fav-filled"></i></div></li>
    `) 
    // $('.parkout-list').append(`
    //     <li class="car-element"><div class="car-icon"><img src="./assets/img/garage/car-icon.png"></div><div class="carname"><h2>` + carname + ` </h2><h4> Plate: ` +carplate+ `</h4></div><div class="park-buttons"><a class="park-btn" onclick="parkCar('`+ carname +`', '`+ carid +`','`+ carplate +`')"><p>Einparken</p></a><a onclick="spawnCar('`+ carname +`', '`+ carid +`','`+ carplate +`')" class="spawn-btn"><p>Ausparken</p></a></div><div class="fav-add"><i onclick="addFav(this)" class="bi bi-bookmark-star-fill fav-filled"></i></div></li>
    // `) 
}

function addCarToShop(carname, carid, carprice) {
    $(".buy-list").show();
    $('.buy-list').append(`
        <li onclick="selectCar(this, '`+ carname +`', '`+ carid +`', '`+ carprice +`')" class="buy-vehicle"><div class="buy-car-icon"><img src="./assets/img/garage/car-icon.png" class="car-white"><img src="./assets/img/garage/car-black.png" class="car-black"></div><div class="buy-car-text"><p>`+ carname +`</p></div><div class="buy-car-price"><p>`+ formatMoney(carprice) + `</p></div></li>
    `) 
}

function spawnCar(carname, carid, carplate) {
    $.post(`https://`+ GetParentResourceName() +`/parkoutCar`, JSON.stringify({
        car: carname, 
        carid: carid,
        carplate: carplate,
    }));
    hideAll()
    $.post(`https://`+ GetParentResourceName() +`/close`, JSON.stringify({}));
}

function parkCar(carname, carid, carplate) {
    $.post(`https://`+ GetParentResourceName() +`/parkinCar`, JSON.stringify({
        car: carname, 
        carid: carid,
        carplate: carplate,
    }));
}

function buyCar() {
    $.post(`https://`+ GetParentResourceName() +`/buyCar`, JSON.stringify({
        carlabel: selectedCar.label,
        carname: selectedCar.name,
        carprice: selectedCar.price,
    }));
    hideAll()
    $.post(`https://`+ GetParentResourceName() +`/close`, JSON.stringify({}));
}

function testDrive() {
    $.post(`https://`+ GetParentResourceName() +`/testDrive`, JSON.stringify({
        carlabel: selectedCar.label,
        carname: selectedCar.name,
    }));
    hideAll()
    $.post(`https://`+ GetParentResourceName() +`/close`, JSON.stringify({}));
}

$(document).keyup(function(e) {
    if (e.keyCode == 27) { // escape key maps to keycode `27`
        hideAll()
        document.getElementById("summe").innerHTML = "NICHTS AUSGEWÄHLT"

        $.post(`https://`+ GetParentResourceName() +`/close`, JSON.stringify({}));
   }
});