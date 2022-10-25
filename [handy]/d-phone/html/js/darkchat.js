var darkchat = {
  overview: {},
  new: {
    name: null,
    image: null,
  },
  chat: {},
  settings: {
    open: null,
  },
  user: {},
  isadmin: true,
  codeactiv: 1,

  tabopen: '#darkchat-overview',
  lasttabopen: null,
  loaded: false,
  opencontact: {
    identifier: null,
  },
  hasaccount: true,
};

$(document).keyup(function (data) {
  if (data.which == 13) {
    if (darkchat.tabopen == '#darkchat-chat' && Main.openapp == 'darkchat') {
      messages.SendMessage();
    }
  }
});

$(function () {
  $('#darkchat-alerts').hide(0);
  window.addEventListener('message', function (event) {
    var v = event.data;

    if (v.app == 'darkchat' && v.task == 'opentab') {
      if (darkchat.opencontact.identifier != null) {
        $('#darkchat-member').animate(
          {
            'margin-left': '-30vh',
          },
          400
        );
        setTimeout(function () {
          $('#darkchat-member').css({
            display: 'none',
            'z-index': '2',
          });
        }, 400);
        darkchat.opencontact.identifier = null;
      }

      darkchat.open(v.tab);
    }

    if (v.app == 'darkchat' && v.task == 'nouserdata') {
      darkchat.open('#darkchat-createaccount');
      $('#darkchat-alerts').hide(0);
    }

    if (v.app == 'darkchat' && v.task == 'overview:load') {
      darkchat.overview.load(v.html);

      let unreadhtml = v.unread;
      if (v.unread > 99) {
        unreadhtml = '99+';
      }

      if (v.unread > 0) {
        $('#darkchat-alerts').show(0);
      } else {
        $('#darkchat-alerts').hide(0);
      }

      $('#darkchat-alerts').html(unreadhtml);
    }

    if (v.app == 'darkchat' && v.task == 'setpermission') {
      darkchat.isadmin = v.state;
      darkchat.codeactiv = v.codeactiv;
      darkchat.settings.setpermission();
    }

    if (v.app == 'darkchat' && v.task == 'chat:load') {
      darkchat.chat.load(v.html, v.label, v.image);
    } else if (v.app == 'darkchat' && v.task == 'chat:add') {
      darkchat.chat.add(v.html);
    }

    if (v.app == 'darkchat' && v.task == 'settings:loadparticipatans') {
      darkchat.settings.loadparticipatans(v.html);
    } else if (v.app == 'darkchat' && v.task == 'settings:change') {
      darkchat.settings.setimage(v.image);
      darkchat.settings.setlabel(v.label);
    }

    if (v.app == 'darkchat' && v.task == 'settings:setname') {
      darkchat.user.setname(v.name);
    }
  });
});

// General
darkchat.show = function () {
  ShowHomebar();

  if (darkchat.hasaccount == false) {
    darkchat.open('#darkchat-createaccount');
  }

  $('#darkchat').animate({
    left: '0%',
  });
  Main.openapp = 'darkchat';

  SetTheme('darkchat');

  if (darkchat.loaded == false) {
    sendData('darkchat:loadoverview');
  }
};

darkchat.open = function (newopen) {
  if (newopen == darkchat.tabopen) return;

  setTimeout(function () {
    $(darkchat.tabopen).animate({
      'margin-left': '100%',
    });
    $(newopen).css({
      'margin-left': '0%',
      'margin-right': '100%',
    });
    // if (newopen == "#darkchat-overview") {
    //     $(".darkchat-overview-new").show(500)
    //     $(".darkchat-overview-join").show(500)
    // } else {
    //     $(".darkchat-overview-new").hide(500)
    //     $(".darkchat-overview-join").hide(500)
    // }
    setTimeout(function () {
      $(newopen).animate(
        {
          'margin-right': '0%',
        },
        500
      );

      if (newopen == '#darkchat-overview') {
        $('#darkchat-footer-home').removeClass('purplecolor');
        $('#darkchat-footer-user').removeClass('purplecolor');
        $('#darkchat-overview-join').removeClass('purplecolor');
        $('#darkchat-footer-home').addClass('purplecolor');
      }

      if (newopen == '#darkchat-createaccount') {
        $('#darkchat-footer').hide(0);
      }
    }, 10);

    $('#darkchat-joingroup-code').val('');

    darkchat.lasttabopen = darkchat.tabopen;
    darkchat.tabopen = newopen;
  }, 10);
};

darkchat.hide = function () {
  $('#phone-homebar').hide(500);
};

