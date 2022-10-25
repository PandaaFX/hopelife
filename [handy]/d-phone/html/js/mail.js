mail = {
  home: {},
  sent: {},
  new: {
    receivers: 1,
    attachments: [],
  },
  user: {},
  view: {},
  footer: {},
  open: {},
  ready: false,
  tabopen: '#mail-home',
  lasttabopen: null,
};

var DontWalkArray2 = [];

$(function () {
  $('#mailicon').hide(0);
  $('#jobmailiicon').hide(0);
  $('#dmarketicon').hide(0);
  $('#truckicon').hide(0);
  $('#stockicon').hide(0);

  window.addEventListener('message', function (event) {
    var v = event.data;

    if (v.app == 'mail' && v.task == 'load') {
      $('#mailicon').show(0);
      mail.home.load(v.html);
    } else if (v.app == 'mail' && v.task == 'sent:load') {
      mail.sent.load(v.html);
    }

    if (v.app == 'mail' && v.task == 'view') {
      mail.open = v.mail;
      mail.view.load(
        v.mail.senderlabel,
        v.time,
        v.mail.sender,
        v.mail.subject,
        v.mail.text,
        v.mail.attachments
      );
      $('#mail-options').show();
    } else if (v.app == 'mail' && v.task == 'sentview') {
      mail.view.load(
        v.receiverslabel,
        v.time,
        v.receivers,
        v.mail.subject,
        v.mail.text,
        v.mail.attachments
      );
      $('#mail-options').hide(0);
    }

    if (v.app == 'mail' && v.task == 'user:setmail') {
      $('#mail-user-mail').html(v.mail);
    }
  });
});

mail.show = function () {
  ShowHomebar();
  $('#mail').css({
    'z-index': '2',
  });
  $('#mail').animate({
    left: '0%',
  });

  Main.openapp = 'mail';
};

mail.hide = function () {
  $('#phone-homebar').hide(500);
};

function alerts(element, alert) {
  var counter = 0;
  $(element).each(function () {
    if ($(this).hasClass('new')) {
      counter += 1;
    }
  });

  if (counter > 0) {
    $(alert).show(0);
    if (counter > 99) counter = '99+';
    $(alert).html(counter);
  } else {
    $(alert).hide(0);
  }
}

// Footer
$(document).on('click', '#mail-footer-newmail', function () {
  SlideUpPage.show('mail-new');
});

$(document).on('click', '#mail-footer-home', function () {
  mail.footer.open('#mail-home');
  mail.footer.icon(this);
});

$(document).on('click', '#mail-footer-sent', function () {
  mail.footer.open('#mail-sent');
  mail.footer.icon(this);
});

$(document).on('click', '#mail-footer-user', function () {
  mail.footer.open('#mail-user');
  mail.footer.icon(this);
});

var lastscrollheight;
mail.footer.open = function (newopen) {
  if (newopen == mail.tabopen) return;

  setTimeout(function () {
    $(mail.tabopen).animate({
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
    }, 10);
    mail.lasttabopen = mail.tabopen;
    mail.tabopen = newopen;
  }, 10);
};

mail.footer.icon = function (obj) {
  $('#mail-footer-home').removeClass('purplecolor');
  $('#mail-footer-sent').removeClass('purplecolor');
  $('#mail-footer-newmail').removeClass('purplecolor');
  $('#mail-footer-user').removeClass('purplecolor');

  $(obj).addClass('purplecolor');
};

// Home
alerts('.mail-home-element', '#mail-alerts');

mail.home.load = function (html) {
  $('#mail-home-container').html(html);

  var $wrapper = $('#mail-home-container');

  $wrapper
    .find('.mail-home-element')
    .sort(function (a, b) {
      return -a.getAttribute('data-id') + +b.getAttribute('data-id');
    })
    .appendTo($wrapper);

  setTimeout(() => {
    alerts('.mail-home-element', '#mail-alerts');
  }, 400);
};

$(document).on('click', '.mail-home-element', function () {
  var id = $(this).data('id');
  var mail = $(this).data('mail');
  sendData('mail:home:load', {
    id: id,
    mail: mail,
  });
});

var mailhomesearchbar =
  document.forms['mail-home-searchbar'].querySelector('input');
