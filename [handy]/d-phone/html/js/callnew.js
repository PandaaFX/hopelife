call = {
  activ: {
    type: 'none',
    state: false,
    number: '',
    label: '',
    timer: null,
  },
  footer: new Footer('call', 'null'),
  call: {
    state: 'none',
    header: {},
    small: {},
    big: {
      incomming: {},
      outgoing: {},
      ongoing: {
        state: 'none',
      },
    },
  },
  history: {
    load: (html) => {
      $('#call-recent-elements').html(html);
    },
    add: (html) => {
      $('#call-recent-elements').prepend(html);
    },
    number: (html) => {
      $('#addcontactpage-recentcallhistory-elements').html(html);
    },
  },
  block: {
    load: (html) => {
      $('#call-block-elements').html(html);
    },
    add: (html) => {
      $('#call-block-elements').prepend(html);
    },
  },
  sound: {
    volume: 0.2,
    incomming: {
      audio: null,
    },
    outgoing: {
      audio: null,
    },
  },
};

$(function () {
  call.sound.set(
    'incomming',
    'https://cdn.discordapp.com/attachments/968045722551337020/1021492651037565019/ring.ogg'
  );

  call.sound.set(
    'outgoing',
    'https://cdn.discordapp.com/attachments/968045722551337020/1021520094385418280/Phonecall.ogg'
  );

  window.addEventListener('message', function (event) {
    var v = event.data;

    if (v.app == 'call' && v.task == 'history:load') {
      call.history.load(v.html);
    } else if (v.app == 'call' && v.task == 'history:add') {
      call.history.add(v.html);
    } else if (v.app == 'call' && v.task == 'history:number') {
      call.history.number(v.html);
    }

    if (v.app == 'call' && v.task == 'block:load') {
      call.block.load(v.html);
    }

    if (v.app == 'call' && v.task == 'incomming') {
      call.new(v.number, v.label, true, v.isphoneopen);
    } else if (v.app == 'call' && v.task == 'stopcall') {
      call.end();
    } else if (v.app == 'call' && v.task == 'accept') {
      call.accept();
    }

    if (v.app == 'call' && v.task == 'call:hideactions') {
      call.call.hideactions(v.data);
    }
  });
});

call.show = function () {
  ShowHomebar();

  $('#call').css({
    'z-index': '1',
  });
  $('#call').animate(
    {
      left: '0%',
    },
    400
  );

  Main.openapp = 'call';
};

call.hide = function () {
  $('#phone-homebar').hide(500);
};

call.footer.open('home');
call.footer.lasttabopen = 'home';
call.footer.opentab = 'home';

$(document).on('click', '.callfooter', function () {
  if (footerprogress) return;
  let newtab = $(this).data('new');
  call.footer.open(newtab);
  call.footer.lasttabopen = call.footer.opentab;
  call.footer.opentab = newtab;
});

// Home
$(document).on('click', '.call-input', function () {
  let number = $(this).data('num');
  if (number == null) return;
  var element = document.getElementById('call-home-number');
  element.innerHTML = element.innerHTML + number;

  $('#call-delete').fadeIn(250);
  $('.call-addtocontact').fadeIn(250);
});

$(document).on('click', '#call-delete', function () {
  let number = $(this).data('id');

  $('#call-home-number').html($('#call-home-number').text().replace(/.$/g, ''));

  if ($('#call-home-number').text().trim() === '') {
    $('#call-delete').fadeOut(250);
    $('.call-addtocontact').fadeOut(250);
  }
});

$(document).on('click', '#call-callicon', function () {
  var element = document.getElementById('call-home-number');
  var number = $('#call-home-number').text().trim();
  call.new(number, number, false);

  element.innerHTML = '';
  $('#call-home-number').html($('#call-home-number').text().replace(/.$/g, ''));

  if ($('#call-home-number').text().trim() === '') {
    $('#call-delete').fadeOut(250);
    $('.call-addtocontact').fadeOut(250);
  }
});

