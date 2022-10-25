var toggle = false;

function searchcar() {
  // Declare variables
  var input, filter, ul, li, a, i, txtValue;
  input = document.getElementById("myInput");
  filter = input.value.toUpperCase();
  ul = document.getElementById("vehicle-list");
  li = ul.getElementsByTagName("div");

  // Loop through all list items, and hide those who don't match the search query
  for (i = 0; i < li.length; i++) {
    a = li[i].getElementsByTagName("a")[0];
    txtValue = a.textContent || a.innerText;
    if (txtValue.toUpperCase().indexOf(filter) > -1) {
      li[i].style.display = "";
    } else {
      li[i].style.display = "none";
    }
  }
}
$(document).ready(function () {
  window.addEventListener("message", function (event) {
    if (event.data.action == "open") {
      $(".head-switch-in").removeClass("selected");
      $(".head-switch-out").removeClass("selected");
      $(".head-switch-in").addClass("selected");

      toggle = false;

      $(".container").css("display", "block");
    } else if (event.data.action == "addcar") {
      AddCar(event.data.plate, event.data.name, event.data.model);
    } else {
      $("#vehicle-list").empty();
      $(".container").css("display", "none");
    }
  });

  $(".close").click(function () {
    $("#vehicle-list").empty();
    $(".container").css("display", "none");
    $.post("http://hl_frakshop/escape", JSON.stringify({}));
  });

  // $(".head-switch-in").click(function () {
  //   $(".head-switch-in").removeClass("selected");
  //   $(".head-switch-out").removeClass("selected");
  //   $(".head-switch-in").addClass("selected");

  //   const vehicles = document.getElementById("vehicle-list");
  //   vehicles.innerHTML = "";
  //   $.post("http://hl_frakshop/enable-parkout", JSON.stringify({}));
  //   toggle = false;
  // });

  // $(".head-switch-out").click(function () {
  //   $(".head-switch-in").removeClass("selected");
  //   $(".head-switch-out").removeClass("selected");
  //   $(".head-switch-out").addClass("selected");

  //   const vehicles = document.getElementById("vehicle-list");
  //   vehicles.innerHTML = "";

  //   $.post("http://hl_frakshop/enable-parking", JSON.stringify({}));

  //   toggle = true;
  // });
  document.onkeyup = function (data) {
    if (data.which == 27) {
      $("#vehicle-list").empty();
      $.post("http://hl_frakshop/escape", JSON.stringify({}));
      return;
    }
  };

  function checkImage(imageSrc, good, bad) {
    var img = new Image();
    img.onload = good;
    img.onerror = bad;
    img.src = imageSrc;
  }

  function AddCar(plate, name, model) {
    $("#vehicle-list").append(
      `
      
  <div class="vehicle">
    <div class="vehicle-inner">
      <img draggable="false" class="inner-icon" src="./cars/` +
        name +
        `.png">
    <a class="inner-label-knz"><i class="far fa-sticky-note"></i> Name: ` +
        model +
        `<br></a>
    <a class="inner-label-plate"><br><i class="fas fa-money-bill-wave-alt"></i> Preis: ` +
        plate +
        `$<br></a>
        <a class="inner-label-kaufen" onclick="parkOut('` +
        plate +
        `','` +
        name +
        `');" data-plate="` +
        plate +
        `"><br><i class="fas fa-shopping-cart"></i>
        &nbsp;Kaufen
        <br></a>
    </div>
  </div>
  `
    );
  }
});

function parkOut(plate, model) {
  $.post(
    "http://hl_frakshop/buy",
    JSON.stringify({
      plate,
      model,
    })
  );
}
