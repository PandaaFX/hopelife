let gallery = {
  footer: {
    state: true,
    select: {
      state: false,
      selected: [],
    },
  },
  open: {
    link: null,
    id: null,
  },
  camera: {},
  inaction: false,
  tabopen: '#gallery-home',
  lasttabopen: null,
  webimage: {},
};

$(function () {
  window.addEventListener('message', function (event) {
    var v = event.data;

    if (v.app == 'gallery' && v.task == 'load') {
      gallery.load(v.html);
    } else if (v.app == 'gallery' && v.task == 'add') {
      gallery.add(v.html);
    }

    if (v.app == 'gallery' && v.task == 'newphoto') {
      gallery.camera.open(v.url);
    } else if (v.app == 'gallery' && v.task == 'loadcontacts') {
      gallery.showinchat(v.html);
    }
  });
});

gallery.show = function () {
  gallery.emptyspace();

  var mydiv = $('#gallery-home');
  mydiv.scrollTop(1000000);

  ShowHomebar();
  $('#gallery').css({
    'z-index': '2',
  });
  $('#gallery').animate({
    left: '0%',
  });

  Main.openapp = 'gallery';
};

gallery.hide = function () {
  $('#phone-homebar').hide(500);
};

// Home
gallery.load = function (html) {
  $('.gallery-elements').html('');
  $('.gallery-elements').append(html);
  gallery.emptyspace();
};

gallery.add = function (html) {
  $('.gallery-elements').prepend(html);
  gallery.emptyspace();
};

$(document).on('click', '#gallery-selectbutton', function () {
  if (gallery.inaction == true) return;

  if (gallery.footer.state) {
    gallery.footer.state = false;
    gallery.footer.select.state = true;
    $(this).html('Cancel');
    $(this).addClass('redcolor');
  } else {
    gallery.footer.state = true;
    gallery.footer.select.state = false;
    $(this).html('Select');
    $(this).removeClass('redcolor');
    gallery.clearselected();
  }

  gallery.footer.show(gallery.footer.state);
  gallery.footer.select.show(gallery.footer.select.state);
  gallery.setaction();
});

gallery.setaction = function () {
  gallery.inaction = true;
  setTimeout(function () {
    gallery.inaction = false;
  }, 300);
};

gallery.footer.select.show = function (state) {
  let height = 0;

  if (state == true) height = 100;

  $('#gallery-footer-select').animate(
    {
      height: `${height}%`,
    },
    25
  );
};

gallery.footer.show = function (state) {
  let height = 0;

  if (state == true) height = 100;

  $('#gallery-footer').animate(
    {
      height: `${height}%`,
    },
    25
  );
};

$(document).on('click', '.gallery-element', function () {
  let id = $(this).data('id');
  let time = $(this).data('time');
  let image = $(this).children('img').attr('src');
  if (gallery.footer.select.state) {
    if ($(this).children('i.checked.fa-solid.fa-circle-check').is(':visible')) {
      $(this).children('i.checked.fa-solid.fa-circle-check').hide(500);
      $(this).children('div.checkedbg').fadeOut(500);

      let pos = gallery.footer.select.selected.indexOf(id);
      gallery.footer.select.selected.splice(pos, 1);
    } else {
      $(this).children('i.checked.fa-solid.fa-circle-check').show(500);
      $(this).children('div.checkedbg').fadeIn(500);
      gallery.footer.select.selected.push({
        id: id,
        image: image,
      });
    }
  } else {
    SlideUpPage.show('gallery-image');
    gallery.open.link = image;
    gallery.open.id = id;
    $('#gallery-image-added').html(time);
    document.getElementById('gallery-image-img').src = image;
  }
});

$(document).on('click', '#gallery-footer-select-delete', function () {
  gallery.delete();
});

$(document).on('click', '#gallery-footer-select-share', function () {
  BottomSlideUp('#gallery-share', 500, 5);
});

$(document).on('click', '#gallery-share-cancel', function () {
  BottomSlideUp('#gallery-share', 500, -70);
  // gallery.share(gallery.footer.select.selected)
});

