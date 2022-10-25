$(function() {
    window.addEventListener("message", function(event) {
        var v = event.data;

        if (v.setLocale == true) {
            setLocale(v.locale)
        } 
    });
});

function setLocale(locale) {
    $(".startingscreen-loadingtext").html(locale.startingscreen)
    // Navbar
    $("#localenavbar").html(locale.navbar)
    $("#localehome").html(locale.hhome)
    $("#localemining").html(locale.hmining)
    $("#localemarket").html(locale.hmarket)
    $("#localetransfer").html(locale.htransfer)
    $("#localeshop").html(locale.hshop)
    $("#localesettings").html(locale.hsettings)

    // Titles
    $("#localehome2").html(locale.hhome)
    $("#localemining2").html(locale.hmining)
    $("#localemarket2").html(locale.hmarket)
    $("#localetransfer2").html(locale.htransfer)
    $("#localeshop2").html(locale.hshop)
    $("#localesettings2").html(locale.hsettings)

    // Home
    $(".localelasthour").html(locale.lasthour)
    $(".localelast3hour").html(locale.last3hour)
    $(".localelast6hour").html(locale.last6hour)
    $(".localelast12hour").html(locale.last12hour)
    $(".localelast24hour").html(locale.alltime)

    $("#localewalletbtc").html(locale.walletbtc)
    $("#localewalletdol").html(locale.walletdol)
    $("#localehomebitcoinprice").html(locale.bitcoinprice)
    
    // Mining
    $("#startmining").html(locale.start)
    $("#localespecs").html(locale.specs)
    $("#mining-gpu").html(locale.gpu)
    $("#mining-cpu").html(locale.cpu)
    $("#mining-ram").html(locale.ram)
    $("#localeich").html(locale.ich)
    $("#mining-localewallet").html(locale.walletbtc)
    
    // Shop
    $("#shop-localecpu").html(locale.cpu)
    $("#shop-localegpu").html(locale.gpu)
    $("#shop-localeram").html(locale.ram)

    // Market
    $(".localelasthour2").html(locale.lasthour)
    $(".localelast3hour2").html(locale.last3hour)
    $(".localelast6hour2").html(locale.last6hour)
    $(".localelast12hour2").html(locale.last12hour)
    $(".localelast24hour2").html(locale.alltime)
    $("#marketbuy").html(locale.buy2)
    $("#marketsell").html(locale.sell2)

    // Transfer
    $("#locale.walletid").html(locale.walletid)
    $("#locale.amountbtc").html(locale.amountbtc)
    $("#tranfer").html(locale.htransfer)
    $("#locale.yourwalletid").html(locale.yourwalletid)
    $("#locale.history").html(locale.hhistory)
    $("#locale.amountbtc").html(locale.amountbtc)

}