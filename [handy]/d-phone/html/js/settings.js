settings = {
  footer: {},
};

settings.show = function () {
  ShowHomebar();
  $('#settings').css({
    'z-index': '2',
  });
  $('#settings').animate({
    left: '0%',
  });

  Main.openapp = 'settings';
  if (footer.tabopen == '') {
    footer.open('#settings-home');
  }
};

var oldwallpaper = null;

oldcase = null;
oldmodel = null;

$(function () {
  window.addEventListener('message', function (event) {
    var v = event.data;

    if (v.ReloadWallpaper == true) {
      ReloadWallpaper(v.html);
    } else if (v.ReloadCases == true) {
      ReloadCases(v.html);
    } else if (v.setRingtone == true) {
      // incomingsoundfile = new Audio(v.ringtone);
      call.sound.set('incomming', v.ringtone);
    }
  });
});

function ReloadWallpaper(html) {
  $('#phone-app-settings-bg-inner').children().detach();
  $('#phone-app-settings-bg-inner').append(html);

  if (darkmode == true) {
    Darkmode();
  }

  form19 = document.getElementById('customwallpaper');

  form19.addEventListener(
    'mousedown',
    (event) => {
      sendData('SetNuiFocusKeepInputFalse');
    },
    true
  );

  form19.addEventListener(
    'focus',
    (event) => {
      sendData('SetNuiFocusKeepInputFalse');
    },
    true
  );

  form19.addEventListener(
    'blur',
    (event) => {
      sendData('SetNuiFocusKeepInputTrue');
    },
    true
  );
}

function ReloadCases(html) {
  $('#phone-app-settings-case-inner').children().detach();
  $('#phone-app-settings-case-inner').append(html);

  if (darkmode == true) {
    Darkmode();
  }
}

$(document).on('click', '#changewallpaper', function () {
  footer.tabopen = '#settings-home';
  footer.open('#settings-bg');
});

$(document).on('click', '#changecase', function () {
  footer.tabopen = '#settings-home';
  footer.open('#settings-case');
});

