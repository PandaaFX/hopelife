window.addEventListener('message', function(event) {
    currentTime = event.data.time
    if(event.data.locales) {
        locales = event.data.locales
    }
    switch(event.data.type){
        case 'loadCuffs':
            loadCuffs(event.data.data);
            break;
        case 'openNUI':
            openNUI();
            break;
        case 'closeNUI':
            closeNUI();
            break;
        case 'b64Mugshot':
            const resourceName = window.GetParentResourceName();
            let tempUrl = `https://nui-img/${event.data.txd}/${event.data.txd}?t=${String(Math.round(new Date().getTime() / 1000))}`;
            const img = new Image();
            img.crossOrigin = 'Anonymous';
            img.onload = () => {
                const canvas = document.createElement('canvas');
                const ctx = canvas.getContext('2d');
                canvas.height = img.naturalHeight;
                canvas.width = img.naturalWidth;
                ctx.drawImage(img, 0, 0);
                $.post(`https://${resourceName}/returnB64Mugshot`, JSON.stringify({ b64mugshot: canvas.toDataURL(), id: event.data.id }));
            };
            img.src = tempUrl;
            break;
    }
})

function loadCuffs(data){
    $(".main").empty()
    if(data.length < 1){
        let html = "";
        html += `
        <div class="empty-container">
            <div class="empty-svg">
                <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="frown"
                    class="svg-inline--fa fa-frown fa-w-16 fa-fw fa-3x " role="img" xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 496 512" style="color: white; margin-bottom: 32px;">
                    <path fill="currentColor"
                    d="M248 8C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm80 168c17.7 0 32 14.3 32 32s-14.3 32-32 32-32-14.3-32-32 14.3-32 32-32zm-160 0c17.7 0 32 14.3 32 32s-14.3 32-32 32-32-14.3-32-32 14.3-32 32-32zm170.2 218.2C315.8 367.4 282.9 352 248 352s-67.8 15.4-90.2 42.2c-13.5 16.3-38.1-4.2-24.6-20.5C161.7 339.6 203.6 320 248 320s86.3 19.6 114.7 53.8c13.6 16.2-11 36.7-24.5 20.4z">
                    </path>
                </svg>
            </div>
            <div class="empty-title">Nothing Here!</div>
        </div>
        `;
        $(".main").append(html)
    }
    $.each(data, function(index, value){
        if(value == null || value == '') return;
        let html = "";
        let remainingTime = currentTime - Number(value.cufftime) 
        let days = Math.floor(remainingTime/86400)
        let remaining = remainingTime % 86400
        let hours = Math.floor(remaining/3600)
        remaining = remaining % 3600
        let minutes = Math.floor(remaining/60)
        remaining = remaining % 60
        answer = ''
        if(days > 0) {
            answer = answer + String(days) + ' ' + locales.days + ' '
        }
        if(hours > 0) {
            answer = answer + String(hours) + ' ' + locales.hours + ' ' 
        }
        if (minutes > 0) {
            answer = answer + String(minutes) + ' ' + locales.minutes + '' 
        }
        if (answer == '') {
            answer = locales.coupleofsecondsago
        }
        html += `
        <div class="card">
            <div class="player-photo" style="background-image: url('${value.photo}')"></div>
            <div class="card-title">${value.name}</div>
            <div class="card-subtitle-first">${locales.gpsmode}: ${value.gps ? '✔️' : '❌'}</div>
            <div class="card-subtitle-second">${locales.cufftime}: ${answer}</div>
            <div class="card-buttons">
                <button class="buttons" onclick="shock('${value.src}')" id="shock">${locales.shock}</button>
                <button class="buttons" onclick="gps('${value.src}')" id="gps">${locales.gps}</button>
                <button class="buttons" onclick="unlock('${value.src}')" id="unlock">${locales.unlock}</button>
            </div>
        </div>
        `;
        $(".main").append(html);
    })
}

function shock(src){
    $.post(`https://${GetParentResourceName()}/shock`, JSON.stringify({src: src}));
}
function gps(src){
    $.post(`https://${GetParentResourceName()}/gps`, JSON.stringify({src: src}));
}
function unlock(src){
    $.post(`https://${GetParentResourceName()}/unlock`, JSON.stringify({src: src}));
}

function openNUI(){
    $('.main').css('display', 'block');
    $( ".main" ).animate({
        top: "50%"
      }, 1000, function() {
    });
    setTimeout(function(){
        $( ".keybind" ).animate({
            "margin-top": "1%"
          }, 1000, function() {
        });
    }, 500)
    $('.keybind').css('display', 'block');
}

function closeNUI(){
    $( ".keybind" ).animate({
        "margin-top": "-14%"
      }, 1000, function() {
    });
    setTimeout(function(){
        $( ".main" ).animate({
            top: "-50%"
          }, 1000, function() {
              $('.main').css('display', 'none');
              $('.keybind').css('display', 'none');
        });
    }, 500)
}

document.onkeydown = function(data){
    if (data.which == 27){
            setTimeout(function(){
                $('.main').fadeOut();
                closeNUI()
                $.post(`https://${GetParentResourceName()}/close`);
            }, 250)
    }
}