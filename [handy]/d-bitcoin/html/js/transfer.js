$(function() {
    window.addEventListener("message", function(event) {
        var v = event.data;
        if (v.LoadTransactions == true) {
            LoadTransactions(v.html, v.walletid)
        } 
    });
});

function LoadTransactions(html, walletid) {
    $(".history").children().detach();
    $(".history").append(html);

    $("#transfer-walletid").html(walletid)
}


$(document).on('click', '#tranfer', function() {
    var walletid = $("#transferid").val()
    var amount = $("#transferinput").val()

    sendData("transfer:transfer", {
        walletid: walletid,
        amount: amount
    })
});