$(document).on('click', '#viewbackground', function () {
  var wallpaper = $(this).parent().data('wallpaper');
  var oldwallpaper2 = $('.phone-background').css('background-image');
  oldwallpaper = oldwallpaper2
    .replace('url(', '')
    .replace(')', '')
    .replace(/\"/gi, '');
  Wallpaperpreview(wallpaper);
});

$(document).on('click', '#viewcustombackground', function () {
  var wallpaper = $('#customwallpaper').val();

  var okay = CheckStringLength(wallpaper);

  if (okay == false) return;

  var pngcheck = CheckIfPng(wallpaper);

  if (pngcheck == false) return;

  var oldwallpaper2 = $('.phone-background').css('background-image');
  oldwallpaper = oldwallpaper2
    .replace('url(', '')
    .replace(')', '')
    .replace(/\"/gi, '');
  Wallpaperpreview(wallpaper);
});

function Wallpaperpreview(wallpaper) {
  CloseAll();
  // $("#phone-app-settings-bgchange").hide(500)
  $('.phone-homebar').hide(500);
  $('.wallpaperpreviewclose').show(500);
  ChangeWallpaper(wallpaper);
}

$(document).on('click', '.wallpaperpreviewcloseicon', function () {
  $('.phone-homebar').show(500);
  footer.tabopen = '#settings-home';
  footer.open('#settings-bg');
  settings.show();
  $('.wallpaperpreviewclose').hide(500);
  ChangeWallpaper(oldwallpaper);
});

$(document).on('click', '#setbackground', function () {
  var wallpaper = $(this).parent().data('wallpaper');
  sendData('changewallpaper', {
    url: wallpaper,
  });
  sendData('ReloadWallpaper');
});

$(document).on('click', '#custombackground', function () {
  var wallpaper = $('#customwallpaper').val();

  var okay = CheckStringLength(wallpaper);

  if (okay == false) return;

  var pngcheck = CheckIfPng(wallpaper);

  if (pngcheck == false) return;

  sendData('changewallpaper', {
    url: wallpaper,
  });
  sendData('ReloadWallpaper');
});

function openSettings(html, casehtml) {
  CloseAll();
  $('.phone-applications').hide();
  $('#phone-app-settings').show(500);
  $('#phone-homebar').show(500);

  $('#phone-app-settings-bg-inner').children().detach();
  $('#phone-app-settings-bg-inner').append(html);

  $('#phone-app-settings-case-inner').children().detach();
  $('#phone-app-settings-case-inner').append(casehtml);

  if (darkmode == true) {
    Darkmode();
  }

  form19 = document.getElementById('customwallpaper');

  form19.addEventListener(
    'mousedown',
    (event) => {
      sendData('SetNuiFocusKeepInputFalse');
    },
    true
  );

  form19.addEventListener(
    'focus',
    (event) => {
      sendData('SetNuiFocusKeepInputFalse');
    },
    true
  );

  form19.addEventListener(
    'blur',
    (event) => {
      sendData('SetNuiFocusKeepInputTrue');
    },
    true
  );
}

$(document).on('click', '#viewcase', function () {
  var cas = $(this).parent().data('case');
  var model = $(this).parent().data('model');

  Casepreview(cas, model);
});

$(document).on('click', '#setcase', function () {
  var cas = $(this).parent().data('case');
  var model = $(this).parent().data('model');

  Casepreview(cas, model, true);
});

function Casepreview(cas, model, save) {
  $('.phone-frame').attr('src', cas);
  if (model == 'samsung') {
    $('.phone-header').css('grid-template-columns', '5% 25% 20% 10% 12.5% 5%');
  } else {
    $('.phone-header').css('grid-template-columns', '5% 25% 40% 10% 12.5% 5%');
  }

  var width = 29;
  var borderradius = '4vh';
  var right = '0.5vh';
  if (model == 'iphone14') {
    width = 28;
    borderradius = '5vh';
    right = '1vh';
  }
  $('.phone-container').css({
    width: width + 'vh',
    'border-radius': borderradius,
    right: right,
  });
  var phoneappwidth = width - 3;
  // console.log(phoneappwidth);
  $('.phone-app-div').css('width', phoneappwidth + 'vh');

  if (save == true) {
    sendData('changecase', {
      case: cas,
      model: model,
    });
    sendData('ReloadCases');
    oldcase = cas;
    oldmodel = model;
  } else {
    oldcase = './img/model1.png';
    oldmodel = 'iphone';
  }
}

function LoadRingtones(html) {
  $('#phone-app-settings-ringtones-inner').children().detach();
  $('#phone-app-settings-ringtones-inner').append(html);
}

$(document).on('click', '#changeringtone', function () {
  footer.tabopen = '#settings-home';
  footer.open('#settings-ringtone');
});

var soundtest = null;
var PlaySound = 'null';
var lastsound = null;

$(document).on('click', '#viewringtone', function () {
  if (PlaySound == 'null') {
    var path = $(this).parent().data('ringtone');
    soundtest = new Audio(path);
    soundtest.volume = 0.2;
    soundtest.loop = true;
    soundtest.currentTime = 0;
    soundtest.play();
    PlaySound = 'true';

    lastsound = $(this);
    $(this).removeClass('fa-bell');
    $(this).addClass('fa-bell-slash');
  } else if (PlaySound == 'true') {
    lastsound.removeClass('fa-bell-slash');
    lastsound.addClass('fa-bell');
    soundtest.pause();
    PlaySound = 'null';
  }
});

$(document).on('click', '#setringtone', function () {
  var ringtone = $(this).parent().data('ringtone');

  sendData('changeringtone', {
    url: ringtone,
  });
  // incomingsoundfile = new Audio(ringtone);
  call.sound.set('incomming', ringtone);
});

$(document).on('click', '#viewcustomringtone', function () {
  var ringtone = $('#customringtone').val();
  if (PlaySound == 'null') {
    var path = ringtone;

    soundtest = new Audio(path);
    soundtest.volume = 0.2;
    soundtest.loop = true;
    soundtest.currentTime = 0;
    soundtest.play();
    PlaySound = 'true';

    lastsound = $(this);
    $(this).removeClass('fa-bell');
    $(this).addClass('fa-bell-slash');
  } else if (PlaySound == 'true') {
    lastsound.removeClass('fa-bell-slash');
    lastsound.addClass('fa-bell');
    soundtest.pause();
    PlaySound = 'null';
  }
});

$(document).on('click', '#setcustomringtone', function () {
  var ringtone = $('#customringtone').val();

  sendData('changeringtone', {
    url: ringtone,
  });
  // incomingsoundfile = new Audio(ringtone);
  call.sound.set('incomming', ringtone);
});

$(document).on('click', '#appnamecb', function () {
  if ($(this).hasClass('checked')) {
    apptext(true);
    sendData('settings:apptext', {
      state: 1,
    });
  } else {
    apptext(false);
    sendData('settings:apptext', {
      state: 0,
    });
  }
});

$(document).on('click', '#flightmodecb', function () {
  if ($(this).hasClass('checked')) {
    sendData('flightmode', { state: 1 });
    $('#phone-flightmode').show();
  } else {
    sendData('flightmode', { state: 0 });
    $('#phone-flightmode').hide();
  }
});

$(document).on('click', '#mutecb', function () {
  if ($(this).hasClass('checked')) {
    mutes = true;
    $('#phone-mute').show();
  } else {
    mutes = false;
    $('#phone-mute').hide();
  }
});

$(document).on('click', '#darkmodecb', function () {
  if ($(this).hasClass('checked')) {
    Darkmode();
    darkmode = true;
    sendData('changedarkmode', { state: 1 });
  } else {
    darkmode = false;
    Whitemode();
    sendData('changedarkmode', { state: 0 });
  }
});

$(document).on('click', '#anonymouscb', function () {
  if ($(this).hasClass('checked')) {
    sendData('anonymous', { state: 1 });
  } else {
    sendData('anonymous', { state: 0 });
  }
});

$(document).on('click', '#settings-home-restart', function () {
  sendData('settings:restart');
});

$(document).on('click', '#changevolume', function () {
  Inputarea.show(
    'ringtonevolume',
    'fa-solid fa-volume-high',
    'setringtonevolume',
    'number',
    false
  );
});
