let currentjob = 'null';
let businessicon = true;
let servicesloaded = false;
let backgroundurl = null;
let darkbackgroundurl = null;
let lastservicenumber = null;
let darkmode = false;
let bankmoney = null;
let alwayson = false;
let lastwindow = null;
let privatmessage = null;
lasthomebarwindow = null;
let firsttime = false;
var soundvolume = 0.2;
var ringtone;

var Messagesoundfile = new Audio('./sound/Google_Event.ogg');
var BMessagesoundfile = new Audio('./sound/message_tone.ogg');
var outgoingsoundfile = new Audio('./sound/Phonecall.ogg');
var incomingsoundfile = null;

Main = {
  openapp: null,
};

$(function () {
  var r = document.querySelector(':root');
  r.style.setProperty('--header-color', 'white');
  var documentWidth = document.documentElement.clientWidth;
  var documentHeight = document.documentElement.clientHeight;
  var container = $('.container');

  window.addEventListener('message', function (event) {
    var item = event.data;

    if (item.showPhone) {
      BottomSlideUp('.container', 300, 0);
      ChangeWallpaper(item.wallpaper);
      if (item.darkmode == 1) {
        Darkmode();
        darkmode = true;
        $('#darkmodecb').addClass('checked');
      } else {
        Whitemode();
      }

      // if (item.data.flightmode == 1) {
      //     $("#phone-flightmode").show();
      //     sendData("flightmode", { state: 1 });
      //     document.getElementById("flightmode").checked = true;
      // } else {
      //     $("#phone-flightmode").hide();
      //     sendData("flightmode", { state: 0 });
      //     document.getElementById("flightmode").checked = false;
      // }
      alwayson = item.alwayson;
      $('.phone-message').hide();

      if (item.unemployed) {
        if (businessicon == true) {
          $('#businessicon').hide();
        }
        businessicon = false;
      }

      $('.phone-startscreen').fadeOut(500);
    } else if (item.hidePhone) {
      if (alwayson == false) {
        BottomSlideDown('.container', 300, -70);
      } else {
        $('.container').animate({
          bottom: '-62vh',
        });
      }

      $('.image-preview').fadeOut(500);

      // $(".container").animate({
      //     "bottom": "-62vh",
      // })
    } else if (item.hidePhoneInCall) {
      $('.container').animate({
        bottom: '-40vh',
      });
    } else if (item.OpenincomingCall) {
      $('.container').css({
        bottom: '-70vh',
      });
      $('.container').show();
      $('.container').animate({
        bottom: '-50vh',
      });
    } else if (item.CloseincomingCall) {
      $('.container').animate({
        bottom: '-70vh',
      });
    } else if (item.loadBusiness) {
      loadBusiness(item.business);
    } else if (item.removeBusiness) {
      removeBusiness();
    } else if (item.showContacts) {
      loadcontacts(item.html);
    } else if (item.showNotification) {
      ShowNotif(item);
    } else if (item.showMessages) {
      loadmessages(item.html, item.contactname);
    } else if (item.showRecentMessages) {
      if (item.recentmessagesopen == true) {
        reloadrecentmessages(item.html);
      } else {
        loadrecentmessages(item.html);
      }
    } else if (item.changeWallpaper) {
      ChangeWallpaper(item.url);
    } else if (item.acceptCall) {
      AcceptCall(item.number, item.contact);
    } else if (item.incomingCall) {
      IncomingCall(item.number, item.contact);
    } else if (item.endcall) {
      EndCall();
    } else if (item.declinecall) {
      DeclineCall();
    } else if (item.stopcall) {
      StopCall(item);
    } else if (item.loadrecentcalls) {
      loadrecentcalls(item.recentcalls);
    } else if (item.playmessagesound) {
      PlayMessageSound();
    } else if (item.playbusinessmessagesound) {
      PlayBMessageSound();
    } else if (item.updatetime) {
      UpdateTime(item.showinGameTime, item.ingametime);
    } else if (item.setvalues) {
      backgroundurl = item.backgroundurl;
      darkbackgroundurl = item.darkbackgroundurl;
      cas = item.cas;
      model = item.model;
      Casepreview(cas, model);
      call.sound.set('incomming', item.ringtone);

      apptext(item.apptext);
    } else if (item.syncbpbabutton) {
      syncbpbabutton(item.number);
    } else if (item.syncclosebmessage) {
      syncclosebmessage(item.number);
    } else if (item.updatenumber) {
      $('#phonesettingsnumber').html(item.number);
    } else if (item.updatejobmoney) {
      businessmoney = item.businessmoney;
      $('#pbms-money').html(item.businessmoney + '$');
    } else if (item.isboss) {
      // if (locale == "de") {
      //     sendData("notification", { text: localede.pbsjobmoney, length: 5000 })
      // } else {
      //     sendData("notification", { text: locale.pbsjobmoney, length: 5000 })
      // }
      $('#pbsboss').each(function () {
        $(this).show();
      });
    } else if (item.isntboss) {
      $('#pbsboss').each(function () {
        $(this).hide();
      });
    } else if (item.autodecline) {
      Autodecline();
    } else if (item.refreshmessages) {
      if (privatmessage == item.number) {
        refreshmessages(item.html, item.contactname);
      }
    } else if (item.refreshbusinessmessages) {
      reloadbusinessmessages(item.html, item.div);
    } else if (item.enablesalty) {
      $('#phone-constant-radio').show();
    } else if (item.openSettings) {
      openSettings(item.html, item.casehtml);
    } else if (item.LoadRingtones) {
      LoadRingtones(item.html);
    } else if (item.startloadingscreen) {
      BottomSlideUp('.container', 300, 0);
      Startloadingscreen(item.time);
    } else if (item.hidestartscreen) {
      if ($('.phone-startscreen').is(':visible')) {
        CloseAll();
        $('.phone-startscreen').hide(0);
        if (callrequest == false) $('.phone-applications').show(0);
      }
    } else if (item.radioicon) {
      RadioIcon(item.state);
    } else if (item.hideapp) {
      AppIcon(item.app, false);
    } else if (item.setcurrency) {
      currency = item.currency;
    } else if (item.reload) {
      Home();
      // BottomSlideUp('.container', 300, 0);
      Startloadingscreen(item.time);
      $('.phone-homebar').hide(0);
    } else if (item.closeall) {
      CloseAll();
      $('.phone-homebar').hide(0);
    } else if (item.setnotifiaction) {
      SetNotificationPosition(item.option);
    }
  });

  $(document).keyup(function (data) {
    // Change closing Phone http://gcctech.org/csc/javascript/javascript_keycodes.htm
    if (data.which == 27) {
      sendData('close');
    }
  });
});

function sendData(name, data) {
  $.post('http://d-phone/' + name, JSON.stringify(data), function (datab) {
    // console.log(datab);
  });
}

function print(text) {
  sendData('print', { message: text });
}

function playSound(sound) {
  sendData('playsound', { name: sound });
}

function hide() {
  $('#menuoption1').hide();
}

BottomSlideUp = function (Object, Timeout, Percentage) {
  $(Object)
    .css({ display: 'block' })
    .animate(
      {
        bottom: Percentage + '%',
      },
      Timeout
    );
};