$(document).on('click', '.call-addtocontact', function () {
  var number = $('#call-home-number').text().trim();
  $('#phone-app-contact-phonenumber').val(number);
  currentpage = '#phone-app-contact-new';
  canback = true;

  $(currentpage).css({
    display: 'block',
    'z-index': '2',
  });
  $(currentpage).animate(
    {
      'margin-left': '0vh',
    },
    400
  );
});

// Recent

// SlideUpPage.show('mail-new');
$(document).on('click', '.recent-calls-element', function () {
  var name = $(this).data('name');
  var number = $(this).data('number');
  var iscontact = $(this).data('iscontact');
  var isblocked = $(this).data('isblocked');
  var isanonym = $(this).data('isanonym');
  if (!isanonym) {
    sendData('call:history:loadnumber', {
      number: number,
    });
  }

  ContactInteraction(
    'recent-calls',
    name,
    number,
    'None',
    iscontact,
    isblocked,
    isanonym
  );
});

$(document).on('click', '.call-block-element', function () {
  var name = $(this).data('name');
  var number = $(this).data('number');
  var iscontact = $(this).data('iscontact');
  ContactInteraction('recent-calls', name, number, 'None', iscontact, true);
});

ContactInteractionData = {};
ContactInteraction = (
  mode = 'none',
  name = 'none',
  number = 'none',
  html = 'none',
  iscontact = false,
  isblocked = false,
  isanonym = false
) => {
  // iscontact
  if (iscontact) $('#addcontactpage-addcontact').hide(0);
  if (!iscontact) $('#addcontactpage-addcontact').show(0);

  // isblocked
  if (isblocked) $('#addcontactpage-block').hide(0);
  if (!isblocked) $('#addcontactpage-block').show(0);

  if (isblocked) $('#addcontactpage-unblock').show(0);
  if (!isblocked) $('#addcontactpage-unblock').hide(0);

  if (mode == 'recent-calls') {
    $('#addcontactpage-recentcallhistory').show(0);
    $('#addcontactpage-recentcallhistory-elements').html(html);
  }
  if (mode != 'recent-calls') $('#addcontactpage-recentcallhistory').hide(0);

  ContactInteractionData.name = name;
  ContactInteractionData.number = number;
  $('#addcontactpage-name').html(name);

  if (isanonym) {
    $('#addcontactpage-block').hide(0);
    $('#addcontactpage-unblock').hide(0);
    $('#addcontactpage-addcontact').hide(0);
    $('#addcontactpage-call').hide(0);
    $('#addcontactpage-message').hide(0);
  } else {
    $('#addcontactpage-addcontact').show(0);
    $('#addcontactpage-call').show(0);
    $('#addcontactpage-message').show(0);
  }

  SlideUpPage.show('addcontactpage');
};

$(document).on('click', '#addcontactpage-addcontact', function () {
  SlideUpPage.hide();
  currentpage = '#phone-app-contact-new';
  canback = true;
  $('#phone-app-contact-phonenumber').val(ContactInteractionData.number);

  $(currentpage).css({
    display: 'block',
    'z-index': '2',
  });
  $(currentpage).animate(
    {
      'margin-left': '0vh',
    },
    400
  );
});

$(document).on('click', '#addcontactpage-call', function () {
  SlideUpPage.hide();
  var number = ContactInteractionData.number;
  var name = ContactInteractionData.name;
  call.new(number, name, false, true);
});

$(document).on('click', '#addcontactpage-message', function () {
  SlideUpPage.hide();

  messages.loadchat(ContactInteractionData.number);
});

$(document).on('click', '#addcontactpage-block', function () {
  var number = ContactInteractionData.number;
  var name = ContactInteractionData.name;

  sendData('call:block', {
    number: number,
    state: true,
  });

  SlideUpPage.hide();
});

$(document).on('click', '#addcontactpage-unblock', function () {
  var number = ContactInteractionData.number;
  var name = ContactInteractionData.name;

  sendData('call:block', {
    number: number,
    state: false,
  });

  SlideUpPage.hide();
});

