var footerprogress = false;
class Footer {
  constructor(app, open) {
    this.app = app;
    this.lasttabopen = open;
    this.opentab = open;
  }

  open(newopen) {
    if (footerprogress) return;
    if (newopen == this.opentab) return;
    footerprogress = true;
    var opentab = `#${this.app}-${this.opentab}`;
    var newtab = `#${this.app}-${newopen}`;
    setTimeout(function () {
      $(opentab).animate({
        'margin-left': '100%',
      });
      $(newtab).css({
        'margin-left': '0%',
        'margin-right': '100%',
      });
      setTimeout(function () {
        $(newtab).animate(
          {
            'margin-right': '0%',
          },
          400
        );
      }, 10);
    }, 10);

    setTimeout(() => {
      footerprogress = false;
    }, 400);

    $(`.${this.app}footer`).each(function (index, element) {
      var e = $(element);
      if (e.data('new') == newopen) {
        $(this).addClass('purplecolor');
      } else {
        $(this).removeClass('purplecolor');
      }
    });
  }
}
