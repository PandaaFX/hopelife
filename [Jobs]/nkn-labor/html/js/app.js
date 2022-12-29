function display(bool) {
    if (bool) {
        $("#nkn").fadeIn();
    } else {
        $("#nkn").fadeOut();
        clearAllItems()
    }
}

$(function() {
    display(false)
    $("#firstitem").droppable({
        drop: function(event, ui) {
            $.post(`https://${GetParentResourceName()}/dropped`, JSON.stringify({
                action: 'firstitem',
                name: $(ui.draggable).attr("data-name"),
                label: $(ui.draggable).attr("data-label"),
                amount: $('#inputs').val()
            }));
            loader()
        }
    });
    $("#seconditem").droppable({
        drop: function(event, ui) {
            $.post(`https://${GetParentResourceName()}/dropped`, JSON.stringify({
                action: 'seconditem',
                name: $(ui.draggable).attr("data-name"),
                label: $(ui.draggable).attr("data-label"),
                amount: $('#inputs').val() 
            }));
            loader()
        }
    });
    $("#thirditem").droppable({
        drop: function(event, ui) {
            $.post(`https://${GetParentResourceName()}/dropped`, JSON.stringify({
                action: 'thirditem',
                name: $(ui.draggable).attr("data-name"),
                label: $(ui.draggable).attr("data-label"),
                amount: $('#inputs').val() 
            }));
            loader()
        }
    });
    $("#laboratoryinv-items").droppable({
        drop: function(event, ui) {
            var type = $(ui.draggable).attr("data-action")
            if (type == 'inv') {
                $.post(`https://${GetParentResourceName()}/dropped`, JSON.stringify({ 
                    action: 'labor',
                    name: $(ui.draggable).attr("data-name"),
                    label: $(ui.draggable).attr("data-label"),
                    amount: $('#inputs').val() 
                }));
                loader()
            }
        }
    });
    $("#playerinv-items").droppable({
        drop: function(event, ui) {
            var type = $(ui.draggable).attr("data-action")
            if (type == 'labor') {
                $.post(`https://${GetParentResourceName()}/dropped`, JSON.stringify({
                    action: 'inv',
                    name: $(ui.draggable).attr("data-name"),
                    label: $(ui.draggable).attr("data-label"),
                    amount: $('#inputs').val() 
                }));
                loader()
            }
        }
    });

    display(false)
    window.addEventListener("message", function(event) {
        const item = event.data
        
        if (item.action == true) {
            display(true)
            $('#playerinv-header').html(event.data.name.toUpperCase() + " LABOR");
        };

        if (item.action == false) {
            display(false)
        };

        if (item.action == "addStash") {
            addLaborInvItem(item.name, item.label, item.count)
        };

        if (item.action == "addInv") {
            addItems(item.name, item.label, item.count)
        };

        if (item.action == "clear") {
            clearAllItems()
        };

        if (item.action == "setProcess") {
            checkProcess(item.id, item.name, item.label, item.count)
        };

        if (item.action == "setProg") {
            addLaborProgress(item.name, item.label, item.count, item.putin, item.putout, item.craftitem, item.playername, item.timedisplay, item.outtimedisplay, item.diff)
        };

        document.onkeyup = function(data) {
            if (data.which == 27) {
                $.post(`https://${GetParentResourceName()}/exit`, JSON.stringify({}));
                return
            }
        };
    })
})

function checkProcess(id, name, label, count) {    
    var thisi = $('#'+id)
    thisi.attr('data-name', name)
    thisi.attr('data-label', label)
    thisi.attr('data-count', count)
    var bild = $(thisi.find('img'))
    if (count >= 1 ) {
        $('#'+id+'-name').show();
        $('#'+id+'pic').show();
        $(thisi.find(".button")).show()
        $(thisi.find(".name")).html(label.toUpperCase()+' '+count+'x')
        bild.attr("src", 'img/items/'+name+'.png')
        bild.attr("srcset", 'img/items/'+name+'.png 1x')
    }
}

function clearAllItems() {
    $('#playerinv-items').empty()
    $('#laboratoryitems').empty()
    $('#laboratoryinv-items').empty()
}

function addItems(name, label, amount) {
    $('#playerinv-items').append(`
        <div class="playerinv-item" id="`+name+`">
        <svg class="playerinv-item-bg">
        <rect id="playerinv-item-bg" rx="8" ry="8" x="0" y="0" width="148" height="148">
        </rect>
        </svg>
        <img class="draggable" data-action="inv" data-label="`+label+`" data-name="`+name+`" id="playerinv-item-icon" src="img/items/`+name+`.png" srcset="img/items/`+name+`.png 1x">
        <div id="playerinv-item-name">
        <span>`+label+`</span>
        </div>
        <div id="playerinv-item-amount" data-class="amount">
        <span>`+amount+`x</span>
        </div>
        </div>
    `);
    $('.draggable').draggable({
        helper: 'clone',
        appendTo: 'body',
        zIndex: 99999,
        revert: 'invalid',
        cursorAt: {left: 33.5, top: 33.5},
    });
}