// call
call.new = function (number, label, incomming = false, phoneopen = false) {
  if (call.activ.state == true) {
    return;
  }

  call.call.state = 'big';
  call.activ.state = true;
  call.activ.number = number;
  call.activ.label = label;

  if (incomming) {
    call.activ.type = 'incomming';
    if (phoneopen) {
      call.call.small.show();
    } else {
      call.call.big.show();
    }
    call.sound.play('incomming');
  } else {
    call.activ.type = 'outgoing';
    if (phoneopen) {
      call.call.small.show();
    } else {
      call.call.big.show();
    }
    call.sound.play('outgoing');
    sendData('call:start', {
      number: number,
    });
  }
};

call.end = function () {
  if (call.call.state == 'small') {
    call.call.small.hide();
  } else {
    Main.openapp = '';
    call.call.big.hide();
  }

  call.activ.type = 'none';
  call.activ.state = 'none';
  call.activ.number = '';
  call.activ.label = '';

  call.sound.stop('incomming');
  call.sound.stop('outgoing');

  clearInterval(call.activ.timer);
};

call.accept = () => {
  call.activ.type = 'ongoing';
  if (call.call.state == 'small') {
    call.call.small.show();
  } else {
    call.call.big.show();
  }

  call.sound.stop('incomming');
  call.sound.stop('outgoing');

  call.timer();
};

call.timer = () => {
  $('#call-type-home-time').html('00:00');
  var minutes = 0;
  var seconds = 0;
  call.activ.timer = setInterval(() => {
    seconds++;
    if (seconds == 60) {
      minutes++;
      seconds = 0;
    }
    var displaym = minutes;
    var displays = seconds;
    if (minutes < 10) displaym = '0' + minutes;
    if (seconds < 10) displays = '0' + seconds;
    var display = `${displaym}:${displays}`;
    $('#call-type-home-time').html(display);
  }, 1000);
};

// big
call.call.big.show = function () {
  var type = call.activ.type;
  var label = call.activ.label;

  $('#call-type-home-decline').removeClass('pulseanimation');
  $('#call-type-home-accept').removeClass('pulseanimation');

  $('#call-type-home-accept').hide(0);
  $('#call-type-home-decline').hide(0);

  if (type == 'incomming' || type == 'outgoing') {
    $('#call-type-home-time').hide(0);
    $('#call-type-actions').hide(0);
    $('#call-type-home-decline').addClass('pulseanimation');
    $('#call-type-home-accept').addClass('pulseanimation');

    if (type == 'incomming') {
      $('#call-type-home-accept').show(0);
      $('#call-type-home-decline').show(0);
    }
    if (type == 'outgoing') $('#call-type-home-decline').show(0);
  } else {
    $('#call-type-home-time').show(0);
    $('#call-type-actions').show(0);
    $('#call-type-home-decline').show(0);
  }

  $('#call-type-home-name').html(label);

  $('#call-type').css({
    'z-index': '2',
  });
  $('#call-type').animate({
    left: '0%',
  });

  Main.openapp = 'call-type';
  ShowHomebar();
};

call.call.big.hide = function () {
  Home();
};

// small
call.call.small.show = function () {
  var label = call.activ.label;
  $('#call-small-label').html(label);

  $('#call-small-decline').show();
  $('#call-small-accept').show();
  $('#call-small-close').show();

  if (call.activ.type == 'incomming') {
    $('#call-small-close').hide();
    $('#call-small-time').hide(0);
  } else {
    $('#call-small-accept').hide();
    if (call.activ.type == 'outgoing') $('#call-small-time').hide(0);
  }

  $('.call-small-incomming').fadeIn(500);
  $('.call-small-incomming').css('display', 'flex');
  call.call.state = 'small';
};

call.call.small.hide = function () {
  $('.call-small-incomming').fadeOut(500);
  call.call.state = 'none';
};

