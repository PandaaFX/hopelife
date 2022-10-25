$(function() {
    window.addEventListener("message", function(event) {
        var v = event.data;

        if (v.showMiningpage == true) {
            
            LoadMiningPage(v.GPU, v.CPU, v.RAM, v.miningrate, v.walletworth)
        } else if (v.updateminedamount) {
            Updateminedamount(v.amount)
        }
    });
});

function LoadMiningPage(GPU, CPU, RAM, miningrate, walletworth) {
    $("#mining-gpu").html(GPU)
    $("#mining-cpu").html(CPU)
    $("#mining-ram").html(RAM)
    $("#mining-incomeperhour").html(miningrate)
    $("#mining-walletworth").html(walletworth)
}


let miningactive = false
let mined = 0

$(document).on("click", "#startmining", function() {
		
	if (miningactive == false) {
		$("#startmining").animate({top: '12vh', "border-color": "rgb(223, 45, 45)"}, 500);
		$(".startminingstats").animate({opacity: '1.0'}, 500);
		$("#startmining").html("STOP");
		setTimeout(function(){ 
			$("#startmining").addClass("activeminingbutton");
		 }, 500);
		sendData("mining:start")
		miningactive = true
	} else {
		$("#startmining").animate({top: '15vh', "border-color": "rgb(57, 180, 139)"}, 500);
		$(".startminingstats").animate({opacity: '0.0'}, 500);
		$("#startmining").html("START");
		setTimeout(function(){ 
			$("#startmining").removeClass("activeminingbutton");
		 }, 500);
		 sendData("mining:stop")
		miningactive = false
	}
	
});

function Updateminedamount(amount) {
    mined = mined + amount
    $(".startminingstats").html(mined)
}