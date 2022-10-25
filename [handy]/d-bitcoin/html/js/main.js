var firsttimeopen = true
var automaticstart = false
$(function(){
	var documentWidth = document.documentElement.clientWidth;
	var documentHeight = document.documentElement.clientHeight;
	var cursorX = documentWidth / 2;
	var cursorY = documentHeight / 2;
	var cursor = $("#cursor");
    var container = $("#container");
    $('#container').fadeOut(0);
			
	window.addEventListener("message", function(event)
	{
		var v = event.data;
		
		if (v.showUI == true) {
			if ( firsttimeopen == true) {
				$(".startingscreen").fadeOut(500)
				firsttimeopen = false
				if (automaticstart == true ) {
					showBody()
				}
			} else {
				showBody()
			}
		
        }  else if (v.hideUI == true) {
			hideBody()
		} else if (v.automaticstart == true) {
			automaticstart = true
		}
	});
    
	
	$(document).keyup(function(data) {
        if (data.which == 27) {
            sendData("close");
        }
    });
});

function sendData(name, data)
{
    $.post("http://d-bitcoin/" + name, JSON.stringify(data), function(datab) {
        console.log(datab);
    });
}

function hide(){
	$(".body").hide();
}


var open = "homescreen"
var already = false
$(document).on("click", ".navbaritem", function() {
	var mainscreen = $(this).data("mainscreen");
	if (already == true) return
	
	if (open == null) {
		already = true
		$("#"+mainscreen).show(500)
		open = mainscreen
		setTimeout(function(){
			already = false
		}, 500)
	} else {
		if (open != mainscreen) {
			already = true
			$("#" + open).animate({left: '100%'}, 1000);
			$("#"+mainscreen).css({"left": '-70%', "display": "block"});
			$("#"+mainscreen).animate({left: '22%'}, 1000);
			open = mainscreen
			setTimeout(function(){
				already = false
			}, 1000)
		}
	} 
   
});

function print(text) {
    sendData("print", {message: text})
}

$(document).on("click", ".close", function() {
	sendData("close");
});


$(document).on("click", ".maximize", function() {
	maximize()
});

let maxed = false

function maximize()
{
	if (maxed == false) {
		$(".body").animate(
			{
				"width": "100%",
				"height": "100%",
				"left": "0",
				"top": "0",
			}
		)
		$(".notification").animate(
			{
				"top": "0",
			}
		)
		setTimeout(function(){ 
			$(".body").css(
				{
					"border-radius": "0vh",
				}
			)
			$(".leftbar").css(
				{
					"border-radius": "0vh",
				}
			)
		 }, 400)
		maxed = true
	} else {
		$(".body").animate(
			{
				"width": "90%",
				"height": "90%",
				"left": "5%",
				"top": "5%",
				"border-radius": "3vh",
			}
		)
		$(".notification").animate(
			{
				"top": "5%",
			}
		)
		$(".leftbar").css(
			{
				"border-top-left-radius": "3vh",
				"border-bottom-left-radius": "3vh",
			}
		)
		maxed = false
	}
}

function showBody() {
	$(".body").css({
		"display": "block",
		"top": "100%",
	}).animate({
		"top": "5%"
	}, 500)
}

function hideBody() {
	$(".body").animate({
		"top": "155%"
	}, 500, function() {
		$(".body").css({
			"display": "none",
		})
	})
}