// Overview
darkchat.overview.load = function (html) {
  $('#darkchat-overview-container').html('');
  $('#darkchat-overview-container').html(html);

  darkchat.loaded = true;
  var $wrapper = $('#darkchat-overview-container');

  $wrapper
    .find('.groupchat-overview-element')
    .sort(function (a, b) {
      return -a.getAttribute('data-place') + +b.getAttribute('data-place');
    })
    .appendTo($wrapper);

  var skr = [
    'groupchat-new-name',
    'groupchat-new-imageinput',
    'groupchat-chat-input',
    'groupchat-settings-inputarea-urlinput',
  ];
  DontWalk(skr);
};

$(document).on('click', '.darkchat-overview-element', function () {
  var group = $(this).data('group');

  sendData('darkchat:load', {
    group: group,
  });
});

$(document).on('click', '#darkchat-footer-home', function () {
  darkchat.open('#darkchat-overview');

  $('#darkchat-footer-home').removeClass('purplecolor');
  $('#darkchat-footer-user').removeClass('purplecolor');
  $('#darkchat-overview-join').removeClass('purplecolor');
  $(this).addClass('purplecolor');
});

$(document).on('click', '#darkchat-footer-user', function () {
  darkchat.open('#darkchat-user');

  $('#darkchat-footer-home').removeClass('purplecolor');
  $('#darkchat-footer-user').removeClass('purplecolor');
  $('#darkchat-overview-join').removeClass('purplecolor');
  $(this).addClass('purplecolor');
});

$(document).on('click', '#darkchat-overview-new', function () {
  darkchat.open('#darkchat-new');
});

// Create
$(document).on('click', '#darkchat-overview-join', function () {
  darkchat.open('#darkchat-joingroup');

  $('#darkchat-footer-home').removeClass('purplecolor');
  $('#darkchat-footer-user').removeClass('purplecolor');
  $('#darkchat-overview-join').removeClass('purplecolor');
  $(this).addClass('purplecolor');
});

$(document).on('click', '#darkchat-joingroup-hidepassword', function () {
  var input = $('#darkchat-joingroup-code');
  var type = input.attr('type');

  if (type == 'password') {
    input.prop('type', 'text');
    $(this).html('Hide code');
  } else {
    input.prop('type', 'password');
    $(this).html('Show code');
  }
});

$(document).on('click', '#darkchat-joingroup-submit', function () {
  var input = $('#darkchat-joingroup-code');
  var code = input.val();

  sendData('darkchat:join', {
    code: code,
  });

  darkchat.open('#darkchat-overview');
  input.val('');
});

$(document).on('click', '#darkchat-joingroup-back', function () {
  darkchat.open('#darkchat-overview');
});

// New
$(document).on('click', '#darkchat-settings-conctact-return', function () {
  darkchat.open('#darkchat-overview');
});

$(document).on('click', '#darkchat-new-save', function () {
  var groupname = $('#darkchat-new-name').val();
  var groupimage = $('#darkchat-new-imageinput').val();
  var invitecode = $('#darkchat-new-code').val();

  darkchat.new.name = groupname;
  darkchat.new.image = groupimage;

  if (groupname != '') {
    // groupchat.open("#groupchat-settings-contact")
    if (invitecode == '') return;
    if (groupimage == '')
      darkchat.new.image =
        'https://cdn.icon-icons.com/icons2/1861/PNG/512/hacker_118137.png';
    sendData('darkchat:new:save', {
      name: darkchat.new.name,
      image: darkchat.new.image,
      code: invitecode,
    });
    darkchat.open('#darkchat-overview');
    $('#darkchat-new-name').val('');
    $('#darkchat-new-imageinput').val('');
    $('#darkchat-new-code').val('');
  }
});

$(document).on('click', '#darkchat-new-testimage', function () {
  var url = $('#darkchat-new-imageinput').val();

  var okay = CheckStringLength(url);

  if (okay == false) return;

  $('#darkchat-new-image').attr('src', url);
});

$(document).on('click', '#darkchat-new-hidepassword', function () {
  var input = $('#darkchat-new-code');
  var type = input.attr('type');

  if (type == 'password') {
    input.prop('type', 'text');
    $(this).html('Hide code');
  } else {
    input.prop('type', 'password');
    $(this).html('Show code');
  }
});

// Create account
$(document).on('click', '#darkchat-createaccount-submit', function () {
  var name = $('#darkchat-createaccount-name').val();

  var okay = CheckStringLength(name);

  if (okay == false) return;
  if (name == '') return;

  sendData('darkchat:createaccount', {
    name: name,
  });
  $('#darkchat-footer').show(0);
  $('#darkchat-createaccount-name').val('');
});