BottomSlideDown = function (Object, Timeout, Percentage) {
  $(Object)
    .css({ display: 'block' })
    .animate(
      {
        bottom: Percentage + '%',
      },
      Timeout,
      function () {
        $(Object).css({ display: 'none' });
      }
    );
};

TopSlideDown = function (Object, Timeout, Percentage) {
  $(Object)
    .css({ display: 'block' })
    .animate(
      {
        top: Percentage + '%',
      },
      Timeout
    );
};

TopSlideUp = function (Object, Timeout, Percentage, cb) {
  $(Object)
    .css({ display: 'block' })
    .animate(
      {
        top: Percentage + '%',
      },
      Timeout,
      function () {
        $(Object).css({ display: 'none' });
      }
    );
};

var cooldown = false;
$(document).on('click', '.phone-application', function (e) {
  e.preventDefault();

  if (cooldown == true) return;
  if (footer.cooldown == true) return;

  cooldown = true;
  if (prepage != null) {
    currentpage = lastpage;
    lastpage = prepage;
  }
  var r = document.querySelector(':root');
  r.style.setProperty('--header-color', 'var(--font-color');

  var PressedApplication = $(this).data('app');
  var AppObject = $('.' + PressedApplication + '-app');
  CloseAll();
  if (PressedApplication == 'settings') {
    // $("#phone-app-settings").show(500)
    settings.show();
    sendData('LoadSettings');
    sendData('LoadRingtones');
  } else if (PressedApplication == 'contacts') {
    $('.phone-applications').hide();
    sendData('LoadContacts');
    if (darkmode == true) {
      Darkmode();
    }
    $('#phone-homebar').show(500);
    Main.openapp = 'contacts';
  } else if (PressedApplication == 'call') {
    call.show();
  } else if (PressedApplication == 'messages') {
    messages.show();
    Main.openapp = 'messages';
  } else if (PressedApplication == 'services') {
    Services.show();
  } else if (PressedApplication == 'business') {
    business.show();
  } else if (PressedApplication == 'radio') {
    $('.phone-applications').hide();
    $('.phone-radio-sector').hide(0);
    $('.phone-radio').show(500);
    $('.phone-radio-sector').show(500);
    $('#phone-homebar').show(500);
    Main.openapp = 'radio';
  } else if (PressedApplication == 'camera') {
    sendData('openCamera');
    $('.phone-applications').show();
    Main.openapp = 'camera';
  } else if (PressedApplication == 'twitter') {
    $('.phone-applications').hide();
    sendData('twitter:open');
    $('#phone-homebar').show(500);
    // $(".phone-twitter").fadeIn(500);
    // $(".phone-tweets").fadeIn(500);
    Main.openapp = 'twitter';
  } else if (PressedApplication == 'bank') {
    $('.phone-applications').hide();
    sendData('banking:open');
    Main.openapp = 'bank';
  } else if (PressedApplication == 'advertisement') {
    $('.phone-applications').hide();
    $('#phone-homebar').show(500);
    sendData('advertisement:open');
    // $(".phone-advertisement").show(500)
    Main.openapp = 'advertisement';
  } else if (PressedApplication == 'dmarket') {
    $('.phone-applications').hide();
    $('#phone-homebar').show(500);
    sendData('dmarket:open');
    Main.openapp = 'dmarket';
    // $(".phone-dmarket").show(500)
  } else if (PressedApplication == 'calculator') {
    $('.phone-applications').hide();
    $('#phone-homebar').show(500);
    $('.phone-calculator').show(500);
  } else if (PressedApplication == 'crypto') {
    if (bitcoinapploaded == true) {
      $('.phone-applications').hide();
      $('#phone-app-bitcoin').show(500);
      if (darkmode == true) {
        Darkmode();
      }
      $('#phone-homebar').show(500);
      Main.openapp = 'crypto';
    } else {
      firsttimecrypto = true;
      sendData('bitcoin:firsttime');
    }
  } else if (PressedApplication == 'truck') {
    truck.show();
  } else if (PressedApplication == 'broker') {
    broker.show();
  } else if (PressedApplication == 'groupchat') {
    groupchat.show();
  } else if (PressedApplication == 'darkchat') {
    darkchat.show();
  } else if (PressedApplication == 'paragraph') {
    paragraph.show();
  } else if (PressedApplication == 'djump') {
    djump.show();
  } else if (PressedApplication == 'gallery') {
    gallery.show();
  } else if (PressedApplication == 'mail') {
    mail.show();
  } else if (PressedApplication == 'jobmail') {
    jobmail.show();
  } else if (PressedApplication == 'snake') {
    snake.show();
  } else if (PressedApplication == 'garage') {
    garage.show();
  }

  setTimeout(() => {
    cooldown = false;
  }, 1500);
});

$(document).on('click', '#changewallpaper', function () {
  $('.phone-settings-wallpaper ').show(500);
});

$(document).on('click', '#backwallaper', function () {
  $('.phone-settings-wallpaper ').fadeOut(250);
});

$(document).on('click', '#pswsubmitbutton', function () {
  var avatar = $('#psw').val();
  var message1 = $('#psw').val().toLowerCase();

  if (
    message1.indexOf('script') > -1 ||
    message1.includes('<audio') == true ||
    message1.includes('</audio') == true ||
    message1.includes('html') == true ||
    message1.includes('iframe') == true ||
    message1.includes('src') == true ||
    message1.includes('div') == true ||
    message1.includes('div') == true ||
    message1.includes('mp4') == true ||
    message1.includes('<') == true ||
    message1.includes('>') == true
  ) {
    sendData('notification', { text: 'Nice try d:^)', length: 5000 });
  } else {
    if (
      avatar.includes('png') == true ||
      avatar.includes('jpeg') == true ||
      avatar.includes('jpg') == true ||
      avatar.includes('gif') == true
    ) {
      sendData('changewallpaper', {
        url: avatar,
      });

      $('.phone-settings-wallpaper ').fadeOut(250);
    } else {
      if (locale == 'de') {
        sendData('notification', { text: localede.avatarerror, length: 5000 });
      } else {
        sendData('notification', { text: locale.avatarerror, length: 5000 });
      }
    }
  }
});

function ChangeWallpaper(url) {
  if (url == '') {
    $('.phone-background').css(
      'background-image',
      'url(' + backgroundurl + ')'
    );
  } else {
    $('.phone-background').css('background-image', 'url("' + url + '")');
    $('.phone-background').css('background-size', 'cover');
  }
}

/*  Notification  */
function SetNotificationPosition(option) {
  // console.log('notification position');
  var css = 'center';
  if (option == 'left') {
    css = 'flex-start';
  } else if (option == 'right') {
    css = 'flex-end';
  }
  // console.log(css);
  $('.notifybody').css({
    'justify-content': css,
  });
}

function ShowNotif(data) {
  $('.notification').prepend(data.html);
  var $notification = $('#' + data.id);
  $notification.fadeIn();
  setTimeout(
    function () {
      $.when($notification.fadeOut()).done(function () {
        $notification.remove();
      });
    },
    data.length != null ? data.length : 2500
  );
}

let selectedservice = 'null';
let serviceopen = 'null';

