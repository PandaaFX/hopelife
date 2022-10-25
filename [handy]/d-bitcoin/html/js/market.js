$(function() {
    window.addEventListener("message", function(event) {
        var v = event.data;

        if (v.refreshmarketgraph == true) {
            
            Refreshmarketgraph(v.Data)
        } else if (v.refreshhome == true ) {
            RefreshHome(v.walletamount, v.walletworth, v.bitcoinprice)
        }
    });
});

var firsttimemarket = true
var marketChart

var firstMarketDate = null
var lastMarketDate = null

function Refreshmarketgraph(Data) {
    var newData = []
      
    if (firsttimemarket == true)  {
        $.each( Data, function( key, value ) {
            var obj1 = value.x
            var obj2 = value.y
            newData.push({
                x: new Date(obj1),
                y: obj2
            })
            if (firstMarketDate === null) {firstMarketDate = new Date(obj1)}
            lastMarketDate = new Date(obj1)
        });

        var ctx = document.getElementById('marketChart').getContext('2d');
        marketChart = new Chart(ctx, {
            type: 'line',
            data: {
                // labels: TimeData,
                datasets: [{
                    label: "Bitcoin in $",
                    data: newData,
                    backgroundColor: [
                        'rgba(0, 255, 0, 0.2)'
                    ],
                    borderColor: [
                        'rgba(0, 255, 0, 1)'
                    ],
                    borderWidth: 1,
                    fill: true, 
                    tension: 0.2,
                    pointHoverRadius: 10,
                },
            ]
            },
            options: {
                bezierCurve : true,
                scales: {
                    y: {
                        beginAtZero: false
                    },
                    x: {
                        min: firstMarketDate,
                        max: lastMarketDate,
                        type: "time",
                        time: {
                            unit: "hour",
                        },
                    }
                },
                elements: {
                    point:{
                        radius: 0
                    }
                },
                plugins:{   
                    legend: {
                        display: false
                    },
                },
            }
        });
        firsttimemarket = false
    } else {
        var chart = marketChart
        $.each( Data, function( key, value ) {
            var obj1 = value.x
            var obj2 = value.y
    
            test = {
                x: new Date(obj1),
                y: obj2
            }
            if (firstMarketDate === null) {firstMarketDate = new Date(obj1)}
            lastMarketDate = new Date(obj1)
            
            lastMarketDate2 = new Date(obj1)
            addData(chart, test)
            setTimeout(() => {
                marketChart.options.scales.x.max = lastMarketDate
                marketChart.update();
            }, 100);
            
        });
    }
}

$(document).on('click', '#marketbuy', function() {
    var amount = $("#marketbuyinput").val()
    sendData("market:buy", {
        amount: amount
    })
});

$(document).on('click', '#marketsell', function() {
    var amount = $("#marketsellinput").val()
    sendData("market:sell", {
        amount: amount
    })
});

$(document).on('click', '#market-time', function() {
    var time = $(this).data("time")
    var lasthour = lastMarketDate.getHours();
    var lastMarketDate2 = new Date(lastMarketDate)
    
    if (time == "1") {
        var newhour = (parseInt(lasthour) - 1)
        lastMarketDate2.setHours(newhour);
        
        marketChart.options.scales.x.min = lastMarketDate2
        marketChart.options.scales.x.max = lastMarketDate
    } else if ( time == "3") {
        var newhour = (parseInt(lasthour) - 3)
        lastMarketDate2.setHours(newhour);
        
        marketChart.options.scales.x.min = lastMarketDate2
        marketChart.options.scales.x.max = lastMarketDate
    } else if ( time == "6") {
        var newhour = (parseInt(lasthour) - 6)
        lastMarketDate2.setHours(newhour);
        
        marketChart.options.scales.x.min = lastMarketDate2
        marketChart.options.scales.x.max = lastMarketDate
    } else if ( time == "12") {
        var newhour = (parseInt(lasthour) - 12)
        lastMarketDate2.setHours(newhour);
        
        marketChart.options.scales.x.min = lastMarketDate2
        marketChart.options.scales.x.max = lastMarketDate
    } else if ( time == "24") {
        marketChart.options.scales.x.min = firstMarketDate
        marketChart.options.scales.x.max = lastMarketDate
    }

    marketChart.update();
});