// Chat

darkchat.chat.load = function (html, label, image) {
  $('#darkchat-chat-content').html('');
  $('#darkchat-chat-content').html(html);
  $('#darkchat-chat-content').animate({ scrollTop: 9999 });
  var height = 40.5;
  if (Main.openapp == 'darkchat') height = 40.5;

  $('#' + Main.openapp + '-chat-content').css({
    height: height + 'vh',
  });

  if (messages.chat.addedimages.length == 1) {
    height -= 7;
    $('#' + Main.openapp + '-chat-content').animate({
      height: height + 'vh',
    });
    $('#' + Main.openapp + '-chat-imagearea').animate({
      height: '7vh',
    });
  } else if (messages.chat.addedimages.length >= 2) {
    height -= 8;
    $('#' + Main.openapp + '-chat-content').animate({
      height: height + 'vh',
    });
    $('#' + Main.openapp + '-chat-imagearea').animate({
      height: '8vh',
    });
  }

  darkchat.open('#darkchat-chat');

  darkchat.settings.setimage(image);
  darkchat.settings.setlabel(label);
};

darkchat.chat.add = function (html) {
  $('#darkchat-chat-content').append(html);
  var height = 40.5;
  if (Main.openapp == 'darkchat') height = 40.5;

  $('#' + Main.openapp + '-chat-content').css({
    height: height + 'vh',
  });
};

$(document).on('click', '.darkchat-chat-opensettings', function () {
  darkchat.open('#darkchat-settings');
});

$(document).on('click', '#darkchat-chat-add', function () {
  BottomSlideUp('#messages-inputarea', 500, 5);
  $('.censorlayer').fadeIn(500);
  messages.plusmenu.openapp = 'darkchat';
  $('#business-chat-delete').hide(0);
});

$(document).on('click', '#darkchat-chat-sendmessage', function () {
  messages.SendMessage();
});

$(document).on('click', '#darkchat-chat-return', function () {
  darkchat.open('#darkchat-overview');
});

// Settings
$(document).on('click', '#darkchat-settings-return', function () {
  darkchat.open('#darkchat-chat');
  darkchat.settings.inputarea(0);
  darkchat.settings.selectionarea(0);
});

darkchat.settings.loadparticipatans = function (html) {
  $('.darkchat-settings-participants').html('');
  $('.darkchat-settings-participants').html(html);

  var $wrapper = $('.darkchat-settings-participants');

  $('.darkchat-setting-element')
    .sort(function (a, b) {
      if (a.textContent < b.textContent) {
        return -1;
      } else {
        return 1;
      }
    })
    .appendTo($wrapper);

  $wrapper
    .find('.darkchat-setting-element')
    .sort(function (a, b) {
      return -a.getAttribute('data-contact') + +b.getAttribute('data-contact');
    })

    .appendTo($wrapper);

  $wrapper
    .find('.darkchat-setting-element')
    .sort(function (a, b) {
      return -a.getAttribute('data-admin') + +b.getAttribute('data-admin');
    })

    .appendTo($wrapper);

  $wrapper
    .find('.darkchat-setting-element')
    .sort(function (a, b) {
      return -a.getAttribute('data-me') + +b.getAttribute('data-me');
    })

    .appendTo($wrapper);
};

darkchat.settings.setimage = function (imageurl) {
  $('#darkchat-settings-image').attr('src', imageurl);
  $('#darkchat-chat-image').attr('src', imageurl);
};

darkchat.settings.setlabel = function (label) {
  $('#darkchat-settings-name').html(label);
  $('#darkchat-chat-name').html(label);
};

darkchat.settings.setpermission = function () {
  if (darkchat.isadmin == true) {
    $('#darkchat-settings-group-photo').show(0);
    $('#darkchat-settings-group-name').show(0);
    $('#darkchat-settings-code-change').show(0);
    $('#darkchat-settings-code-deactivate').hide(0);
    $('#darkchat-settings-code-activate').hide(0);
    if (darkchat.codeactiv == 1)
      $('#darkchat-settings-code-deactivate').show(0);
    if (darkchat.codeactiv == 0) $('#darkchat-settings-code-activate').show(0);
  } else {
    $('#darkchat-settings-group-photo').hide(0);
    $('#darkchat-settings-group-name').hide(0);
    $('#darkchat-settings-code-change').hide(0);
    $('#darkchat-settings-code-deactivate').hide(0);
    $('#darkchat-settings-code-activate').hide(0);
  }
};