mailhomesearchbar.addEventListener('keyup', function (e) {
  const term = e.target.value.toLocaleLowerCase();
  var notAvailable = document.getElementById('notAvailable');
  //   $("#titleMain").toggle($('input').val().length == 0);
  var hasResults = false;
  $('.mail-home-element').each(function () {
    if (
      $(this).data('mail').toString().toLowerCase().includes(term.toString()) ||
      $(this).data('label').toString().toLowerCase().includes(term.toString())
    ) {
      $(this).show(0);
    } else {
      $(this).hide(0);
    }
  });
});

var mailsentsearchbar =
  document.forms['mail-sent-searchbar'].querySelector('input');
mailsentsearchbar.addEventListener('keyup', function (e) {
  const term = e.target.value.toLocaleLowerCase();
  var notAvailable = document.getElementById('notAvailable');
  //   $("#titleMain").toggle($('input').val().length == 0);
  var hasResults = false;
  $('.mail-sent-element').each(function () {
    if (
      $(this).data('mail').toString().toLowerCase().includes(term.toString()) ||
      $(this).data('label').toString().toLowerCase().includes(term.toString())
    ) {
      $(this).show(0);
    } else {
      $(this).hide(0);
    }
  });
});

//  Sent
mail.sent.load = function (html) {
  $('#mail-sent-container').html(html);

  var $wrapper = $('#mail-sent-container');

  $wrapper
    .find('.mail-sent-element')
    .sort(function (a, b) {
      return -a.getAttribute('data-id') + +b.getAttribute('data-id');
    })
    .appendTo($wrapper);
};

$(document).on('click', '.mail-sent-element', function () {
  var id = $(this).data('id');
  var mail = $(this).data('mail');
  sendData('mail:sent:load', {
    id: id,
    mail: mail,
  });
});

// Mail new
$(document).on('click', '.mail-new-plus', function () {
  if (mail.ready == true) return;
  mail.ready = true;
  mail.new.receivers += 1;
  var html =
    ' <div><input class="mail-new-input" type="email" name="" id="mail-new-input-receiver-' +
    mail.new.receivers +
    '"><i class="fa-solid fa-plus mail-new-plus"></i><i class="fa-solid fa-xmark mail-new-close"></i></div>';

  $('.mail-new-plus').each(function (i, e) {
    $(this).hide(0);
  });
  $('.mail-new-close').each(function (i, e) {
    $(this).hide(0);
  });
  $('.mail-new-input').each(function (i, e) {
    $(this).css({
      'grid-column': '1 / 4',
    });
  });

  $('#mail-new-receiverdiv').append(html);
  $('#mail-new-input-receiver-' + mail.new.receivers)
    .parent()
    .animate(
      {
        opacity: '100%',
      },
      400
    );

  DontWalkArray2.push('#mail-new-input-receiver-' + mail.new.receivers);

  mail.ready = false;
});

$(document).on('click', '.mail-new-close', function () {
  if (mail.ready == true) return;
  mail.ready = true;
  var parent = $(this).parent();
  $(this).parent().animate(
    {
      opacity: '0%',
    },
    400
  );

  mail.new.receivers -= 1;
  $('#mail-new-input-receiver-' + mail.new.receivers)
    .parent()
    .animate(
      {
        width: '100%',
      },
      400
    );

  setTimeout(() => {
    parent.remove();
    var column = 2;
    if (mail.new.receivers == 1) column = 3;
    $('#mail-new-input-receiver-' + mail.new.receivers).css({
      'grid-column': '1 / ' + column,
    });
    $('#mail-new-input-receiver-' + mail.new.receivers)
      .parent()
      .children('i.fa-solid.fa-plus.mail-new-plus')
      .fadeIn(500);
    $('#mail-new-input-receiver-' + mail.new.receivers)
      .parent()
      .children('i.fa-solid.fa-xmark.mail-new-close')
      .fadeIn(500);
    mail.ready = false;
    $('#mail-new-input-receiver-' + mail.new.receivers)
      .parent()
      .css(
        {
          width: '100%',
        },
        400
      );
  }, 500);
});