$(document).on('click', '.call-decline', function () {
  sendData('call:stop');
});

$(document).on('click', '.call-accept', function () {
  sendData('call:accept');
});

$(document).on('click', '#call-small-makebig', function () {
  call.call.small.hide();
  call.call.big.show();
});

$(document).on('click', '#call-small-close', function () {
  call.call.header.show();
});

// header
$(document).on('click', '.call-header-ongoing', function () {
  call.call.header.hide();
  call.call.small.show();
});

call.call.header.show = function () {
  call.call.small.hide();
  $('.call-header-ongoing').fadeIn(500);
  $('.call-header-ongoing').css('display', 'flex');
  call.call.state = 'header';
};

call.call.header.hide = function () {
  $('.call-header-ongoing').fadeOut(500);
  call.call.state = 'none';
};

// Sound
call.sound.set = function (type, url) {
  if (type == 'incomming') {
    call.sound.incomming.sound = new Audio(url);
  } else {
    call.sound.outgoing.sound = new Audio(url);
  }
};

call.sound.play = function (type) {
  var sound = call.sound.incomming.sound;

  if (type == 'outgoing') {
    sound = call.sound.outgoing.sound;
  }

  sound.loop = true;
  sound.currentTime = 0;
  sound.volume = call.sound.volume;
  sound.play();
};

call.sound.stop = function (type) {
  var sound = call.sound.incomming.sound;

  if (type == 'outgoing') {
    sound = call.sound.outgoing.sound;
  }
  if (sound != null) {
    sound.pause();
  }
};

call.sound.setvolume = function (vol) {
  if (vol == null) return;

  if (vol <= 1 && vol >= 0) {
  } else if (vol > 1) {
    call.sound.volume = vol * 0.01;
  } else {
    // console.log('too big or too low');
  }
};

// Inputarea.show(
//   'ringtonevolume',
//   'fa-solid fa-volume-high',
//   'setringtonevolume',
//   'number',
//   false
// );

// incall actions
call.call.hideactions = (data) => {
  var array = data;
  for (let i = 0; i < array.length; i++) {
    const x = array[i];

    $('.call-type-action').each(function (index, element) {
      var e = $(this);
      var action = $(this).data('action');

      if (x.action == action) {
        if (x.show) $(this).show(0);
        if (!x.show) $(this).hide(0);
      }
    });
  }
};

$(document).on('click', '.call-type-action', function () {
  var e = $(this);
  var action = $(this).data('action');

  if (action == 'mute') {
    if (e.hasClass('redcolor')) return;
    if (e.hasClass('accent-colorf')) {
      e.removeClass('accent-colorf');
    } else {
      e.addClass('accent-colorf');
    }
  } else if (action == 'volumeup' || action == 'volumedown') {
    if (e.hasClass('redcolor')) return;
    $('.call-type-action').each(function (index, element) {
      var e = $(this);
      var action = $(this).data('action');

      if ('mute' == action) {
        e.removeClass('accent-colorf');
      }
    });
  } else if (action == 'adduser') {
    SlideUpPage.show('share-messages');
    SlideUpPageContact = 'Call';

    sendData('slideuppage:contact:load', {
      app: 'call',
    });
  } else if (action == 'speaker') {
    var state = false;
    if (e.hasClass('accent-colorf')) {
      e.removeClass('accent-colorf');
      $('.call-type-action').each(function (index, element) {
        var t = $(this);
        if (t.data('action') != 'speaker' && t.data('action') != 'adduser') {
          t.removeClass('accent-colorf');
          t.addClass('redcolor');
        }
      });
    } else {
      state = true;
      e.addClass('accent-colorf');
      $('.call-type-action').each(function (index, element) {
        var t = $(this);
        if (t.data('action') != 'speaker' && t.data('action') != 'adduser')
          t.removeClass('redcolor');
      });
    }
  }

  sendData('call:action', {
    action: action,
    state: state,
  });
});