gallery.delete = function (idarray) {
  var idarray = gallery.footer.select.selected;

  sendData('gallery:delete', {
    ids: idarray,
  });

  idarray.forEach(function (item, index, array) {
    $('.gallery-element').each(function (i, e) {
      if ($(this).data('id') == item.id) {
        var element = $(this);
        element.animate({
          width: '0%',
        });
        setTimeout(function () {
          element.remove();
          let pos = gallery.footer.select.selected.indexOf(item.id);
          gallery.footer.select.selected.splice(pos, 1);
        }, 500);
      }
    });
  });
  gallery.emptyspace();
};

gallery.clearselected = function () {
  $('.gallery-element').each(function (i, e) {
    if ($(this).children('i.checked.fa-solid.fa-circle-check').is(':visible')) {
      let id = $(this).data('id');
      $(this).children('i.checked.fa-solid.fa-circle-check').hide(500);
      $(this).children('div.checkedbg').fadeOut(500);
    }
  });

  gallery.footer.select.selected = [];
};

gallery.share = function () {
  var idarray = gallery.footer.select.selected;
  idarray.forEach(function (item, index, array) {
    $('.gallery-element').each(function (i, e) {
      if ($(this).data('id') == item) {
        var element = $(this);
        element.animate({
          width: '0%',
        });
        setTimeout(function () {
          element.remove();
          gallery.footer.select.selected.splice(index, 1);
        }, 500);
      }
    });
  });
  gallery.emptyspace();
};

const galleryemptyspacediv = document.createElement('div');
var emptyspaceactiv = false;
gallery.emptyspace = function () {
  let elements = $('.gallery-elements');
  let height = elements.height();

  if (height > 450) {
    if (emptyspaceactiv == false) {
      elements.append(galleryemptyspacediv);
      galleryemptyspacediv.classList.add('gallery-emptyspace');
      emptyspaceactiv = true;
    }
  } else {
    galleryemptyspacediv.classList.remove('gallery-emptyspace');
    emptyspaceactiv = false;
  }
};

//  SlideUp Image
$(document).on('click', '#gallery-image-copylink', function () {
  if (gallery.open.link == null) return;
  info.load(gallery.open.link);
});

$(document).on('click', '#gallery-image-fullscreen', function () {
  if (gallery.open.link == null) return;
  var image = gallery.open.link;
  $('.image-preview').fadeIn(500);

  document.getElementById('image-preview-image').src = image;
});

$(document).on('click', '#gallery-image-wallpaper', function () {
  if (gallery.open.link == null) return;
  var image = gallery.open.link;
  sendData('changewallpaper', {
    url: image,
  });
});

$(document).on('click', '#gallery-image-airdrop', function () {
  if (gallery.open.link == null) return;
  let image = gallery.open.link;
  let images = [];
  images.push({
    id: 123321,
    image: gallery.open.link,
  });
  sendData('gallery:share:airdrop', {
    images: images,
  });
});

$(document).on('click', '#gallery-image-chat', function () {
  if (gallery.open.link == null) return;
  gallery.footer.select.selected.push({
    id: gallery.open.id,
    image: gallery.open.link,
  });

  sendData('gallery:loadcontacts');
});

$(document).on('click', '#gallery-image-discord', function () {
  if (gallery.open.link == null) return;
  sendData('gallery:share:discord', {
    images: gallery.open.link,
  });
});

gallery.showinchat = function (html) {
  $('#share-messages-elements').html('');
  $('#share-messages-elements').html(html);
  SlideUpPage.show('share-messages');
};

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

  sendData('gallery:share:chat', {
    receivers: receivers,
    images: images,
  });

  gallery.footer.select.selected = [];
});

$(document).on('click', '#share-messages-close', function () {
  gallery.footer.select.selected = [];
});

