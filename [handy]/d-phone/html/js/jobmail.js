jobmail = {
    home: {},
    sent: {},
    new: {
        receivers: 1
    },
    user: {},
    view: {},
    adressbook: {},
    footer : {},
    open: {},
    ready: false,
    tabopen:"#jobmail-home",
    lasttabopen: null
}

$(function() {
    window.addEventListener("message", function(event) {
        var v = event.data;

        if (v.app == "jobmail" && v.task == "load") {
            jobmail.home.load(v.html)
            $("#jobmailiicon").show(0)
        }  else if (v.app == "jobmail" && v.task == "sent:load") {

            jobmail.sent.load(v.html)
        }  

        if (v.app == "jobmail" && v.task == "deletemail") {
            $("#jobmail-footer-addressbook").hide(0)
            $("#jobmailiicon").hide(0)
            if (Main.openapp == "jobmail") CloseAll()
        }

        if (v.app == "jobmail" && v.task == "view") {
            mail.open = v.mail
            jobmail.view.load(v.mail.senderlabel, v.time, v.receivers, v.mail.subject, v.mail.text, v.from, v.mail.attachments)
            $("#jobmail-options").show()
        } else if (v.app == "jobmail" && v.task == "sentview") {
            jobmail.view.load(v.receiverslabel, v.time, v.receivers, v.mail.subject, v.mail.text, v.from, v.mail.attachments)
            $("#jobmail-options").hide(0)
        } 

        if (v.app == "jobmail" && v.task == "loadmaillist") {
            jobmail.adressbook.load(v.html)
        }

        if (v.app == "jobmail" && v.task == "user:setmail") {
            $("#jobmail-user-mail").html(v.mail)
            $("#jobmail-footer-addressbook").hide(0)
        }
    })
});

jobmail.show = function() {
    ShowHomebar()

    SetTheme(business.job)


    $("#jobmail").css({
        "z-index": "2"
    })
    $("#jobmail").animate({
        "left": "0%"
    })

    Main.openapp = "jobmail"
}

jobmail.hide = function() {
    $("#phone-homebar").hide(500)
}

// Home
jobmail.home.load = function (html) { 
    $("#jobmail-home-container").html(html)

    var $wrapper = $('#jobmail-home-container');

    $wrapper.find('.jobmail-home-element').sort(function (a, b) {
        return -a.getAttribute('data-id') + +b.getAttribute('data-id');
    })
    .appendTo( $wrapper )

    setTimeout(() => {
        jobmail.alert()
    }, 400);
 }

$(document).on('click', '.jobmail-home-element', function() {
    var id = $(this).data("id")
    var mail = $(this).data("mail")
    sendData("jobmail:home:load", {
        id: id,
        mail: mail
    })
});

var mailhomesearchbar = document.forms['jobmail-home-searchbar'].querySelector('input');
mailhomesearchbar.addEventListener('keyup', function(e) {
    const term = e.target.value.toLocaleLowerCase();
    var notAvailable = document.getElementById('notAvailable');
    //   $("#titleMain").toggle($('input').val().length == 0);
    var hasResults = false;
    $(".jobmail-home-element").each(function() {
        if ($(this).data("mail").toString().toLowerCase().includes(term.toString()) || $(this).data("label").toString().toLowerCase().includes(term.toString())) {
            $(this).show(0);
        } else {
            $(this).hide(0);
        }
    })
});

var mailsentsearchbar = document.forms['jobmail-sent-searchbar'].querySelector('input');
mailsentsearchbar.addEventListener('keyup', function(e) {
    const term = e.target.value.toLocaleLowerCase();
    var notAvailable = document.getElementById('notAvailable');
    //   $("#titleMain").toggle($('input').val().length == 0);
    var hasResults = false;
    $(".jobmail-sent-element").each(function() {
        if ($(this).data("mail").toString().toLowerCase().includes(term.toString()) || $(this).data("label").toString().toLowerCase().includes(term.toString())) {
            $(this).show(0);
        } else {
            $(this).hide(0);
        }
    })
});

//  Sent
jobmail.sent.load = function (html) { 
    $("#jobmail-sent-container").html(html)


    var $wrapper = $('#jobmail-sent-container');

    $wrapper.find('.jobmail-sent-element').sort(function (a, b) {
        return -a.getAttribute('data-id') + +b.getAttribute('data-id');
    })
    .appendTo( $wrapper )
 }

 $(document).on('click', '.jobmail-sent-element', function() {
    var id = $(this).data("id")
    var mail = $(this).data("mail")
    sendData("jobmail:sent:load", {
        id: id,
        mail: mail
    })
});


