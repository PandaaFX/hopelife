function close() {
    $.post('https://rcore_tattoos/close', JSON.stringify({}));
}

function moveCameraToBodyPart(part) {
    $.post('https://rcore_tattoos/moveCameraToBodyPart', JSON.stringify({
        'part': part
    }));
}

function previewTattoo(currentCategory, tattooName, tattooIdentifier, onlySaveData) {
    $.post('https://rcore_tattoos/previewTattoo', JSON.stringify({
        'currentCategory': currentCategory,
        'tattooName': tattooName,
        'tattooIdentifier': tattooIdentifier,
        'onlySaveData': onlySaveData ? onlySaveData : false,
        'opacity': app.opacity.level,
    }));
}

function resetTattoos() {
    $.post('https://rcore_tattoos/resetPedDecorations', JSON.stringify({}));
}

function postBuyTattoo() {
    $.post('https://rcore_tattoos/buyTattoo', JSON.stringify({
        'useHenna': app.useHenna,
    }));
}

function postRemoveTattoo(name, hash, tattooIdentifier) {
    $.post('https://rcore_tattoos/removeTattoo', JSON.stringify({
        'name': name,
        'hash': hash,
        'identifier': tattooIdentifier,
    }));
}

function postCamSliderValue(value) {
    $.post('https://rcore_tattoos/handleCamSlider', JSON.stringify({
        'value': value
    }));
}

let tattooList;
let purchasePending = false;
let removalPending = false;
let isCamSliderInitialized = false;
let notifBox;

let app = new Vue({
    el: '#app',
    data: {
        visible: false,
        texts: {},
        partsMenuVisible: false,
        tattoosMenuVisible: false,
        tattoos: {},
        parts: {},
        currentCategory: '',
        currentTattooIndex: 0,
        opacity: {
            level: 1,
            price: 0
        },
        useHenna: false,
        hennaPrice: 0,
        onlyPreview: false,
        onlySpecificPart: false,
    },
    methods: {
        initTattooList: function () {
            tattooList = $(this.$refs.tattooList);
        },
        partBtnClick: function (category) {
            app.currentCategory = category;
            app.partsMenuVisible = false;
            app.tattoosMenuVisible = true;
            app.currentTattooIndex = 0;

            setTimeout(() => {
                $('.js-tats-menu').show(300);

                const camSlider = $('.js-cam-slider');
                if (camSlider) {
                    camSlider.val(0);
                    if (!isCamSliderInitialized) {
                        isCamSliderInitialized = true;

                        camSlider.on('input', () => {
                            postCamSliderValue(camSlider.val());
                        });
                    }
                }

                app.initTattooList();
                tattooList.addClass('focused');
                moveCameraToBodyPart(category);
                app.handlePreview();
            }, 0);
        },
        menuGoBackClick: function () {
            if(!purchasePending && !removalPending) {
                app.partsMenuVisible = true;
                app.tattoosMenuVisible = false;
                $('.js-tats-menu').hide(300);

                tattooList.removeClass('focused');
                moveCameraToBodyPart();
                resetTattoos();
            }
        },
        setCurrentTattooIndex: function (e) {
            app.currentTattooIndex = $(e.currentTarget).attr('data-index');
        },
        handlePreview() {
            const currentTat = app.tattoos[app.currentCategory][app.currentTattooIndex];

            if (!currentTat.Owned) {
                previewTattoo(
                    app.currentCategory,
                    currentTat.Name,
                    currentTat.Identifier,
                );
                return true;
            }

            return false;
        },
        buyOrRemoveWithButton() {
            if (tattooList && tattooList.hasClass('focused')) {
                buyTattoo();
            }
        },
        getTattooPriceLabel(price) {
            let label;
            if (price) {
                if (price != '-') {
                    const hennaPrice = app.useHenna ? app.hennaPrice : 0
                    const opacityPrice = (app.opacity.level - 1) * app.opacity.price;
                    label = `${app.texts.currency}${(price + hennaPrice + opacityPrice)}`
                } else {
                    label = '✔'
                }
            } else {
                label = app.texts.free
            }

            return label;
        }
    }
});

