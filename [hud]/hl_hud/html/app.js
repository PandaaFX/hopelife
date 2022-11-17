





var testus = document.getElementById("clockP");
      var testus2 = document.getElementById("clockSpan");
      // insert in testus the current time and date in the german format: hh:mm dd.mm.yyyy
      testus.innerHTML = new Date().toLocaleString("de-DE", {
            hour: "2-digit",
            minute: "2-digit"
        }) + ' <span class="clockSpan" id="clockSpan">'+new Date().toLocaleString("de-DE", {day: "numeric",month: "numeric",year: "numeric",});+'</span>';

      // set the interval to 1 second
      setInterval(function () {
        // insert in testus the current time and date in the german format: hh:mm dd.mm.yyyy
        // testus.innerHTML = new Date().toLocaleString("de-DE", {
        //   hour: "2-digit",
        //   minute: "2-digit",
        //   day: "numeric",
        //   month: "numeric",
        //   year: "numeric",
        // });

        // insert in testus the current time
        testus.innerHTML = new Date().toLocaleString("de-DE", {
            hour: "2-digit",
            minute: "2-digit"
        }) + ' <span class="clockSpan" id="clockSpan">'+new Date().toLocaleString("de-DE", {day: "numeric",month: "numeric",year: "numeric",});+'</span>';

      }, 1000);
    