$(document).on('click', '#phone-service-return', function () {
  if (serviceopen == 'null') {
    $('.phone-services').hide();
    $('.phone-applications').show(500);
  } else if (serviceopen == 'sendmessage') {
    $('.phone-services-message').hide();
    $('.phone-services-sector').show(500);

    serviceopen = 'null';
  }
});

$(document).on('click', '.phone-service', function () {
  $('.phone-services-sector').hide();
  $('.phone-services-message').show(500);

  serviceopen = 'sendmessage';
  selectedservice = $(this).data('service');
});

$(document).on('click', '#phone-service-button', function () {
  $('.phone-services-sector').show();
  $('.phone-services-message').hide();
  $('.phone-services').hide();
  $('.phone-applications').show(500);
  serviceopen = 'null';

  let sendnumber = 0;
  let sendgps = 0;
  selectednumber = selectedservice;
  let message = $('.phone-service-message-input').val();
  if (document.getElementById('sendnumber').checked) {
    sendnumber = 1;
  }
  if (document.getElementById('sendgps').checked) {
    sendgps = 1;
  }
  let message1 = $('.phone-service-message-input').val().toLowerCase();
  if (
    message1.indexOf('script') > -1 ||
    message1.indexOf('http') > -1 ||
    message1.indexOf('www') > -1 ||
    message1.includes('<audio') == true ||
    message1.includes('</audio') == true
  ) {
    sendData('notification', { text: 'Nice try d:^)', length: 5000 });
  } else {
    if (message.length > 0) {
      sendData('sendservice', {
        service: selectedservice,
        message: message,
        sendnumber: sendnumber,
        job: currentjob,
        sendgps: sendgps,
      });
    } else {
      if (locale == 'de') {
        sendData('notification', { text: localede.notempty, length: 5000 });
      } else {
        sendData('notification', { text: locale.notempty, length: 5000 });
      }
    }
  }
});

let businessapp = null;
let openbusinesswindow = null;

function loadBusiness(item) {
  businessapp = item;
  $('#businessicon').show();
}

function removeBusiness() {
  $('#businessicon').hide();
  $('#jobmailiicon').hide();
}

function showBusiness(member, onlinemember, motd) {
  $('.phone-ba-member-list').children().detach();
  $('.phone-ba-member-list').append(member);

  if (locale == 'de') {
    document.getElementById('phone-ba-member').innerHTML =
      localede.memberonline + ' : ' + onlinemember;
  } else {
    document.getElementById('phone-ba-member').innerHTML =
      locale.memberonline + ' : ' + onlinemember;
  }

  document.getElementById('phone-ba-motd-inhalt').innerHTML = motd;

  $('.phone-recent-businessapp-sector').hide();
  $('.phone-businessapp-message').hide();
  $('.phone-applications').hide();
  $('.phone-businessapp-settings').hide();
  CloseAll();
  $('.phone-businessapp-sector').show();
  $('.phone-businessapp').show(500);
  $('#phone-homebar').show(500);
}

$(document).on('click', '#phone-businessapp-return', function () {
  $('.phone-applications').hide();
  $('.phone-businessapp').show(500);
});

$(document).on('click', '#phone-ba-member-call', function () {
  let name = $(this).data('name');
  let number = $(this).data('number');

  var element = document.getElementById('phone-call-outgoing-caller');
  element.innerHTML = name;
  $('.phone-call').hide();
  $('.phone-businessapp').hide();
  $('.phone-call-app').show();
  $('.phone-call-outgoing').show(500);

  if (mutes == true) {
    if (locale == 'de') {
      sendData('notification', { text: localede.yourecallingsb, length: 5000 });
    } else {
      sendData('notification', { text: locale.yourecallingsb, length: 5000 });
    }
  } else {
    if (outgoingsound != null) {
      outgoingsound.pause();
    }

    outgoingsound = outgoingsoundfile;
    outgoingsound.volume = soundvolume;
    outgoingsound.loop = true;
    outgoingsound.currentTime = 0;
    outgoingsound.play();
  }

  sendData('startcall', { number: number, contact: name });

  lastcontact = 'null';
});

$(document).on('click', '#phone-ba-member-message', function () {
  let number = $('#phone-ba-member-call').data('number');
  let name = $('#phone-ba-member-call').data('name');
  $('.phone-businessapp').hide();

  selectednumber = number;

  sendData('loadmessage', {
    number: number,
  });
});

$(document).on('click', '#pbf-member', function () {
  openbusinesswindow = 'home';
  $('.phone-businessapp-settings').hide();
  $('.phone-businessapp-rank-sector').hide();
  $('.phone-businessapp-newrank-sector').hide();
  $('.phone-businessapp-money-sector').hide(0);
  sendData('showBusiness', { job: currentjob });
});

$(document).on('click', '#pbf-messages', function () {
  openbusinesswindow = 'recentmessages';
  $('.phone-businessapp-settings').hide();
  $('.phone-businessapp-rank-sector').hide();
  $('.phone-businessapp-newrank-sector').hide();
  $('.phone-businessapp-money-sector').hide(0);
  sendData('showBusinessMessages', { job: currentjob });
});

$(document).on('click', '#pbf-settings', function () {
  openbusinesswindow = 'settings';
  $('.phone-recent-businessapp-sector').hide();
  $('.phone-businessapp-message').hide();
  $('.phone-businessapp-rank-sector').hide();
  $('.phone-businessapp-newrank-sector').hide();
  $('.phone-businessapp-money-sector').hide(0);
  $('.phone-businessapp-sector').hide();
  $('.phone-businessapp-settings').show(500);
});

function loadrecentbusinessmessages(html) {
  $('.phone-recent-businessapp-sector').children().detach();
  $('.phone-recent-businessapp-sector').append(html);
  if (darkmode == true) {
    Darkmode();
  }

  if (openbusinesswindow == 'recentmessages') {
    $('.phone-businessapp-sector').hide();
    $('.phone-recent-businessapp-sector').show(500);
  }
}

$(document).on('click', '.phone-recent-businessapp-selection', function () {
  let number = $(this).data('number');
  selectednumber = $(this).data('number');
  lastservicenumber = selectednumber;
  sendData('loadbusinessmessage', {
    number: number,
    job: currentjob,
  });
});

function loadbusinessmessages(html, div) {
  $('.phone-businessapp-message').children().detach();
  $('.phone-businessapp-message').append(div);

  if (locale == 'de') {
    $('#pbbacceptfont ').html(localede.pbbacceptfont);
    $('#pbbacceptfont2 ').html(localede.pbbacceptfont2);
  } else {
    $('#pbbacceptfont ').html(locale.pbbacceptfont);
    $('#pbbacceptfont2 ').html(locale.pbbacceptfont2);
  }

  $('.phone-businessapp-chat').children().detach();
  $('.phone-businessapp-chat').append(html);
  if (darkmode == true) {
    Darkmode();
  }
  $('.phone-recent-businessapp-sector').hide();
  $('.phone-businessapp-message').show(500);
  $('.phone-businessapp-chat').scrollTop(
    $('.phone-businessapp-chat')[0].scrollHeight
  );
  lastwindow = 'businessmessage';
}

