function rgba(hex, opacity) {
  hex = hex.replace("#", "");
  redColor = parseInt(hex.substring(0, 2), 16);
  greenColor = parseInt(hex.substring(2, 4), 16);
  blueColor = parseInt(hex.substring(4, 6), 16);

  result =
    "rgba(" +
    redColor +
    "," +
    greenColor +
    "," +
    blueColor +
    "," +
    opacity / 100 +
    ")";
  return result;
}

var loadJS = function (url, implementationCode, location) {
  var scriptTag = document.createElement("script");
  scriptTag.src = url;

  scriptTag.onload = implementationCode;
  scriptTag.onreadystatechange = implementationCode;

  location.appendChild(scriptTag);
};

function ajaxio(method, url, type = null, data = null) {
  return new Promise((resolve, reject) => {
    const req = new XMLHttpRequest();
    req.open(method, url, true);

    if (method == "POST") {
      if (type == "json" && data != null) {
        req.setRequestHeader("Content-Type", "application/json");
        var data = JSON.stringify(data);
      } else {
        req.setRequestHeader(
          "Content-Type",
          "application/x-www-form-urlencoded"
        );
      }
    }

    req.onload = () =>
      req.status === 200
        ? resolve(req.response)
        : reject(Error(req.statusText));
    req.onerror = (e) => reject(Error(`Network Error: ${e}`));

    if (method == "POST") {
      req.send(data);
    } else {
      req.send();
    }
  });
}

Object.prototype.addMultiListener = function (eventNames, listener) {
  var events = eventNames.split(" ");

  if (NodeList.prototype.isPrototypeOf(this) == true) {
    for (var x = 0, xLen = this.length; x < xLen; x++) {
      for (var i = 0, iLen = events.length; i < iLen; i++) {
        this[x].addEventListener(events[i], listener, false);
      }
    }
  } else if (HTMLElement.prototype.isPrototypeOf(this) == true) {
    for (var i = 0, iLen = events.length; i < iLen; i++) {
      this.addEventListener(events[i], listener, false);
    }
  }
};

window.onload = function () {
  var eventCallback = {
    ui: function (data) {
      var config = data.config;

      if (config.showWalletMoney == true) {
        document.querySelector("#wallet").style.display = "block";
      }
      if (config.showBankMoney == true) {
        document.querySelector("#bank").style.display = "block";
      }
      if (config.showBlackMoney == true) {
        document.querySelector("#blackMoney").style.display = "block";
      }
      if (config.showHunger == true) {
        document.getElementById('hunger').style.display = "block";
      }
      if (config.showThirst == true) {
        document.getElementById("thirst").style.display = "block";
      }
      if (config.showWeapons == true) {
        document.getElementById("weapon").style.display = "block";
      }
    },
    element: function (data) {
      try {
        if (data.task == "enable") {
          document.getElementById(data.value).style.display = "block";
        } else if (data.task == "disable") {
          document.getElementById(data.value).style.display = "none";
        }
      } catch (err) {
        return;
      }
    },
    setText: function (data) {
      var key = document.getElementById(data.id);
      var html = data.value;
      saferInnerHTML(key, html);
    },

    setMoney: function (data) {
      var key = document.getElementById(data.id);
      var html = "$ " + data.value.toLocaleString('en-US').replace(/,/g, ".");
      saferInnerHTML(key, html);
    },

    isTalking: function (data) {
      var voiceId = document.querySelector("#voice");
      if (data.value) {
        voiceId.classList.add("speak");
      } else {
        voiceId.classList.remove("speak");
      }
    },

    setStatus: function (data) {
      if (data.isdead == true) {
        if (
          document.getElementById('hunger').classList.contains("dead") == false
        ) {
          document.getElementById('hunger').classList.add("dead");
          for (i = 0; i < data.status.length; i++) {
            document.querySelector(
              "#" + data.status[i].name + " span"
            ).style.height = "0";
          }
        }
      } else {
        for (i = 0; i < data.status.length; i++) {
          if (data.status[i].name == "hunger" ||data.status[i].name == "thirst") {
            var statusValue = Math.floor(100 - data.status[i].value);
          } else {
            var statusValue = Math.floor(data.status[i].value);
          }
            if (statusValue <= 50 && statusValue > 20) {
            $("#"+data.status[i].name+"Img").attr("src",`./img/${data.status[i].name}_2.png`);
            document.getElementById(data.status[i].name+"Img").style.animation="none";
          } 
          else if(statusValue <= 20 && statusValue > 10) {
           $("#"+data.status[i].name+"Img").attr("src",`./img/${data.status[i].name}_3.png`);
            document.getElementById(data.status[i].name+"Img").style.animation="none";
          } 
          else if(statusValue <= 10) {
            $("#"+data.status[i].name+"Img").attr("src",`./img/${data.status[i].name}_3.png`);
            document.getElementById(data.status[i].name+"Img").style.animation="blink-1 3s ease-in-out infinite";
          }
          else {
            $("#"+data.status[i].name+"Img").attr("src",`./img/${data.status[i].name}_1.png`);
          }

        }
      }
    },

    updateWeapon: function (data) {
      var weaponContainer = document.querySelector("#weapon");
      var bulletsContainer = document.querySelector("#bullets");

      if (data.status.armed == true) {
        var oldWeapon = document.querySelector("#weapon_image img").src;
        var newWeapon = "img/weapons/" + data.status.weapon + ".png";
        if (oldWeapon != newWeapon) {
          document.querySelector("#weapon_image img").src = newWeapon;
        }

        if (weaponContainer.classList.contains("armed") == false) {
          weaponContainer.classList.remove("unarmed", "fadeOut");
          weaponContainer.classList.add("armed", "fadeIn");
        }
      } else {
        if (weaponContainer.classList.contains("unarmed") == false) {
          weaponContainer.classList.remove("armed", "fadeIn");
          weaponContainer.classList.add("unarmed", "fadeOut");
        }
      }
    },

    toggleUi: function (data) {
      var uiID = document.querySelector("#ui");
      if (data.value == true) {
        uiID.style.display = "block";
      } else {
        uiID.style.display = "none";
      }
    },
    playerID: function (data) {
      var playerID = document.getElementById("idP");
      playerID.innerHTML = data.value;
    },
  };
  window.addEventListener("message", function (event) {
    eventCallback[event.data.action](event.data);
  });
};