function addLaborProgress(name, label, count, putin, putout, craftitem, playername, timedisplay, etimedisplay, diff) {
    if (diff >= 0) {
        $('#laboratoryitems').append(`
            <div id="laboratoryitem" data-name="`+name+`" data-label="`+label+`" data-count="`+count+`" data-putin="`+putin+`" data-putout="`+putout+`" data-craftitem="`+craftitem+`" data-playername="`+playername+`">
            <svg class="laboratoryitem-bg">
            <rect id="laboratoryitem-bg" rx="8" ry="8" x="0" y="0" width="709" height="51">
            </rect>
            </svg>
            <div id="laboratoryitem-playername">
            <span>`+playername+`</span>
            </div>
            <div id="laboratoryitem-putintime">
            <span>`+timedisplay+`</span>
            </div>
            <div id="laboratoryitem-items-itemname">
            <span>`+count+`x `+label+`</span>
            </div>
            <div id="laboratoryitem-gettime">
            <span>`+etimedisplay+`</span>
            </div>
            <div id="laboratoryitem-button" onclick="getDrugs('`+name+`','`+count+`','`+craftitem+`','`+putin+`')" style="display:block;">
            <svg class="laboratoryitem-button-bg_bq">
            <linearGradient id="laboratoryitem-button-bg_bq" spreadMethod="pad" x1="0.5" x2="0.5" y1="0" y2="1">
            <stop offset="0" stop-color="var(--buttoncolor)" stop-opacity="1"></stop>
            <stop offset="1" stop-color="var(--buttonsecondcolor)" stop-opacity="1"></stop>
            </linearGradient>
            <rect id="laboratoryitem-button-bg_bq" rx="6" ry="6" x="0" y="0" width="124" height="30">
            </rect>
            </svg>
            <div id="laboratoryitem-button-span">
            <span>ABHOLEN</span>
            </div>
            </div>
            </div>
        `);
    }else {
        $('#laboratoryitems').append(`
        <div id="laboratoryitem" data-name="`+name+`" data-label="`+label+`" data-count="`+count+`" data-putin="`+putin+`" data-putout="`+putout+`" data-craftitem="`+craftitem+`" data-playername="`+playername+`">
        <svg class="laboratoryitem-bg">
        <rect id="laboratoryitem-bg" rx="8" ry="8" x="0" y="0" width="709" height="51">
        </rect>
        </svg>
        <div id="laboratoryitem-playername">
        <span>`+playername+`</span>
        </div>
        <div id="laboratoryitem-putintime">
        <span>`+timedisplay+`</span>
        </div>
        <div id="laboratoryitem-items-itemname">
        <span>`+count+`x `+label+`</span>
        </div>
        <div id="laboratoryitem-gettime">
        <span>`+etimedisplay+`</span>
        </div>
        <div id="laboratoryitem-button">
        <svg class="laboratoryitem-button-bg_bq">
        <linearGradient id="laboratoryitem-button-bg_bq" spreadMethod="pad" x1="0.5" x2="0.5" y1="0" y2="1">
        <stop offset="0" stop-color="var(--buttoncolor)" stop-opacity="1"></stop>
        <stop offset="1" stop-color="var(--buttonsecondcolor)" stop-opacity="1"></stop>
        </linearGradient>
        <rect id="laboratoryitem-button-bg_bq" rx="6" ry="6" x="0" y="0" width="124" height="30">
        </rect>
        </svg>
        <div id="laboratoryitem-button-span">
        <span>ABHOLEN</span>
        </div>
        </div>
        </div>
    `);
    }
}

function openLager() {
    $('#laboratory').hide();
    $('#laboratoryinv').show();
    $('#move').css('left', '196px');
}

function openLabor() {
    $('#laboratory').show();
    $('#laboratoryinv').hide();
    $('#move').css('left', '427px');
}

function addLaborInvItem(name, label, amount) {
    $('#laboratoryinv-items').append(`
        <div id="laboratoryinv-item" ">
        <svg class="laboratoryinv-item-bg">
        <rect id="laboratoryinv-item-bg" rx="8" ry="8" x="0" y="0" width="148" height="148">
        </rect>
        </svg>
        <img class="draggable" data-action="labor" data-name="`+name+`" data-label="`+label+`" id="laboratoryinv-item-icon" src="img/items/`+name+`.png" srcset="img/items/`+name+`.png 1x">
        <div id="laboratoryinv-item-name">
        <span>`+label+`</span>
        </div>
        <div id="laboratoryinv-item-amount">
        <span>`+amount+`x</span>
        </div>
        </div>
    `);

    $('.draggable').draggable({
        helper: 'clone',
        appendTo: 'body',
        zIndex: 99999,
        revert: 'invalid',
        cursorAt: {left: 33.5, top: 33.5},
    });
}

function progressDrugs(h) {
    var id = $(h).attr('data-action-div');
    var thisi = $('#'+id)
    $('#'+id+'-name').hide();
    $('#'+id+'pic').hide();
    $(thisi.find(".button")).hide()
    $.post(`https://${GetParentResourceName()}/setProcess`, JSON.stringify({
        action: id,
        name: thisi.attr('data-name'),
        label: thisi.attr('data-label'),
        count: thisi.attr('data-count'),
    }));
    loader()
}

function getDrugs(name, count , getitem, putin) {
    $.post(`https://${GetParentResourceName()}/check`, JSON.stringify({
        name: name,
        lastitem: getitem,
        count: count,
        putin: putin,
    }));
}

function loader() {
    $('#loader').fadeIn();
    setTimeout(() => {
        $.post(`https://${GetParentResourceName()}/refresh`, JSON.stringify({}));
        setTimeout(() => {
            $('#loader').fadeOut();
        }, 300);
    }, 500);
}