function reloadbusinessmessages(html, div) {
  $('.phone-businessapp-message').children().detach();
  $('.phone-businessapp-message').append(div);

  if (locale == 'de') {
    $('#pbbacceptfont ').html(localede.pbbacceptfont);
    $('#pbbacceptfont2 ').html(localede.pbbacceptfont2);
  } else {
    $('#pbbacceptfont ').html(locale.pbbacceptfont);
    $('#pbbacceptfont2 ').html(locale.pbbacceptfont2);
  }

  $('.phone-businessapp-chat').children().detach();
  $('.phone-businessapp-chat').append(html);
  if (darkmode == true) {
    Darkmode();
  }
  $('.phone-businessapp-chat').scrollTop(
    $('.phone-businessapp-chat')[0].scrollHeight
  );
  lastwindow = 'businessmessage';
}

$(document).on('click', '#phone-businessapp-send', function () {
  var message = $('#phone-business-input-message').val();
  let message1 = $('#phone-business-input-message').val().toLowerCase();

  if (
    message1.indexOf('script') > -1 ||
    message1.indexOf('http') > -1 ||
    message1.indexOf('www') > -1 ||
    message1.includes('<audio') == true ||
    message1.includes('</audio') == true
  ) {
    sendData('notification', { text: 'Nice try d:^)', length: 5000 });
  } else {
    if (message.length > 0) {
      sendData('sendbusinessmessage', {
        message: message,
        number: selectednumber,
        job: currentjob,
      });
    } else {
      if (locale == 'de') {
        sendData('notification', { text: localede.notempty, length: 5000 });
      } else {
        sendData('notification', { text: locale.notempty, length: 5000 });
      }
    }
  }

  document.getElementById('phone-business-input-message').value = '';
});

$(document).on('click', '#phone-businessapp-placeicon', function () {
  sendData('sendbusinessgps', {
    number: selectednumber,
    job: currentjob,
  });
});

$(document).on('click', '#phone-businessapp-return', function () {
  $('.phone-recent-businessapp-sector').hide();
  $('.phone-businessapp-message').hide();
  $('.phone-businessapp-settings').hide();
  $('.phone-businessapp-sector').show();
  $('.phone-businessapp').hide();

  $('.phone-applications').show(500);

  lastwindow = null;
});

$(document).on('click', '#enablejobnumber', function () {
  sendData('enablejobnumber', { job: currentjob });
});

$(document).on('click', '#changemotd', function () {
  $('.phone-businessapp-motd').show(500);
});

$(document).on('click', '#backmotd', function () {
  $('.phone-businessapp-motd').fadeOut(250);
});

let businessid = null;
$(document).on('click', '#phone-ba-member-managment', function () {
  $('.phone-businessapp-sector').hide(0);
  $('.phone-businessapp-rank-sector').show(500);
  var name = $(this).data('name');
  var rank = $(this).data('rank');
  var grade = $(this).data('grade');
  businessid = $(this).data('id');
  $('#pbrs-name').html(name);
  $('#pbrs-rankname').html(rank);
  $('#pbrs-grade').html(grade);
});

$(document).on('click', '#pbrs-uprank', function () {
  sendData('businessapp:uprank', {
    id: businessid,
    grade: $('#pbrs-grade').html(),
  });
  CloseAll();
  Home();
});
$(document).on('click', '#pbrs-derank', function () {
  sendData('businessapp:derank', {
    id: businessid,
    grade: $('#pbrs-grade').html(),
  });
  CloseAll();
  Home();
});

$(document).on('click', '#pbrs-fire', function () {
  sendData('businessapp:fire', { id: businessid });
  CloseAll();
  Home();
});

$(document).on('click', '#pbrs-recruit', function () {
  let id = $('#pbns-id').val();
  let newrank = $('#pbns-newrank2').val();

  let message1 = $('#pbns-id').val().toLowerCase();
  let newrank2 = $('#pbns-newrank2').val().toLowerCase();

  if (
    message1.indexOf('script') > -1 ||
    message1.indexOf('http') > -1 ||
    message1.indexOf('www') > -1 ||
    message1.includes('<audio') == true ||
    message1.includes('</audio') == true
  ) {
    sendData('notification', { text: 'Nice try d:^)', length: 5000 });
  } else {
    if (
      newrank2.indexOf('script') > -1 ||
      newrank2.indexOf('http') > -1 ||
      newrank2.indexOf('www') > -1 ||
      newrank2.includes('<audio') == true ||
      newrank2.includes('</audio') == true
    ) {
      sendData('notification', { text: 'Nice try d:^)', length: 5000 });
    } else {
      sendData('businessapp:recruit', { id: id, rank: newrank });
    }
  }

  CloseAll();
  Home();
});

$(document).on('click', '#pbrs-updaterank', function () {
  let newrank = $('#pbns-newrank').val();
  let message1 = $('#pbns-newrank').val().toLowerCase();

  if (
    message1.indexOf('script') > -1 ||
    message1.indexOf('http') > -1 ||
    message1.indexOf('www') > -1 ||
    message1.includes('<audio') == true ||
    message1.includes('</audio') == true
  ) {
    sendData('notification', { text: 'Nice try d:^)', length: 5000 });
  } else {
    sendData('businessapp:updaterank', { id: businessid, rank: newrank });
  }

  CloseAll();
  Home();
});

$(document).on('click', '#seejobmoney', function () {
  $('.phone-businessapp-settings').hide(0);
  $('.phone-businessapp-money-sector').show(500);
  $('#pbms-money').html(businessmoney + '$');
});

$(document).on('click', '#pmbs-deposit', function () {
  let amount = $('#pbms-amount').val();
  let message1 = $('#pbms-amount').val().toLowerCase();
  if (
    message1.indexOf('script') > -1 ||
    message1.indexOf('http') > -1 ||
    message1.indexOf('www') > -1 ||
    message1.includes('<audio') == true ||
    message1.includes('</audio') == true
  ) {
    sendData('notification', { text: 'Nice try d:^)', length: 5000 });
  } else {
    sendData('businessapp:depositmoney', { amount: amount });
  }
});

$(document).on('click', '#pmbs-withdraw', function () {
  let amount = $('#pbms-amount').val();
  let message1 = $('#pbms-amount').val().toLowerCase();
  if (
    message1.indexOf('script') > -1 ||
    message1.indexOf('http') > -1 ||
    message1.indexOf('www') > -1 ||
    message1.includes('<audio') == true ||
    message1.includes('</audio') == true
  ) {
    sendData('notification', { text: 'Nice try d:^)', length: 5000 });
  } else {
    sendData('businessapp:withdrawmoney', { amount: amount });
  }
});

$(document).on('click', '#phone-addnewmember', function () {
  $('.phone-businessapp-sector').hide(0);
  $('.phone-businessapp-newrank-sector').show(500);
});

$(document).on('click', '#motdsubmit', function () {
  $('.phone-businessapp-motd').fadeOut(250);
  var message = $('#motd').val();
  let message1 = $('#motd').val().toLowerCase();
  if (
    message1.indexOf('script') > -1 ||
    message1.indexOf('http') > -1 ||
    message1.indexOf('www') > -1 ||
    message1.includes('<audio') == true ||
    message1.includes('</audio') == true
  ) {
    sendData('notification', { text: 'Nice try d:^)', length: 5000 });
  } else {
    sendData('changemotd', { job: currentjob, message: message });
  }
});