$(document).on('click', '#mail-new-submit', function () {
  var receivers = [];
  for (let index = 1; index <= mail.new.receivers; index++) {
    var receiver = $('#mail-new-input-receiver-' + index).val();
    if (receiver != '') receivers.push(receiver);
  }

  var subject = $('#mail-new-subject').val();

  var message = $('#mail-new-message').html();

  SlideUpPage.hide();

  sendData(Main.openapp + ':new:send', {
    receivers: receivers,
    subject: subject,
    message: message,
    attachments: mail.new.attachments,
  });
  mail.new.reset();
});

mail.new.reset = function () {
  $('#mail-new-subject').val('');
  $('#mail-new-message').html('');

  for (let index = 2; index <= mail.new.receivers; index++) {
    $('#mail-new-input-receiver-' + index)
      .parent()
      .remove();
  }

  mail.new.receivers = 1;
  if (mail.new.receivers == 1) column = 3;
  $('#mail-new-input-receiver-' + mail.new.receivers).css({
    'grid-column': '1 / ' + column,
  });
  $('#mail-new-input-receiver-' + mail.new.receivers).val('');
  $('#mail-new-input-receiver-' + mail.new.receivers)
    .parent()
    .children('i.fa-solid.fa-plus.mail-new-plus')
    .fadeIn(500);
  $('#mail-new-input-receiver-' + mail.new.receivers)
    .parent()
    .children('i.fa-solid.fa-xmark.mail-new-close')
    .fadeIn(500);

  $('#mail-new-attachments').html('');
  mail.new.attachments = [];
};

$(document).on('click', '#mail-new-tools-bold', function () {
  if ($(this).hasClass('activ')) {
    $(this).removeClass('activ');
    var innertable = '<bold>';
    $('#mail-new-message').append('</bold>');
  } else {
    $(this).addClass('activ');
    var innertable = '<bold>';

    var html = $('#mail-new-message').html();
    document.getElementById('mail-new-message').innerHTML =
      html + ' ' + innertable;
  }
});
//
$(document).on('click', '#mail-new-attachment', function () {
  BottomSlideUp('#messages-inputimageurl-area', 500, 5);
  inputarea.open = 'mail-new';
});

$(document).on('click', '.mail-new-attachments-delete', function () {
  var image = $(this).parent().parent().data('img');
  var arr = mail.new.attachments;
  var pos = arr.indexOf(image);
  var removedItem = arr.splice(pos, 1);

  $(this).parent().parent().remove();
});

// mail view
mail.view.load = function (
  sender,
  time,
  sendermail,
  subject,
  text,
  attachments
) {
  $('#mail-view-sender').html(sender);
  $('#mail-view-time').html(time);
  $('#mail-view-sendermail').html(sendermail);
  $('#mail-view-subject').html(subject);
  $('#mail-view-text').html(text);

  var html = '';

  if (attachments.length > 0) {
    $('#mail-view-attachments-headline').show(0);
  } else {
    $('#mail-view-attachments-headline').hide(0);
  }

  attachments.forEach((element) => {
    html =
      html +
      `<div class="phone-app-pictureelement">
        <div class="imagecontainer"> 
            <img src="${element}" alt="" class="image pictureelementimage">
        </div>
    </div>`;
  });

  $('#mail-view-attachments').html(html);

  mail.footer.open('#mail-view');
};

$(document).on('click', '#mail-view-return', function () {
  mail.footer.open(mail.lasttabopen);
});

$(document).on('click', '#mail-options-answer', function () {
  SlideUpPage.show('mail-new');
  $('#mail-new-input-receiver-1').val(mail.open.sender);
});

$(document).on('click', '#mail-options-answer', function () {
  sendData('mail:delete', {
    id: mail.open.id,
  });
});

var hepreview = false;
$(document).on('click', '.hepreview', function () {
  if (hepreview == true) return;
  hepreview = true;
  var parent = $(this).parent();
  var curHeight = parent.children('div.hid');

  if (parent.hasClass('phone-app-hideelementactiv')) {
    parent.children('div.hid').slideUp(400);

    parent.removeClass('phone-app-hideelementactiv');
  } else {
    parent.children('div.hid').css({
      height: 'auto',
    });
    parent.children('div.hid').hide(0);
    parent.children('div.hid').slideDown(400);
    parent.addClass('phone-app-hideelementactiv');
  }
  setTimeout(() => {
    hepreview = false;
  }, 400);
});

//
$(document).on('click', '.pictureelementimage', function () {
  gallery.camera.open($(this).attr('src'));
});