$(function () {
    window.addEventListener("message", function (event) {
        const item = event.data;
        if (item.type == "ui") {
            app.visible = item.visible;
            app.partsMenuVisible = item.visible;
        }
        if (item.texts && item.texts.length != 0) {
            app.texts = JSON.parse(item.texts);
        }
        if (item.tattoos && item.tattoos.length != 0) {
            app.tattoos = JSON.parse(item.tattoos);
        }
        if (item.parts && item.parts.length != 0) {
            app.parts = JSON.parse(item.parts);
        }
        if (typeof item.tattooBought !== "undefined" && item.tattooBought !== null) {
            if (item.tattooBought) {
                purchaseSuccessful();
            } else {
                purchasePending = false;
            }
        }
        if (item.removedTattooPrice !== null && Number.isFinite(item.removedTattooPrice)) {
            if (item.removedTattooPrice >= 0) {
                removalSuccessful(item.removedTattooPrice);
            }
            removalPending = false;
        }
        // Notifications
        if (item.type == "notification") {
            addNotification(item.title, item.message, item.style);
        }
        if (typeof item.opacity !== "undefined" && item.opacity !== null) {
            app.opacity.level = Number.isFinite(item.opacity.level) ? item.opacity.level : 1;
            app.opacity.price = Number.isFinite(item.opacity.price) ? item.opacity.price : 0;
        }
        if (item.hennaPrice !== null && Number.isFinite(item.hennaPrice)) {
            app.hennaPrice = item.hennaPrice;
        }

        app.onlyPreview = !!item.onlyPreview;

        if (typeof item.openSpecificPart !== 'undefined' && item.openSpecificPart !== false ) {
            if (app.visible && Object.keys(app.tattoos).length) {
                app.onlySpecificPart = true;
                app.partBtnClick(item.openSpecificPart);
            }
        } else if (item.openSpecificPart === false ){
            app.onlySpecificPart = false;
        }
    });

    const closeKeys = [27, 8];

    $(document.body).bind("keyup", function (key) {
        if (closeKeys.includes(key.which)) {
            $('.js-tats-menu').hide(300);
            isCamSliderInitialized = false;

            if (notifBox) notifBox.innerHTML = "";
            notifBox = false;

            close();
        }

        if (tattooList) {
            if (tattooList.hasClass('focused') && key.which == 13) {
                key.preventDefault();
                buyTattoo();
            }
        }
    });

    $(document.body).bind("keydown", function (key) {
        if (tattooList) {
            if (tattooList.hasClass('focused') && key.which == 40) {
                key.preventDefault();

                handleSelectingTattoo('next');
            }

            if (tattooList.hasClass('focused') && key.which == 38) {
                key.preventDefault();

                handleSelectingTattoo('prev');
            }
        }
    });

    $(document.body).on("click", '.js-tattoo-item', function (e) {
        handleSelectingTattoo('click', $(e.currentTarget))
    });
});

function handleSelectingTattoo(type, tattoo) {
    if (!purchasePending && !removalPending) {
        const selectedTattoo = tattooList.find('.tat-selected');
        let handledTattoo;

        switch (type) {
            case 'click':
                handledTattoo = tattoo;
                break;
            case 'prev':
                handledTattoo = selectedTattoo.prev();
                break;
            case 'next':
                handledTattoo = selectedTattoo.next();
                break;
        }

        if (handledTattoo.is('li')) {
            selectedTattoo.removeClass('tat-selected');
            handledTattoo.addClass('tat-selected');
            handledTattoo.get(0).scrollIntoViewIfNeeded();
            app.currentTattooIndex = parseInt(handledTattoo.attr('data-index'));

            if (!app.handlePreview()) {
                resetTattoos();
            }

        }
    }
}

let lastBoughtTattoo;
let buyTattooDebounce = false;

function buyTattoo() {
    if (!buyTattooDebounce && app.tattoosMenuVisible && !purchasePending && !app.onlyPreview) {
        buyTattooDebounce = true;
        setTimeout(() => {buyTattooDebounce = false}, 200)

        const currentTat = app.tattoos[app.currentCategory][app.currentTattooIndex];
        if (currentTat.Owned == false) {
            purchasePending = true;
            lastBoughtTattoo = tattooList.find('.tat-selected');
            postBuyTattoo();
        } else {
            removalPending = true;
            postRemoveTattoo(
                currentTat.Name,
                currentTat.Name,
                currentTat.Identifier,
            );
            previewTattoo(
                app.currentCategory,
                currentTat.Name,
                currentTat.Identifier,
                true
            );
        }
    }
}

function purchaseSuccessful() {
    if (lastBoughtTattoo) {
        lastBoughtTattoo.find('.js-tattoo-price').text('✔');
        app.tattoos[app.currentCategory][app.currentTattooIndex].Owned = true;
        purchasePending = false;
    }
}

function removalSuccessful(price) {
    price = price === 0 ? app.texts.free : app.texts.currency + price;
    tattooList.find('.tat-selected').find('.js-tattoo-price').text(price);
    app.tattoos[app.currentCategory][app.currentTattooIndex].Owned = false;
}

let notifId = 0
function addNotification(title, msg, style) {
    if (!notifBox || notifBox.length <= 0) notifBox = $('.js-notif');

    const notif = 
        `<div class="notif-box__notif ` +
            `notif-box__notif--` +
                style +
            `" id="` + notifId + `">` + 
            `<span class="notif-box__title">` +
                title +
            `</span>` +
            `<span class="notif-box__msg">` +
                msg +
            `</span>` +
        `</div>`;
    notifBox.prepend(notif);
    
    const thisNotifId = notifId++;

    setTimeout(() => {
        if(notifBox) {
            notifBox.find('#' + thisNotifId).remove();
        }
    }, 7000);
}