function bpbaccept() {
  var acceptbutton = '#bpb-accept-' + selectednumber;
  var declinebutton = '#bpb-decline-' + selectednumber;

  $(acceptbutton).css({ width: '0%', tranistion: '.5' });
  $(acceptbutton).css({ display: 'none' });
  $(declinebutton).css({ width: '100%', tranistion: '.5' });

  sendData('serviceaccept', {
    number: selectednumber,
    job: currentjob,
  });
}

function bpbdecline() {
  var acceptbutton = '#bpb-accept-' + selectednumber;
  var declinebutton = '#bpb-decline-' + selectednumber;

  sendData('serviceclose', {
    number: selectednumber,
    job: currentjob,
  });

  $(acceptbutton).css({ display: 'none' });
  $(declinebutton).css({ width: '50%', tranistion: '.5' });

  syncclosebmessage(selectednumber);
}

function syncclosebmessage(number) {
  if (lastservicenumber == number) {
    $('.phone-businessapp-message').hide();
    sendData('showBusinessMessages', { job: currentjob });

    lastservicenumber = null;
  }
}

function syncbpbabutton(selectednumber) {
  var acceptbutton = '#bpb-accept-' + selectednumber;
  var declinebutton = '#bpb-decline-' + selectednumber;

  if (locale == 'de') {
    $('#pbbacceptfont ').html(localede.pbbacceptfont);
    $('#pbbacceptfont2 ').html(localede.pbbacceptfont2);
  } else {
    $('#pbbacceptfont ').html(locale.pbbacceptfont);
    $('#pbbacceptfont2 ').html(locale.pbbacceptfont2);
  }

  $(acceptbutton).css({ display: 'none', tranistion: '.5' });
  $(declinebutton).css({ width: '100%', tranistion: '.5' });
}

/* Sound */
function PlayMessageSound() {
  if (mutes == false) {
    if (messagesound != null) {
      messagesound.pause();
    }

    messagesound = Messagesoundfile;
    messagesound.volume = soundvolume;
    messagesound.currentTime = 0;
    messagesound.play();

    setTimeout(function () {
      messagesound.pause();
      messagesound.currentTime = 0;
      messagesound.volume = soundvolume;
    }, 1300);
  }
}

function PlayBMessageSound() {
  if (mutes == false) {
    if (bmessagesound != null) {
      bmessagesound.pause();
    }

    bmessagesound = BMessagesoundfile;
    bmessagesound.volume = soundvolume;

    bmessagesound.currentTime = 0;
    bmessagesound.play();

    setTimeout(function () {
      bmessagesound.pause();
      bmessagesound.currentTime = 0;
      bmessagesound.volume = soundvolume;
    }, 1300);
  }
}

/* Radio */
var freqhidden = false;
$(document).on('click', '#toggler', function () {
  if (
    document.getElementById('phone-radio-frequenz-input').type == 'password'
  ) {
    document.getElementById('phone-radio-frequenz-input').type = 'number';
    document.getElementById('toggler').classList.toggle('fa-eye-slash');
    document.getElementById('toggler').classList.toggle('fa-eye');
    freqhidden = false;
  } else {
    document.getElementById('toggler').classList.toggle('fa-eye');
    document.getElementById('toggler').classList.toggle('fa-eye-slash');
    document.getElementById('phone-radio-frequenz-input').type = 'password';
    freqhidden = true;
  }
});

$(document).on('click', '#phone-radio-return', function () {
  $('.phone-radio').hide();
  $('.phone-applications').show(500);
});

$(document).on('click', '#phone-frequenz-join-button', function () {
  var freq = $('#phone-radio-frequenz-input').val();
  var message1 = $('#phone-radio-frequenz-input').val().toLowerCase();

  if (
    message1.indexOf('script') > -1 ||
    message1.indexOf('http') > -1 ||
    message1.indexOf('www') > -1 ||
    message1.includes('<audio') == true ||
    message1.includes('</audio') == true
  ) {
    sendData('notification', { text: 'Nice try d:^)', length: 5000 });
  } else {
    sendData('setRadio', { freq: freq, freqhidden: freqhidden });
  }
});

$(document).on('click', '#phone-frequenz-leave-button', function () {
  var freq = $('#phone-radio-frequenz-input').val();
  var message1 = $('#phone-radio-frequenz-input').val().toLowerCase();

  if (
    message1.indexOf('script') > -1 ||
    message1.indexOf('http') > -1 ||
    message1.indexOf('www') > -1 ||
    message1.includes('<audio') == true ||
    message1.includes('</audio') == true
  ) {
    sendData('notification', { text: 'Nice try d:^)', length: 5000 });
  } else {
    sendData('leaveRadio', { freq: freq });
  }
});

let constantradio = false;
$(document).on('click', '#phone-constant-radio', function () {
  if (constantradio == false) {
    constantradio = true;
    $('#phone-constant-radio').addClass('disphone-constant-radio');
    if (locale == 'de') {
      $('#phone-constant-radio').html(localede.disableconstant);
    } else {
      $('#phone-constant-radio').html(locale.disableconstant);
    }

    sendData('constantradio', { state: constantradio });
  } else {
    constantradio = false;
    $('#phone-constant-radio').removeClass('disphone-constant-radio');
    if (locale == 'de') {
      $('#phone-constant-radio').html(localede.enableconstant);
    } else {
      $('#phone-constant-radio').html(locale.enableconstant);
    }
    sendData('constantradio', { state: constantradio });
  }
});
/* Update Time */
function UpdateTime(showinGameTime, ingametime) {
  if (showinGameTime == false) {
    var NewDate = new Date();
    var NewHour = NewDate.getHours();
    var NewMinute = NewDate.getMinutes();
    var Minutessss = NewMinute;
    var Hourssssss = NewHour;
    if (NewHour < 10) {
      Hourssssss = '0' + Hourssssss;
    }
    if (NewMinute < 10) {
      Minutessss = '0' + NewMinute;
    }
    var MessageTime = Hourssssss + ':' + Minutessss;

    $('#phone-time').html(MessageTime);
  } else {
    $('#phone-time').html(ingametime);
  }
}