$(document).on('click', '#gallery-image-delete', function () {
  SlideUpPage.hide();
  var id = gallery.open.id;
  $('.gallery-element').each(function (i, e) {
    if ($(this).data('id') == id) {
      var element = $(this);
      element.animate({
        width: '0%',
      });
      setTimeout(function () {
        element.remove();
      }, 500);
    }
  });

  sendData('gallery:delete', {
    ids: id,
  });
});

//  BottomSlideUp('#messages-inputimageurl-area', 500, 5);

// Multi elements
$(document).on('click', '#gallery-share-discord', function () {
  let images = gallery.footer.select.selected;

  sendData('gallery:share:discord', {
    images: images,
  });
});

$(document).on('click', '#gallery-share-airdrop', function () {
  let images = gallery.footer.select.selected;

  sendData('gallery:share:airdrop', {
    images: images,
  });
});

$(document).on('click', '#gallery-share-messages', function () {
  sendData('gallery:loadcontacts');
});

// Camera
gallery.camera.open = function (link) {
  document.getElementById('camera-new-img').src = link;
  gallery.open.link = link;
  SlideUpPage.show('camera-new');
};

gallery.camera.resetimage = function () {
  document.getElementById('camera-new-img').src =
    'https://c.tenor.com/FBeNVFjn-EkAAAAC/ben-redblock-loading.gif';
};

gallery.webimage.resetimage = function () {
  document.getElementById('gallery-webimage-img').src =
    'https://c.tenor.com/FBeNVFjn-EkAAAAC/ben-redblock-loading.gif';
  $('#gallery-webimage-input').val('');
};

$(document).on('click', '#camera-new-save', function () {
  if (gallery.open.link == null) return;

  SlideUpPage.hide();

  sendData('gallery:save', {
    link: gallery.open.link,
  });
});

$(document).on('click', '#camera-new-delete', function () {
  if (gallery.open.link == null) return;
  SlideUpPage.hide();
  Notify('deletedimage', 'warning');
});

// webimage

$(document).on('click', '#gallery-settings-webimage', function () {
  SlideUpPage.show('gallery-webimage');
});

$(document).on('click', '#gallery-webimage-show', function () {
  var img = $('#gallery-webimage-input').val();

  var okay = CheckStringLength(img);
  if (okay == false) return;

  var okay2 = CheckImage(img);
  if (okay2 == false) return;

  gallery.open.link = img;
  document.getElementById('gallery-webimage-img').src = img;

  $('#gallery-webimage-img').on('error', function () {
    $(this).attr(
      'src',
      'https://c.tenor.com/FBeNVFjn-EkAAAAC/ben-redblock-loading.gif'
    );
    gallery.open.link = null;
    Notify('invalidlink', 'error');
  });
});

gallery.showwebimage = function (url) {
  SlideUpPage.show('gallery-webimage');

  gallery.open.link = url;
  document.getElementById('gallery-webimage-img').src = url;
};

// Footer

$(document).on('click', '#footer-gallery-home', function () {
  gallery.footer.open('#gallery-home');

  gallery.footer.icon(this);
});

$(document).on('click', '#footer-gallery-settings', function () {
  gallery.footer.open('#gallery-settings');

  gallery.footer.icon(this);
});

var lastscrollheight;
gallery.footer.open = function (newopen) {
  if (newopen == gallery.tabopen) return;

  setTimeout(function () {
    $(gallery.tabopen).animate({
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
      setTimeout(() => {
        var mydiv = $('#gallery-home');
        mydiv.scrollTop(1000000);
      }, 100);
    }, 10);
    gallery.lasttabopen = gallery.tabopen;
    gallery.tabopen = newopen;
  }, 10);
};

gallery.footer.icon = function (obj) {
  $('#footer-gallery-home').removeClass('purplecolor');
  $('#footer-gallery-settings').removeClass('purplecolor');

  $(obj).addClass('purplecolor');
};

gallery.closeslidedown = function (open) {
  setTimeout(() => {
    if (open == 'camera-new') {
      gallery.camera.resetimage();
    } else if (open == 'gallery-webimage') {
      gallery.webimage.resetimage();
    }
  }, 400);
};
