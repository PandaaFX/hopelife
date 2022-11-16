let int = 1;
window.addEventListener("message", (event) => {
  let item = event.data;
  let type = event.data.type;
  let color = event.data.color;
  let title = event.data.title;
  let message = event.data.message;
  let time = event.data.time;

  notify(item, type, color, title, message, time);
});

function notify(item, type, color, title, message, time) {
  if(time == null) time = 5500;
  // return console.log("nigbob")
  if(type == 1 && item !== undefined) {
    const content = $(
      `
      <div class="notification" id="notify-`+int+`" style="border-top: 5px `+color+` solid;">
        <div class="notification-title">
          <p style="color: #fff">` + title + `</p>
        </div>
        <p id="message">
          ` + message + `
        </p>
        <span class="notification-bar-fill" id="notification-bar-fill-`+int+`" style="width: 120%"></span>
      </div>
      `
    )
    
    $("#notifications").prepend(content);
    
    const kekkus = document.getElementById(`notify-${int}`);
    const kekkus2 = document.getElementById(`notification-bar-fill-${int}`);
    // kekkus.style.opacity = "1";
    int++;
    
    setTimeout(() => {
      kekkus2.style.width = "0%";
      kekkus2.style.background = color;
      kekkus2.style.transition = `width ${time}ms ease-in-out`
    }, 10);
    setTimeout(() => {
      kekkus2.style.width = "0%";
      kekkus2.style.background = color;
      kekkus2.style.transition = `width ${time}ms ease-in-out`
    }, 10);
    setTimeout(() => {
      // (function fade() {
      //   (kekkus.style.opacity -= 0.025) < 0
      //   ? setTimeout(removecontent(), 1500)
      //   : setTimeout(fade, 20);
      // })();
      // function removecontent() {
      //   // content.remove()
        
      // }

      // add class hide-opacity to kekkus
      kekkus.classList.add("hide-opacity");
      setTimeout(() => {
        content.remove()
      }, 3500);
      

    }, time);
  }else {
    return;
  }



}