function CloseAll() {
  SetTheme('');
  Main.openapp = 'null';
  $(lastpage).css(
    {
      'margin-left': '0vh',
    },
    0
  );

  // currentpage = null
  // lastpage = null

  $('.phone-applications').hide();
  $('.phone-app').hide();
  $('.phone-recent-message').hide();
  $('.phone-message').hide();
  $('#phone-app-settings').hide();
  $('.phone-services').hide();
  $('.phone-businessapp').hide();
  $('.phone-businessapp-rank-sector').hide();
  $('.phone-businessapp-newrank-sector').hide();
  $('.phone-businessapp-money-sector').hide(0);
  $('.phone-radio').hide();
  $('.phone-twitter').hide();
  $('.phone-bankapp').hide();
  $('.phone-applications').hide();
  $('#phone-app-settings-bgchange').hide();
  $('.phone-bankapp-transfer').fadeOut(0);
  $('.phone-bankapp-home').fadeOut(0);
  $('#pcb-transfer').removeClass('activeposition');
  $('#pcb-home').removeClass('activeposition');
  $('#phone-app-settings').hide();
  $('.phone-app').each(function () {
    $(this).hide();
  });
  $('#phone-app-contact').hide();
  $('#phone-app-contact-page').hide();
  $('#phone-app-contact-edit').hide();
  $('#phone-app-contact-new').hide();
  $('.phone-advertisement').fadeOut(0);
  $('.phone-dmarket').fadeOut(0);

  $('#phone-app-settings-bgchange').hide(0);
  $('#phone-app-settings-casechange').hide(0);
  $('.phone-calculator').fadeOut(0);

  $('#business-teamchat').css(
    {
      left: '-100%',
    },
    200
  );

  $('.phone-app-new').each(function (index) {
    $(this).css({
      left: '-100%',
      'z-index': '1',
    });
  });

  $('.underapp-new222').each(function (index) {
    $(this).css({
      'margin-left': '100%',
      'z-index': '1',
    });
  });

  SlideUpPage.hideall();

  setTimeout(() => {
    footer.tabopen = '';
    footer.lasttabopen = '';
  }, 0);

  $('#phone-homebar').removeClass('black');

  // DoodleEndGame()

  messages.ClearImages();

  business.message.addedimage = null;

  if (PlaySound == 'true') {
    lastsound.removeClass('fa-bell-slash');
    lastsound.addClass('fa-bell');
    soundtest.pause();
    PlaySound = 'null';
  }
}

function Home() {
  CloseAll();
  $('#phone-homebar').hide(0);
  $('.phone-applications').fadeIn(500);
  var r = document.querySelector(':root');
  r.style.setProperty('--header-color', 'white');
}

function SetTheme(theme) {
  var exists = false;

  themes.forEach((element) => {
    if (element == theme) exists = true;
  });

  if (theme == '') exists = true;

  if (exists == false) return;

  var name = 'white' + theme;
  if (darkmode == true) name = 'dark' + theme;

  document.documentElement.setAttribute('data-theme', name);
}

function Darkmode() {
  darkmode = true;
  document.documentElement.setAttribute('data-theme', 'dark');

  $('.phone-footer-applications').addClass('darkphone-footer-applications');
  $('.phone-header').addClass('darkphone-header');
  $('.phone-homebar').addClass('darkphone-homebar');

  /* Phone App */
  $('.phone-enter').each(function () {
    $(this).addClass('darkphone-enter');
  });
  $('.phone-enterinvisibleicon').addClass('darkphone-enterinvisibleicon');
  $('.phone-call-footer-item').addClass('darkphone-call-footer-item');
  $('.phone-returnicon').each(function () {
    $(this).addClass('darkphone-returnicon');
  });

  /* Call App */
  $('.phone-call-app').addClass('darkmode');
  $('.phone-call').addClass('darkmode');
  $('.bigincallsymbol').addClass('darkbigincallsymbol');

  /* Contacts App */

  /* Radio App */
  $('.phone-radio').addClass('darkmode');
  $('.phone-radio-frequenz-input').addClass('darkpciinput');

  /* Settings App */
  $('#customwallpaper').addClass('whitecolor');

  /* Recent Messages App */
  $('.phone-recent-message').addClass('darkmode');
  $('.phone-message-header').addClass('darkmodeheader');

  $('.phone-recent-messages-selection').each(function () {
    $(this).addClass('darkphone-recent-message-settings');
    if ($(this).hasClass('me')) {
      $(this).removeClass('me');
      $(this).addClass('darkme');
    }
  });

  $('.phone-recent-message-settings').addClass(
    'darkphone-recent-message-settings'
  );
  $('.prmsheadline').addClass('darkprmsheadline');
  $('#phonerecentmessagesearchbar').addClass('darkprmsheadline');

  $('#prm-message').each(function () {
    $(this).addClass('darkprm-message');
  });

  $('newmessage').each(function () {
    $(this).addClass('darknewmessage');
  });

  /*  Messages App */
  $('.phone-message').addClass('darkmode');
  $('.phone-message-header').addClass('darkmodeheader');

  $('.phone-chat-message').each(function () {
    $(this).addClass('darkphone-chat-message');
    if ($(this).hasClass('me')) {
      $(this).removeClass('me');
      $(this).addClass('darkme');
    }
  });

  $('.phone-chat-message-header').each(function () {
    $(this).addClass('darkphone-chat-message-header');
  });

  $('.sendservicenumber').each(function () {
    $(this).addClass('darksendservicenumber');
  });

  $('#phone-chat-input-message').addClass('darkpciinput');
  $('#phone-chat-placeicon').addClass('darkphone-chat-placeicon');

  /*  Service App */
  $('.phone-services').addClass('darkmode');
  $('.phone-app-header').addClass('darkmodeheader');

  $('.phone-service-selection').each(function () {
    $(this).addClass('darkphone-service-selection');
  });

  $('.phone-service').each(function () {
    $(this).addClass('darkphone-service-selection');
  });
  $('.phone-service-message-input ').addClass('darkpciinput');

  /*  Business App */
  $('.phone-businessapp').addClass('darkmode');
  $('.phone-app-header').each(function () {
    $(this).addClass('darkmodeheader');
  });

  $('.phone-recent-businessapp-selection').each(function () {
    $(this).addClass('darkmode-prms');
  });

  $('.phone-businessapp-inputt').addClass('darkpciinput');
  $('#phone-businessapp-placeicon').addClass('darkphone-chat-placeicon');

  $('.phone-businessapp-settings-menu').each(function () {
    $(this).addClass('darkphone-businessapp-settings-menu');
  });
  $('.phone-businessapp-footer-item').each(function () {
    $(this).addClass('darkphone-businessapp-footer-item');
  });

  $('.phone-businessapp-motd').addClass('darkminiinput');
  $('.phone-settings-wallpaper').addClass('darkminiinput');

  /*  Twitter App */
  $('.phone-twitter').addClass('darkmode');
  $('.phone-twitter-header').addClass('darkheader');
  $('.phone-tweet ').each(function () {
    $(this).addClass('darkphone-tweet');
  });
  $('.phone-tweet-header').each(function () {
    $(this).addClass('darkphone-tweet-header');
  });
  $('.phone-tweet-name').each(function () {
    $(this).addClass('darkphone-tweet-name');
  });
  $('.phone-tweet-footer').each(function () {
    $(this).addClass('darkphone-tweet-footer');
  });
  $('.phone-tweet-input').each(function () {
    $(this).addClass('darkphone-tweet-input');
  });
  $('.ptw-submitzone').each(function () {
    $(this).addClass('darkptw-submitzone');
  });

  // Bankapp
  $('.phone-bankapp').addClass('darkphone-bankapp');
  $('.phone-bankapp-home').addClass('darkphone-bankapp-home');
  $('.phone-bankapp-transfer').addClass('darkphone-bankapp-home');
  $('.bankapp-account-header').addClass('darkbankapp-account-header');

  $('.bankapp-account-class').each(function () {
    $(this).addClass('darkbankapp-account-class');
  });

  $('.phone-bankapp-transaction-bottom').each(function () {
    $(this).addClass('darkphone-bankapp-transaction-bottom');
  });

  $('.phone-bankapp-footer').addClass('darkphone-bankapp-footer');

  // advertisement
  $('.phone-advertisement').addClass('darkmode');
  $('.life-message').each(function () {
    $(this).addClass('darklife-message');
  });
  $('.advertisement-textarea').each(function () {
    $(this).addClass('darkadvertisement-textarea');
  });

  // DMARKET
  $('.phone-dmarket').addClass('darkmode');
  $('.dmarket-item-product').each(function () {
    $(this).addClass('darkdmarket-item-product');
  });
  $('.dmarket-product').each(function () {
    $(this).addClass('darkdmarket-product');
  });

  // general
  $('.phone-input').each(function () {
    $(this).addClass('darkphone-input');
  });

  //  bitcoin
  $('.phone-bitcoin-bigcachel').each(function () {
    $(this).addClass('darkphone-bitcoin-bigcachel');
  });
  $('.phone-bitcoin-input-smallcachel').each(function () {
    $(this).addClass('darkphone-smallcachel');
  });
  $('.phone-bitcoin-historychachel').each(function () {
    $(this).addClass('darkphone-smallcachel');
  });

  $('.phone-bitcoin-footer-item').each(function () {
    $(this).addClass('darkphone-bitcoin-footer-item');
  });

  //  calculator
  $('.phone-calculator').addClass('darkmode');
  document.getElementById('output').style.color = 'white';
  $('.calculator-grid > button').each(function () {
    $(this).addClass('darkcalculator-grid > button');
  });
  $('.calculator-grid > button:hover').each(function () {
    $(this).addClass('darkcalculator-grid > button');
  });
}