// mail view
jobmail.view.load = function (sender, time, sendermail, subject, text, from, attachments) { 
    $("#jobmail-view-sender").html(sender)
    $("#jobmail-view-time").html(time)
    $("#jobmail-view-frommail").html(from)
    $("#jobmail-view-sendermail").html(sendermail)
    $("#jobmail-view-subject").html(subject)
    $("#jobmail-view-text").html(text)


    var html = ""

    attachments.forEach(element => {
        html = html + `<div class="phone-app-pictureelement">
        <div class="imagecontainer"> 
            <img src="${element}" alt="" class="image pictureelementimage">
        </div>
    </div>`
    });

    if (attachments.length > 0 ) {
        $("#jobmail-view-attachments-headline").show(0)
    } else {
        $("#jobmail-view-attachments-headline").hide(0)
    }

    $("#jobmail-view-attachments").html(html)

    mail.footer.open("#jobmail-view")

 }


$(document).on('click', '#jobmail-view-return', function() {
    mail.footer.open(mail.lasttabopen)
});

$(document).on('click', '#jobmail-options-answer', function() {
    SlideUpPage.show("mail-new")
    $("#mail-new-input-receiver-1").val(mail.open.sender)
});

// $(document).on('click', '#jobmail-options-answer', function() {
//     sendData("jobmail:delete", {
//         id: mail.open.id
//     })
// });

// Footer


jobmail.alert = function () { 
    alerts(".jobmail-home-element", "#jobmail-alerts")
 }

jobmail.footer.open = function(newopen) {
    if (newopen == jobmail.tabopen) return

    setTimeout(function(){
        $(jobmail.tabopen).animate({
            "margin-left": "100%"
        })
        $(newopen).css({
            "margin-left": "0%",
            "margin-right": "100%"
        })
        setTimeout(function(){
            $(newopen).animate({
                "margin-right": "0%"
            }, 500)
        }, 10)
        jobmail.lasttabopen = jobmail.tabopen 
        jobmail.tabopen = newopen
    }, 10)
}

jobmail.footer.icon = function(obj) {
    $("#jobmail-footer-home").removeClass("purplecolor")
    $("#jobmail-footer-sent").removeClass("purplecolor")
    $("#jobmail-footer-newmail").removeClass("purplecolor")
    $("#jobmail-footer-user").removeClass("purplecolor")
    $("#jobmail-footer-addressbook").removeClass("purplecolor")

    $(obj).addClass("purplecolor")
}

$(document).on('click', '#jobmail-footer-newmail', function() {
    SlideUpPage.show("mail-new")
});

$(document).on('click', '#jobmail-footer-home', function() {
    jobmail.footer.open("#jobmail-home")
    jobmail.footer.icon(this)
});

$(document).on('click', '#jobmail-footer-sent', function() {
    jobmail.footer.open("#jobmail-sent")
    jobmail.footer.icon(this)
});

$(document).on('click', '#jobmail-footer-addressbook', function() {
    jobmail.footer.open("#jobmail-addressbook")
    jobmail.footer.icon(this)
});

$(document).on('click', '#jobmail-footer-user', function() {
    jobmail.footer.open("#jobmail-user")
    jobmail.footer.icon(this)
});

jobmail.adressbook.load = function (html) {  
    $("#jobmailadressbook-element").html(html)
    $("#jobmail-footer-addressbook").show(0)
    jobmail.adressbook.sort()
}

jobmail.adressbook.sort = function () {
    $('.addressbook-element').sort(function(a, b) {
        if (a.textContent < b.textContent) {
          return -1;
        } else {
          return 1;
        }
      }).appendTo('#jobmailadressbook-element');
  }


  var mailaddressbooksearchbar = document.forms['mail-addressbook-searchbar'].querySelector('input');
  mailaddressbooksearchbar.addEventListener('keyup', function(e) {
      const term = e.target.value.toLocaleLowerCase();
      var notAvailable = document.getElementById('notAvailable');
      //   $("#titleMain").toggle($('input').val().length == 0);
      var hasResults = false;
      $(".addressbook-element").each(function() {
          if ($(this).data("mail").toString().toLowerCase().includes(term.toString()) || $(this).data("name").toString().toLowerCase().includes(term.toString()) || $(this).data("job").toString().toLowerCase().includes(term.toString()) || $(this).data("jobmail").toString().toLowerCase().includes(term.toString())) {
              $(this).show(0);
          } else {
              $(this).hide(0);
          }
      })
  });
  
//   Filter

$(document).on('click', '#jobmail-filter-icon', function() {
    mail.footer.open("#jobmail-filter")
});

$(document).on('click', '#jobmail-sent-filter-icon', function() {
    mail.footer.open("#jobmail-sent-filter")
});

$(document).on('click', '#jobmail-filter-yourmails', function() {
    var checked = $(this).hasClass("checked")
    var opentab= "home"

    sendData("jobmail:home:filter:yourmails", {
        checked: checked,
        open: opentab
    })
});


$(document).on('click', '#jobmail-sent-filter-yourmails', function() {
    var checked = $(this).hasClass("checked")
    var opentab= "sent"

    sendData("jobmail:home:filter:yourmails", {
        checked: checked,
        open: opentab
    })
});