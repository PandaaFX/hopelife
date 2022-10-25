$(function() {
    window.addEventListener("message", function(event) {
        var v = event.data;

        if (v.refreshusergraph == true) {
            Refreshusergraph(v.Data)
        } else if (v.refreshhome == true ) {
            RefreshHome(v.walletamount, v.walletworth, v.bitcoinprice)
        }
    });
});

function RefreshHome(walletamount, walletworth, bitcoinprice) {
    $("#home-walletbtc").html(walletamount)
    $("#home-walletworth").html(walletworth)
    $("#home-bitcoinprice").html(bitcoinprice)
}

var firsttime = true
var myChart

var firstDate = null
var lastDate = null
var lastDate2 = null
function Refreshusergraph(Data) {
    var newData = []
      


    if (firsttime == true)  {
        $.each( Data, function( key, value ) {
            var obj1 = value.x
            var obj2 = value.y
            newData.push({
                x: new Date(obj1),
                y: obj2
            })
            if (firstDate === null) {firstDate = new Date(obj1)}
            lastDate = new Date(obj1)
            lastDate2 = new Date(obj1)
        });

        var ctx = document.getElementById('myChart').getContext('2d');
        myChart = new Chart(ctx, {
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
                        min: firstDate,
                        max: lastDate,
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
        firsttime = false
    } else {
        var chart = myChart
        $.each( Data, function( key, value ) {
            var obj1 = value.x
            var obj2 = value.y

            test = {
                x: new Date(obj1),
                y: obj2
            }
             
            if (firstDate === null) {firstDate = new Date(obj1)}
            lastDate = new Date(obj1)
            lastDate2 = new Date(obj1)
            var lastminute = lastDate.getSeconds() + 1;
            lastDate.setSeconds(lastminute);
            addData(chart, test)
        });
        

        setTimeout(() => {
            myChart.options.scales.x.max = lastDate
            myChart.update();
        }, 100);
    }
  
}

function addData(chart, data) {
    chart.data.datasets.forEach((dataset) => {
        dataset.data.push(data);
    });
    chart.update();
}

function removeData(chart) {
    chart.data.labels.pop();
    chart.data.datasets.forEach((dataset) => {
        dataset.data.pop();
    });
    chart.update();
}

$(document).on('click', '#home-time', function() {
    var time = $(this).data("time")
    var lasthour = lastDate.getHours();
    var lastdate = lastDate.getDate();
    lastDate2 = new Date(lastDate)
    if (time == "1") {
        var newhour = (parseInt(lasthour) - 1)
        lastDate2.setHours(newhour);
        myChart.options.scales.x.min = lastDate2
        myChart.options.scales.x.max = lastDate
    } else if ( time == "3") {
        var newhour = (parseInt(lasthour) - 3)
        lastDate2.setHours(newhour);
        myChart.options.scales.x.min = lastDate2
        myChart.options.scales.x.max = lastDate
    } else if ( time == "6") {
        var newhour = (parseInt(lasthour) - 6)
        lastDate2.setHours(newhour);

        myChart.options.scales.x.min = lastDate2
        myChart.options.scales.x.max = lastDate
    } else if ( time == "12") {
        var newhour = (parseInt(lasthour) - 12)
        lastDate2.setHours(newhour);
        
        myChart.options.scales.x.min = lastDate2
        myChart.options.scales.x.max = lastDate
    } else if ( time == "24") {
        myChart.options.scales.x.min = firstDate
        myChart.options.scales.x.max = lastDate
    }

    myChart.update();
});