function Whitemode() {
  darkmode = false;
  $('.phone-footer-applications').removeClass('darkphone-footer-applications');
  $('.phone-header').removeClass('darkphone-header');
  $('.phone-homebar').removeClass('darkphone-homebar');

  /* Phone App */
  $('.phone-enter').each(function () {
    $(this).removeClass('darkphone-enter');
  });
  $('.phone-enterinvisibleicon').removeClass('darkphone-enterinvisibleicon');
  $('.phone-call-footer-item').removeClass('darkphone-call-footer-item');
  $('.phone-returnicon').each(function () {
    $(this).removeClass('darkphone-returnicon');
  });

  /* Call App */
  $('.phone-call-app').removeClass('darkmode');
  $('.phone-call').removeClass('darkmode');
  $('.bigincallsymbol').removeClass('darkbigincallsymbol');
  /* Contacts App */

  /* Radio App */
  $('.phone-radio').removeClass('darkmode');
  $('.phone-radio-frequenz-input').removeClass('darkpciinput');

  /* Settings App */
  $('#phone-app-settings').removeClass('darkmode');
  $('.phone-settings-header').removeClass('darkmodeheader');
  $('.phone-settings-selection').removeClass('darkphone-settings-selection');
  $('#customwallpaper').removeClass('whitecolor');

  /* Recent Messages App */
  $('.phone-recent-message').removeClass('darkmode');
  $('.phone-message-header').removeClass('darkmodeheader');

  $('.phone-recent-messages-selection').each(function () {
    $(this).removeClass('darkphone-recent-message-settings');
    if ($(this).hasClass('me')) {
      $(this).addClass('me');
      $(this).removeClass('darkme');
    }
  });

  $('.phone-recent-message-settings').removeClass(
    'darkphone-recent-message-settings'
  );
  $('.prmsheadline').removeClass('darkprmsheadline');
  $('#phonerecentmessagesearchbar').removeClass('darkprmsheadline');

  $('#prm-message').each(function () {
    $(this).removeClass('darkprm-message');
  });

  $('newmessage').each(function () {
    $(this).removeClass('darknewmessage');
  });

  /*  Messages App */
  $('.phone-message').removeClass('darkmode');
  $('.phone-message-header').removeClass('darkmodeheader');

  $('.phone-chat-message').each(function () {
    $(this).removeClass('darkphone-chat-message');
    if ($(this).hasClass('me')) {
      $(this).addClass('me');
      $(this).removeClass('darkme');
    }
  });

  $('.phone-chat-message-header').each(function () {
    $(this).removeClass('darkphone-chat-message-header');
  });

  $('.sendservicenumber').each(function () {
    $(this).removeClass('darksendservicenumber');
  });

  $('#phone-chat-input-message').removeClass('darkpciinput');
  $('#phone-chat-placeicon').removeClass('darkphone-chat-placeicon');
  /*  Service App */
  $('.phone-services').removeClass('darkmode');
  $('.phone-app-header').removeClass('darkmodeheader');

  $('.phone-service-selection').each(function () {
    $(this).removeClass('darkphone-service-selection');
  });

  $('.phone-service').each(function () {
    $(this).removeClass('darkphone-service-selection');
  });
  $('.phone-service-message-input ').removeClass('darkpciinput');

  /*  Business App */
  $('.phone-businessapp').removeClass('darkmode');
  $('.phone-app-header').each(function () {
    $(this).removeClass('darkmodeheader');
  });

  $('.phone-recent-businessapp-selection').each(function () {
    $(this).removeClass('darkmode-prms');
  });

  $('.phone-businessapp-inputt').removeClass('darkpciinput');
  $('#phone-businessapp-placeicon').removeClass('darkphone-chat-placeicon');

  $('.phone-businessapp-settings-menu').each(function () {
    $(this).removeClass('darkphone-businessapp-settings-menu');
  });
  $('.phone-businessapp-footer-item').each(function () {
    $(this).removeClass('darkphone-businessapp-footer-item');
  });

  $('.phone-businessapp-motd').removeClass('darkminiinput');
  $('.phone-settings-wallpaper').removeClass('darkminiinput');
  /*  Twitter App */
  $('.phone-twitter').removeClass('darkmode');
  $('.phone-twitter-header').removeClass('darkheader');
  $('.phone-tweet ').each(function () {
    $(this).removeClass('darkphone-tweet');
  });
  $('.phone-tweet-header').each(function () {
    $(this).removeClass('darkphone-tweet-header');
  });
  $('.phone-tweet-name').each(function () {
    $(this).removeClass('darkphone-tweet-name');
  });
  $('.phone-tweet-footer').each(function () {
    $(this).removeClass('darkphone-tweet-footer');
  });
  $('.phone-tweet-input').each(function () {
    $(this).removeClass('darkphone-tweet-input');
  });
  $('.ptw-submitzone').each(function () {
    $(this).removeClass('darkptw-submitzone');
  });

  // Bankapp
  $('.phone-bankapp').removeClass('darkphone-bankapp');
  $('.phone-bankapp-home').removeClass('darkphone-bankapp-home');
  $('.phone-bankapp-transfer').removeClass('darkphone-bankapp-home');
  $('.bankapp-account-header').removeClass('darkbankapp-account-header');
  $('.bankapp-account-class').each(function () {
    $(this).removeClass('darkbankapp-account-class');
  });

  $('.phone-bankapp-transaction-bottom').each(function () {
    $(this).removeClass('darkphone-bankapp-transaction-bottom');
  });
  $('.phone-bankapp-footer').removeClass('darkphone-bankapp-footer');

  // advertisement
  $('.phone-advertisement').removeClass('darkmode');
  $('.life-message').each(function () {
    $(this).removeClass('darklife-message');
  });
  $('.advertisement-textarea').each(function () {
    $(this).removeClass('darkadvertisement-textarea');
  });

  // DMARKET
  $('.phone-dmarket').removeClass('darkmode');
  $('.dmarket-item-product').each(function () {
    $(this).removeClass('darkdmarket-item-product');
  });
  $('.dmarket-product').each(function () {
    $(this).removeClass('darkdmarket-product');
  });

  // general
  $('.phone-input').each(function () {
    $(this).removeClass('darkphone-input');
  });

  //  bitcoin
  $('.phone-bitcoin-bigcachel').each(function () {
    $(this).removeClass('darkphone-bitcoin-bigcachel');
  });
  $('.phone-calculator').removeClass('darkmode');
  $('.phone-bitcoin-input-smallcachel').each(function () {
    $(this).removeClass('darkphone-smallcachel');
  });
  $('.phone-bitcoin-historychachel').each(function () {
    $(this).removeClass('darkphone-smallcachel');
  });
  $('.phone-bitcoin-historychachel').each(function () {
    $(this).removeClass('darkphone-smallcachel');
  });
  $('.phone-bitcoin-footer-item').each(function () {
    $(this).removeClass('darkphone-bitcoin-footer-item');
  });

  document.documentElement.setAttribute('data-theme', 'light');

  calculator;
  $('.phone-calculator').removeClass('darkmode');
  document.getElementById('output').style.color = 'black';
  $('.calculator-grid > button').each(function () {
    $(this).removeClass('darkcalculator-grid > button');
  });
  $('.calculator-grid > button:hover').each(function () {
    $(this).removeClass('darkcalculator-grid > button');
  });
}

