Inputarea = {
  e: $('#general-inputarea'),
  task: 'null',
};

Inputarea.show = function (task, icon, locl, placeholder, showback) {
  var e = Inputarea.e;
  var icone = $('#general-inputarea-title-i');
  var title = $('#general-inputarea-title');
  var input = $('#general-inputarea-input');
  icone.attr('class', icon);
  title.html(locale[locl]);
  input.attr('placeholder', locale[placeholder]);
  input.val('');

  if (showback) $('#general-inputarea-back').show();
  if (!showback) $('#general-inputarea-back').hide();

  Inputarea.task = task;

  BottomSlideUp('#general-inputarea', 500, 5);
};

$.fn.setClass = function (classes) {
  this.attr('class', classes);
  return this;
};

Inputarea.hide = () => {
  BottomSlideDown('#general-inputarea', 500, -70);
};

$(document).on('click', '#general-inputarea-submit', function () {
  Inputarea.submit();
});

$(document).on('click', '#general-inputarea-cancel', function () {
  Inputarea.hide();
});

Inputarea.submit = () => {
  var val = $('#general-inputarea-input').val();
  switch (Inputarea.task) {
    case 'ringtonevolume': {
      call.sound.setvolume(val);
    }
    default: {
      Inputarea.hide();
    }
  }
};