$(document).on('click', '#darkchat-settings-group-photo', function () {
  darkchat.settings.selectionarea(1);
  darkchat.settings.open = 'photo';
  $('#darkchat-settings-inputarea-headline').html(
    '<i class="fa-solid fa-image"></i> ENTER IMAGE URL'
  );
  $('#darkchat-settings-inputarea-back').show(0);
});

$(document).on('click', '#darkchat-settings-img-photo', function () {
  darkchat.settings.selectionarea(1);
  darkchat.settings.open = 'photo';
  $('#darkchat-settings-inputarea-headline').html(
    '<i class="fa-solid fa-image"></i> ENTER IMAGE URL'
  );
  $('#darkchat-settings-inputarea-back').show(0);
  var input = $('#darkchat-settings-inputarea-urlinput');
  input.prop('type', 'text');
});

$(document).on('click', '#darkchat-settings-group-name', function () {
  darkchat.settings.inputarea(1);
  darkchat.settings.open = 'name';
  $('#darkchat-settings-inputarea-headline').html(
    '<i class="fa-solid fa-signature"></i>  ENTER NAME'
  );
  $('#darkchat-settings-inputarea-back').hide(0);
  var input = $('#darkchat-settings-inputarea-urlinput');
  input.prop('type', 'text');
});

$(document).on('click', '#darkchat-settings-code-change', function () {
  darkchat.settings.inputarea(1);
  darkchat.settings.open = 'code';
  $('#darkchat-settings-inputarea-headline').html(
    '<i class="fa-solid fa-lock"></i> ENTER CODE'
  );
  var input = $('#darkchat-settings-inputarea-urlinput');
  input.prop('type', 'password');

  $('#darkchat-settings-inputarea-back').hide(0);
});

$(document).on('click', '#darkchat-settings-selectionarea-cancel', function () {
  darkchat.settings.selectionarea(0);
});

$(document).on(
  'click',
  '#business-teamchat-selection-inputarea-image',
  function () {
    darkchat.settings.selectionarea(0);
    darkchat.settings.inputarea(1);
  }
);

$(document).on(
  'click',
  '#business-teamchat-selection-inputarea-image',
  function () {
    darkchat.settings.selectionarea(0);
    darkchat.settings.inputarea(1);
  }
);

$(document).on('click', '#darkchat-settings-inputarea-back', function () {
  darkchat.settings.inputarea(0);
  darkchat.settings.selectionarea(1);
});

$(document).on('click', '#darkchat-settings-inputarea-cancel', function () {
  darkchat.settings.inputarea(0);
  $('#darkchat-settings-inputarea-urlinput').val('');
});

$(document).on('click', '#darkchat-settings-inputarea-submit', function () {
  darkchat.settings.inputarea(0);
  var input = $('#darkchat-settings-inputarea-urlinput').val();

  var okay = CheckStringLength(input);

  if (okay == false) return;

  if (darkchat.settings.open == 'photo') {
    darkchat.settings.setimage(input);
    sendData('darkchat:change', {
      name: input,
      type: 'image',
    });
  } else if (darkchat.settings.open == 'name') {
    darkchat.settings.setlabel(input);
    sendData('darkchat:change', {
      name: input,
      type: 'label',
    });
  } else if (darkchat.settings.open == 'code') {
    sendData('darkchat:change', {
      name: input,
      type: 'code',
    });
  }

  $('#darkchat-settings-inputarea-urlinput').val('');
});

$(document).on('click', '#darkchat-settings-selectionarea-photo', function () {
  sendData('darkchat:takephoto:change');
  darkchat.settings.selectionarea(0);
});

$(document).on('click', '#darkchat-settings-code-deactivate', function () {
  sendData('darkchat:settings:code:deactivate');
});

$(document).on('click', '#darkchat-settings-code-activate', function () {
  sendData('darkchat:settings:code:activate');
});

darkchat.settings.selectionarea = function (type) {
  if (type == 1) {
    BottomSlideUp('#darkchat-settings-selectionarea', 500, 5);
  } else {
    BottomSlideDown('#darkchat-settings-selectionarea', 500, -70);
  }
};

darkchat.settings.inputarea = function (type) {
  if (type == 1) {
    BottomSlideUp('#darkchat-settings-inputarea', 500, 5);
  } else {
    BottomSlideDown('#darkchat-settings-inputarea', 500, -70);
  }
};

darkchat.settings.userselectionarea = function (type) {
  if (type == 1) {
    BottomSlideUp('#darkchat-settings-user-selectionarea', 500, 5);
  } else {
    BottomSlideDown('#darkchat-settings-user-selectionarea', 500, -70);
  }
};