var pressed = false;
$(document).on('click', '#phone-homebar', function () {
  if (pressed) return;
  pressed = true;

  if (lastwindow == 'wallpaper') {
    $('.phone-settings-sector').show(500);
    $('.phone-settings-inner').hide(500);
    $('#headerback').hide(500);
    lastwindow = null;
  }

  console.log(Main.openapp);
  if (Main.openapp == 'call-type') {
    call.call.small.show();
  }
  Home();
  if (lasthomebarwindow == 'chat') {
    sendData('loadrecentmessage', {});
    $('#phone-homebar').fadeIn(250);
    lasthomebarwindow = null;
    lastwindow = null;
  } else {
    sendData('activeappnone', {});
    $('.phone-applications').fadeIn(250);
    $('#phone-homebar').fadeOut(0);
  }
  setTimeout(() => {
    pressed = false;
  }, 1000);
});

$(document).on('click', '#headerback', function () {
  if (lastwindow == 'wallpaper') {
    $('.phone-settings-sector').show(500);
    $('.phone-settings-inner').hide(500);
    $('#headerback').hide(500);
    $('.phone-homebar').show(500);
    lastwindow = 'settings';
  } else if (lastwindow == 'case') {
    // Casepreview(oldcase, oldmodel)
    $('.phone-settings-sector').show(500);
    $('.phone-settings-inner').hide(500);
    $('#headerback').hide(500);
    $('.phone-homebar').show(500);
    lastwindow = 'settings';
  } else {
    // sendData("activeappnone", {})
    // $(".phone-applications").fadeIn(250);
    // $("#phone-homebar").fadeOut(0);
  }
});

function Startloadingscreen(time) {
  $('.phone-blackscreen').hide(0);
  $('.phone-startscreen').show(0);
  $('.phone-startscreen-loadingbar-inner').css({
    width: '0%',
  });
  $('.phone-startscreen-loadingbar-inner').animate(
    {
      width: '100%',
    },
    time
  );
}

function Notify(string, type) {
  sendData('notify', {
    locale: string,
    type: type,
  });
}

function RadioIcon(state) {
  if (state == true) $('#radioicon').show(0);
  if (state == false) $('#radioicon').hide(0);
}

function ShowHomebar() {
  $('#phone-homebar').css({
    display: 'block',
    'margin-left': '-30vh',
  });
  $('#phone-homebar').animate(
    {
      'margin-left': '0vh',
    },
    400
  );
}

function AppIcon(app, state) {
  $('.phone-application').each(function () {
    if ($(this).data('app') == app) {
      if (state == true) $(this).show();
      if (state == false) $(this).hide();
    }
  });
}

function CheckImage(avatar) {
  if (
    avatar.includes('png') == true ||
    avatar.includes('jpeg') == true ||
    avatar.includes('jpg') == true ||
    avatar.includes('gif') == true
  ) {
    return true;
  } else {
    Notify('hastobepng', 'error');
  }

  return false;
}

function IsImageOk(img) {
  // During the onload event, IE correctly identifies any images that
  // weren’t downloaded as not complete. Others should too. Gecko-based
  // browsers act like NS4 in that they report this incorrectly.
  if (!img.complete) {
    return false;
  }

  // However, they do have two very useful properties: naturalWidth and
  // naturalHeight. These give the true size of the image. If it failed
  // to load, either of these should be zero.
  if (img.naturalWidth === 0) {
    return false;
  }

  // No other way of checking: assume it’s ok.
  return true;
}

apptext = function (state) {
  if (state == false) {
    $('.phone-application').css({
      height: '4.6vh',
      'grid-template-rows': '4.6vh 0vh',
    });

    $('.phone-application > p').css({
      display: 'none',
    });
    $('#appnamecb').removeClass('checked');
  } else {
    $('.phone-application').css({
      height: '6.6vh',
      'grid-template-rows': '4.6vh 2vh',
    });

    $('.phone-application > p').css({
      display: 'block',
    });
    $('#appnamecb').addClass('checked');
  }
};

footer = {
  tabopen: '',
  lasttabopen: '',
  cooldown: false,
};

footer.open = function (newopen) {
  if (footer.cooldown == true) return;

  if (newopen == footer.tabopen) return;
  footer.cooldown = true;

  setTimeout(function () {
    $(footer.tabopen).animate({
      'margin-left': '100%',
    });
    $(newopen).css({
      'margin-left': '0%',
      'margin-right': '100%',
    });
    setTimeout(function () {
      $(newopen).animate(
        {
          'margin-right': '0%',
        },
        500
      );
      footer.lasttabopen = footer.tabopen;
      footer.tabopen = newopen;
      footer.cooldown = false;
    }, 10);
  }, 10);
};

$(document).on('click', '#view-return', function () {
  footer.open(footer.lasttabopen);
});

showPhone = function (param) {
  BottomSlideUp('.container', 300, 0);
  $('.phone-startscreen').fadeOut(500);
};

showAllIcons = function () {
  $('#mailicon').show(0);
  $('#jobmailiicon').show(0);
  $('#dmarketicon').show(0);
  $('#truckicon').show(0);
  $('#stockicon').show(0);
  $('#bitcoinicon').show(0);
};
