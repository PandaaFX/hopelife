SlideUpPage = {
  AnimationTime: 500,
  Currentopen: null,
  Lastopen: [],
  Contact: {
    open: 'Gallery',
  },
};

$(function () {
  window.addEventListener('message', function (event) {
    var v = event.data;

    if (v.app == 'slideuppage' && v.task == 'contact:load') {
      SlideUpPage.Contact.open(v.html, v.taskapp);
    }
  });
});

SlideUpPage.show = function (id, bottom) {
  if (SlideUpPage.Lastopen.length > 0) {
    var array = SlideUpPage.Lastopen;
    array.forEach(function (item, index, array) {
      $('#' + item).css({
        'z-index': '3',
      });
    });
    $('#' + id).css({
      'z-index': '4',
    });
  }

  $('#' + id)
    .children('div.elements')
    .animate({ scrollTop: 0 }, 'fast');
  if (bottom == null) {
    $('#' + id).animate(
      {
        bottom: '0',
      },
      SlideUpPage.AnimationTime
    );
  } else {
    $('#' + id).animate(
      {
        bottom: bottom,
      },
      SlideUpPage.AnimationTime
    );
  }

  SlideUpPage.Currentopen = id;
  SlideUpPage.Lastopen.push(SlideUpPage.Currentopen);
};

$(document).on('click', '.slideuppageclose', function () {
  SlideUpPage.hide();
});

SlideUpPage.hide = function () {
  let open = SlideUpPage.Currentopen;
  let lastopenarr = SlideUpPage.Lastopen;
  let lastopen = lastopenarr[lastopenarr.length - 1];
  $('#' + open).animate(
    {
      bottom: '-95%',
    },
    SlideUpPage.AnimationTime
  );

  setTimeout(function () {
    $('#' + open).css({
      'z-index': '3',
    });
  }, SlideUpPage.AnimationTime);

  gallery.closeslidedown(open);

  SlideUpPage.Currentopen = lastopen;
  SlideUpPage.Lastopen.pop();
};

SlideUpPage.hideall = function () {
  let open = SlideUpPage.Currentopen;
  let lastopenarr = SlideUpPage.Lastopen;

  lastopenarr.forEach((element) => {
    $('#' + element).animate(
      {
        bottom: '-95%',
      },
      SlideUpPage.AnimationTime
    );

    setTimeout(function () {
      $('#' + element).css({
        'z-index': '3',
      });
    }, SlideUpPage.AnimationTime);
  });

  gallery.closeslidedown(open);

  SlideUpPage.Currentopen = null;
  SlideUpPage.Lastopen = [];
};

// SlideUpPage contact
SlideUpPage.Contact.open = function (html, app) {
  $('#share-messages-elements').html('');
  $('#share-messages-elements').html(html);
  SlideUpPage.show('share-messages');
  SlideUpPage.Contact.open = app;
};

$(document).on('click', '.checkbox', function () {
  if ($(this).hasClass('checked')) {
    $(this).removeClass('checked');
  } else {
    $(this).addClass('checked');
  }
});

$(document).on('click', '#share-messages-submit', function () {
  var receivers = [];
  let images = gallery.footer.select.selected;

  $('.sharemessageelement').each(function (i, e) {
    if ($(this).children('div').hasClass('checked')) {
      let number = $(this).data('number');
      let name = $(this).data('name');
      receivers.push({
        number: number,
        name: name,
      });
    }
  });
  SlideUpPage.hide();
  if (receivers.length == 0) return;

  if (SlideUpPage.Contact.open == 'Gallery') {
    sendData('gallery:share:chat', {
      receivers: receivers,
      images: images,
    });
  } else if (SlideUpPage.Contact.open == 'Call') {
    console.log(receivers);
    sendData('call:addtocall', {
      receivers: receivers,
    });
  }

  gallery.footer.select.selected = [];
});

$(document).on('click', '#share-messages-close', function () {
  gallery.footer.select.selected = [];
});