$(document).on('click', '#darkchat-settings-group-addmember', function () {
  sendData('darkchat:new:addcontact');
  // darkchat.open("#darkchat-settings-contact")
});

$(document).on('click', '#darkchat-settings-contact-save', function () {
  var member = [];
  $('.darkchat-settings-checkbox').each(function () {
    if ($(this).is(':checked')) {
      var number = $(this).parent().data('number');

      member.push({
        number: number.toString(),
        admin: 0,
      });
    }
  });

  if (darkchat.lasttabopen == '#darkchat-new') {
    sendData('darkchat:create', {
      name: darkchat.new.name,
      image: darkchat.new.image,
      member: member,
    });
    darkchat.open('#darkchat-overview');
  } else {
    sendData('darkchat:save', {
      member: member,
    });
  }
});

$(document).on('click', '#darkchat-settings-group-leave', function () {
  sendData('darkchat:leave');
});

$(document).on('click', '.darkchat-setting-element', function () {
  var name = $(this).data('name');
  var number = $(this).data('number');
  var admin = $(this).data('admin');
  var contact = $(this).data('contact');
  var me = $(this).data('me');
  var identifier = $(this).data('identifier');
  SetTheme('darkchat');

  selectednumber = number;
  selectedname = name;
  if (me == '1') return;
  $('#darkchat-member').css({
    display: 'block',
    'z-index': '9',
  });
  $('#darkchat-member').animate(
    {
      'margin-left': '0vh',
    },
    400
  );

  $('#darkchat-member-name').html(name);
  $('#darkchat-member-number').html(number);

  var rank = 'Member';
  if (admin == '1') rank = 'Admin';

  if (darkchat.isadmin == true && admin == '0') {
    $('#darkchat-member-admin').show(0);
    $('#darkchat-member-unadmin').hide(0);
    $('#darkchat-member-kick').show(0);
  } else if (darkchat.isadmin == true && admin == '1') {
    $('#darkchat-member-admin').hide(0);
    $('#darkchat-member-unadmin').show(0);
    $('#darkchat-member-kick').show(0);
  } else {
    $('#darkchat-member-admin').hide(0);
    $('#darkchat-member-unadmin').hide(0);
    $('#darkchat-member-kick').hide(0);
  }

  $('#darkchat-member-rank').html(rank);

  if (contact == '1') {
    $('.darkchat-member-contact').hide(0);
    $('.darkchat-member-addcontact').addClass('redcolor');
  } else {
    $('.darkchat-member-contact').show(0);
    $('.darkchat-member-addcontact').removeClass('redcolor');
  }

  darkchat.opencontact.identifier = identifier;
});

$(document).on('click', '#darkchat-member-return', function () {
  SetTheme('darkchat');
  $('#darkchat-member').animate(
    {
      'margin-left': '-30vh',
    },
    400
  );
  setTimeout(function () {
    $('#darkchat-member').css({
      display: 'none',
      'z-index': '2',
    });
  }, 400);
});

$(document).on('click', '#darkchat-member-add-addcontact', function () {
  currentpage = '#phone-app-contact-new';
  lastpage = '#darkchat-member';

  var number = selectednumber;

  $('#phone-app-contact-phonenumber').val(number);
  AppSlideIn(currentpage, lastpage);
  $('#phone-app-contact-new').css({
    'z-index': '2',
  });
});

$(document).on('click', '#darkchat-member-admin', function () {
  sendData('darkchat:admin', {
    number: darkchat.opencontact.identifier,
  });
});

$(document).on('click', '#darkchat-member-unadmin', function () {
  sendData('darkchat:unadmin', {
    number: darkchat.opencontact.identifier,
  });
});

$(document).on('click', '#darkchat-member-kick', function () {
  sendData('darkchat:kick', {
    number: darkchat.opencontact.identifier,
  });
});

$(document).on('click', '#darkchat-member-add-message', function () {
  $('#darkchat-member').animate(
    {
      'margin-left': '-30vh',
    },
    400
  );
  $('#darkchat').animate(
    {
      left: '-100%',
    },
    400
  );
  setTimeout(function () {
    $('#darkchat-member').css({
      display: 'none',
      'z-index': '2',
    });
  }, 400);

  sendData('loadmessage', {
    number: selectednumber,
    contact: selectedname,
  });
  lastcontact = 'message';
});

// User
darkchat.user.setname = function (name) {
  $('#darkchat-user-name').html(name);
};

$(document).on('click', '#darkchat-user-deleteaccount', function () {
  sendData('darkchat:user:deleteaccount');
});
