let data;
let $inventory;
let $storage;
let t;
let resourceName = "tbm_job_storage";
let isOpen = false;
const debugMode = false;
let maxStorage = 0;
let usedStorage = 0;
let handleWeaponsLikeItems;

$(document).ready(function () {
    window.addEventListener('message', function (event1) {
        data = event.data;
        if (data.action === 'getItems')
        {
            $('#spinner').fadeOut();
            $('body').fadeIn();
            renderStorage(data)
            resourceName = data.resourceName;
            isOpen = true;
            usedStorage = data.currentUsedStorage;
            maxStorage = data.maxStorage;
            handleWeaponsLikeItems = data.handleWeaponsLikeItems;
        }
    });

    $(document).keyup(function (e) {
        if (e.key === "Escape" && isOpen === true)
        {
            close()
        }
    });
    $("#closeBtn").click(function () {
        close();
    })
    if (debugMode) debug();
});

function debug()
{
    $('body').fadeIn();
    data = {
        t: {
            count: "Anzahl",
            ammo: "Ammo",
            capacity: "Kapazität",
            errorCanNotMove: "Kann nicht bewegen.",
            extendStorage: "Lager auf " + 200 + " erweitern <br> (2000$)",
            manageAccess: "Zugriff einstellen",
            backToStorage: "Zurück zum Schließfach"
        },
        storage_number: 100,
        isPlayerNotBoss: false,
        useImages: true,
        isPlayerOwner: false,
        nextStorageCapacity: 200,
        maxStorage: 100,
        currentUsedStorage: 20,
        playerItems: [
            {
                name: "apple",
                label: "Apfel",
                count: 10
            },
            {
                name: "bagel",
                label: "Bagel",
                count: 15
            }
        ],
        playerWeapons: [
            {"name": "WEAPON_SMG_MK2", "components": [], "ammo": 178, "label": "MK2 SMG"},
            {"name": "WEAPON_STUNGUN", "components": [], "ammo": 100, "label": "Tazer"},
            {"name": "WEAPON_FLASHLIGHT", "components": [], "ammo": 0, "label": "Taschenlampe"},
            {"name": "WEAPON_PISTOL", "components": ["clip_default"], "ammo": 160, "label": "Pistole"}, {"name": "WEAPON_SMG_MK2", "components": [], "ammo": 178, "label": "MK2 SMG"},
            {"name": "WEAPON_STUNGUN", "components": [], "ammo": 100, "label": "Tazer"},
            {"name": "WEAPON_FLASHLIGHT", "components": [], "ammo": 0, "label": "Taschenlampe"},
            {"name": "WEAPON_PISTOL", "components": ["clip_default"], "ammo": 160, "label": "Pistole"}, {"name": "WEAPON_SMG_MK2", "components": [], "ammo": 178, "label": "MK2 SMG"},
            {"name": "WEAPON_STUNGUN", "components": [], "ammo": 100, "label": "Tazer"},
            {"name": "WEAPON_FLASHLIGHT", "components": [], "ammo": 0, "label": "Taschenlampe"},
            {"name": "WEAPON_PISTOL", "components": ["clip_default"], "ammo": 160, "label": "Pistole"}, {"name": "WEAPON_SMG_MK2", "components": [], "ammo": 178, "label": "MK2 SMG"},
            {"name": "WEAPON_STUNGUN", "components": [], "ammo": 100, "label": "Tazer"},
            {"name": "WEAPON_FLASHLIGHT", "components": [], "ammo": 0, "label": "Taschenlampe"},
            {"name": "WEAPON_PISTOL", "components": ["clip_default"], "ammo": 160, "label": "Pistole"}, {"name": "WEAPON_SMG_MK2", "components": [], "ammo": 178, "label": "MK2 SMG"},
            {"name": "WEAPON_STUNGUN", "components": [], "ammo": 100, "label": "Tazer"},
            {"name": "WEAPON_FLASHLIGHT", "components": [], "ammo": 0, "label": "Taschenlampe"},
            {"name": "WEAPON_PISTOL", "components": ["clip_default"], "ammo": 160, "label": "Pistole"}, {"name": "WEAPON_SMG_MK2", "components": [], "ammo": 178, "label": "MK2 SMG"},
            {"name": "WEAPON_STUNGUN", "components": [], "ammo": 100, "label": "Tazer"},
            {"name": "WEAPON_FLASHLIGHT", "components": [], "ammo": 0, "label": "Taschenlampe"},
            {"name": "WEAPON_PISTOL", "components": ["clip_default"], "ammo": 160, "label": "Pistole"}, {"name": "WEAPON_SMG_MK2", "components": [], "ammo": 178, "label": "MK2 SMG"},
            {"name": "WEAPON_STUNGUN", "components": [], "ammo": 100, "label": "Tazer"},
            {"name": "WEAPON_FLASHLIGHT", "components": [], "ammo": 0, "label": "Taschenlampe"},
            {"name": "WEAPON_PISTOL", "components": ["clip_default"], "ammo": 160, "label": "Pistole"}, {"name": "WEAPON_SMG_MK2", "components": [], "ammo": 178, "label": "MK2 SMG"},
            {"name": "WEAPON_STUNGUN", "components": [], "ammo": 100, "label": "Tazer"},
            {"name": "WEAPON_FLASHLIGHT", "components": [], "ammo": 0, "label": "Taschenlampe"},
            {"name": "WEAPON_PISTOL", "components": ["clip_default"], "ammo": 160, "label": "Pistole"}, {"name": "WEAPON_SMG_MK2", "components": [], "ammo": 178, "label": "MK2 SMG"},
            {"name": "WEAPON_STUNGUN", "components": [], "ammo": 100, "label": "Tazer"},
            {"name": "WEAPON_FLASHLIGHT", "components": [], "ammo": 0, "label": "Taschenlampe"},
            {"name": "WEAPON_PISTOL", "components": ["clip_default"], "ammo": 160, "label": "Pistole"},
        ],
        storageItems: [
            {
                name: "beer",
                label: "Bier",
                count: 10
            },
            {
                name: "bagel",
                label: "Bagel",
                count: 15
            }
        ],
        storageWeapons: [
            {"name": "WEAPON_NIGHTSTICK", "components": [], "ammo": 0, "label": "Schlagstock"},
            {"name": "WEAPON_PISTOL", "components": ["clip_default"], "ammo": 160, "label": "Pistole"},
            {"name": "WEAPON_PISTOL_MK2", "components": [], "ammo": 160, "label": "MK2 Pistole"},
        ],
    }
    // renderStorage(data)

    const jobgrades = [
        {
            label: "test",
            canOpen: false,
            canPut: true,
            canTake: false,
        },{
            label: "test",
            canOpen: false,
            canPut: true,
            canTake: false,
        },{
            label: "test",
            canOpen: false,
            canPut: true,
            canTake: false,
        },{
            label: "test",
            canOpen: false,
            canPut: true,
            canTake: false,
        },{
            label: "test",
            canOpen: false,
            canPut: true,
            canTake: false,
        },{
            label: "test",
            canOpen: false,
            canPut: true,
            canTake: false,
        },{
            label: "test",
            canOpen: false,
            canPut: true,
            canTake: false,
        },{
            label: "test",
            canOpen: false,
            canPut: true,
            canTake: false,
        },{
            label: "test",
            canOpen: false,
            canPut: true,
            canTake: false,
        },{
            label: "test",
            canOpen: false,
            canPut: true,
            canTake: false,
        },{
            label: "test",
            canOpen: false,
            canPut: true,
            canTake: false,
        },{
            label: "test",
            canOpen: false,
            canPut: true,
            canTake: false,
        }
    ];
    data.jobGrades = jobgrades;

    renderManageAccess(data)
}

function close()
{
    $.post('http://' + data.resourceName + '/escape', JSON.stringify({}));
    $('body').fadeOut();
    isOpen = false;
}

async function renderStorage(data)
{
    let response = await fetch('storage.html');
    let template = await response.text();
    t = data.t;

    document.getElementById('view').innerHTML = Mustache.render(template, data);
    storageIsRendered();
    resizeLabels(data);
    $('#spinner').fadeOut();
    $("#closeBtn").click(function () {
        close();
    })
}

async function renderManageAccess(data)
{
    let response = await fetch('manageAccess.html');
    let template = await response.text();

    document.getElementById('view').innerHTML = Mustache.render(template, data);
    $('#spinner').fadeOut();

    $("#backToStorage").on("click", async function (event) {
        sendPost('openStorage', {});
    });
}

function resizeLabels(data)
{
    data.playerItems.forEach(item => resizeToFit(item.name, '_inventory'));
    data.playerWeapons.forEach(item => resizeToFit(item.name, '_inventory'));
    data.storageItems.forEach(item => resizeToFit(item.name, '_storage'));
    data.storageWeapons.forEach(item => resizeToFit(item.name, '_storage'));
}

function storageIsRendered()
{
    // There's the inventory and the storage
    $inventory = $("#inventory");
    $storage = $("#storage");

    registerDraggable($inventory);
    registerDraggable($storage);

    registerDroppable($storage, 'inventory', moveToStorage);
    registerDroppable($inventory, 'storage', moveToInventory);

    registerOnClickListener();
}

function registerOnClickListener()
{
    $("#loadManageAccess").on("click", async function (event) {
        let response;
        if (debugMode) {
            response = {
                access: [
                    {job_grade_id: 1, type:"canPut"},
                    {job_grade_id: 1, type:"canOpen"}
                ],
                jobGrades: [
                    {
                        id: 1,
                        grade: 1,
                        label: "label 1. rang"
                    },
                    {
                        id: 2,
                        grade: 0,
                        label: "2. Rang"
                    }
                ]
            };
        } else {
            response = await sendPost('loadManageAccess', {});
        }
        const jobGrades = [];
        response.jobGrades.forEach((item) => {
            item.canPut = false
            item.canTake = false
            item.canOpen = false
            item.canUpgrade = false
            response.access.forEach((accessItem) => {
                if (accessItem.job_grade_id === item.id)
                {
                    item[accessItem.type] = true;
                }
            })
            jobGrades.push(item);
        })

        renderManageAccess({jobGrades, t});
    });

    $("#extendStorage").on("click", async function (event) {
        let response;
        if (debugMode)
        {
            response = {
                status: 201,
                extendStorage: "Lager auf 3000 erweitern <br> (33333$)",
                maxStorage: 300
            }
        }
        else
        {
            response = await sendPost('extendStorage', {});
        }

        if (response.status === 200)
        {
            $('#maxStorage').text(response.maxStorage);
            $('#extendStorage').html(response.extendStorage)
            maxStorage = response.maxStorage;
        }
        else if (response.status === 201)
        {
            $('#maxStorage').text(response.maxStorage);
            maxStorage = response.maxStorage;
            $('#extendStorage').fadeOut();
        }
    })
}

// Image deletion function
function moveToStorage($item)
{
    move($storage, $item, 'storage');
}

function moveToInventory($item)
{
    move($inventory, $item, 'inventory');
}

async function move(target, item, targetName)
{
    const countHas = item.find('.amount').text() * 1;
    const name = item.find('.name').val();
    let countToMove = getItemsCountToMove(name, countHas, targetName);

    if (countToMove <= 0)
    {
        return;
    }

    const isWeapon = item.find('.isWeapon').val() === "1";
    const ammo = item.find('.ammo').val();
    const classNameOfTargetItem = 'item_' + name + '_' + targetName;
    const targetItem = target.find('#' + classNameOfTargetItem);

    if (isWeapon && handleWeaponsLikeItems)
    {
        countToMove = 1
    }

    if (shouldMoveAllItemsAndTargetHasNotSuchItems(countToMove, countHas, targetItem)
        || shouldMoveWeapon(isWeapon, targetName, targetItem))
    {
        await makeMoveRequestAndHandleAnswer(targetName, name, isWeapon, countToMove, ammo, () => {
            moveItem(target, item, classNameOfTargetItem)
        });
    }
    else if (shouldMoveLastItems(countToMove, countHas, isWeapon, targetItem))
    {
        await makeMoveRequestAndHandleAnswer(targetName, name, isWeapon, countToMove, ammo, () => {
            mergeItem(item, targetItem, countToMove);
        });
    }
    else if (!isWeapon || handleWeaponsLikeItems)
    {
        await makeMoveRequestAndHandleAnswer(targetName, name, isWeapon, countToMove, ammo, () => {
            splitItem(target, item, targetItem, countHas, countToMove, classNameOfTargetItem);
        });
    }
}

function registerDraggable(field)
{
    $("div.itemCard", field).draggable({
        cancel: "a.ui-icon", // clicking an icon won't initiate dragging
        revert: "invalid", // when not dropped, the item will revert back to its initial position
        containment: "document",
        helper: "clone",
        cursor: "move"
    });
}

function registerDroppable(field, sourceField, moveFunction)
{
    field.droppable({
        accept: "#" + sourceField + " div",
        classes: {
            "ui-droppable-active": "ui-state-highlight"
        },
        drop: function (event, ui) {
            moveFunction(ui.draggable);
        }
    });
}


function resizeToFit(divName)
{
    let fontsize = $('div#' + divName + '_label span').css('font-size');
    $('div#' + divName + '_label span').css('font-size', parseFloat(fontsize) - 1);

    if ($('div#' + divName + '_label span').width() >= $('div#' + divName + '_label').width() - 15)
    {
        resizeToFit(divName);
    }
}

async function makeMoveRequestAndHandleAnswer(target, name, isWeapon, countToMove, ammo, successCallback)
{
    if (debugMode)
    {
        successCallback();
        return;
    }

    const response = await makeMoveRequest(target, name, isWeapon, countToMove, ammo);

    if (response.state === 200)
    {
        $('#currentUsedStorage').text(response.usedStorage);
        usedStorage = response.usedStorage;
        successCallback();
    }
}

async function makeMoveRequest(target, name, isWeapon, countToMove, ammo)
{
    return await sendPost('moveItem',
        {
            target,
            name,
            isWeapon,
            countToMove,
            ammo
        })
}

async function sendPost(url, body)
{
    $('#spinner').fadeIn();
    body = JSON.stringify(body);

    let response = await fetch('http://' + resourceName + '/' + url, {
        method: 'POST', // *GET, POST, PUT, DELETE, etc.
        mode: 'cors', // no-cors, *cors, same-origin
        cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
        credentials: 'same-origin', // include, *same-origin, omit
        headers: {
            'Content-Type': 'application/json'
        },
        body: body
    });
    $('#spinner').fadeOut();

    return JSON.parse(await response.text());
}


function moveItem(target, item, classNameOfTargetItem)
{
    item.fadeOut(function () {
        item.attr('id', classNameOfTargetItem);
        item.appendTo(target);
        item.fadeIn();
    });
}

function mergeItem(item, targetItem, countToMove)
{
    item.fadeOut(function () {
        item.detach();

        const hasItemCount = targetItem.find('.amount').text() * 1;

        targetItem
            .find('.amount')
            .text(countToMove + hasItemCount)
    });
}

function splitItem(target, item, targetItem, countHas, countToMove, classNameOfTargetItem)
{
    item.find('.amount').text(countHas - countToMove);

    if (targetItem.length === 0)
    {
        targetItem = item.clone();
        targetItem.appendTo(target);
        targetItem.attr('id', classNameOfTargetItem);

        targetItem.fadeIn();
        $("#" + classNameOfTargetItem).draggable({
            cancel: "a.ui-icon", // clicking an icon won't initiate dragging
            revert: "invalid", // when not dropped, the item will revert back to its initial position
            containment: "document",
            helper: "clone",
            cursor: "move"
        });
    }
    else
    {
        countToMove = targetItem.find('.amount').text() * 1 + countToMove
    }
    targetItem.find('.amount').text(countToMove);
}

function getItemsCountToMove(name, countHas, targetName)
{
    let countToMove = $("#amount").val() * 1;
    if (countHas < countToMove)
    {
        countToMove = countHas;
    }

    if (name !== 'black_money' && name !== 'cash' && targetName === 'storage' && countToMove > maxStorage - usedStorage)
    {
        countToMove = maxStorage - usedStorage;
    }

    return countToMove;
}

function shouldMoveAllItemsAndTargetHasNotSuchItems(countToMove, countHas, targetItem)
{
    return countToMove === countHas && targetItem.length === 0
}

function shouldMoveWeapon(isWeapon, targetName, targetItem)
{
    return isWeapon === true && targetName === "storage" && targetItem.length === 1 && !handleWeaponsLikeItems
}

function shouldMoveLastItems(countToMove, countHas, isWeapon, targetItem)
{
    return countToMove === countHas && targetItem.length === 1 && (isWeapon === false || (isWeapon === true && handleWeaponsLikeItems === true))
}
async function toggleAccessOpen(id)
{
    toggleAccess(id, "canOpen")
}

async function toggleAccessPut(id)
{
    toggleAccess(id, "canPut")
}

async function toggleAccessTake(id)
{
    toggleAccess(id, "canTake")
}

async function toggleAccessCanUpgrade(id)
{
    toggleAccess(id, "canUpgrade")
}

async function toggleAccess(id, type) {
    let response;

    if (debugMode)
    {
        response = {
            status: 200,
            statusToggle: false
        }
    }
    else
    {
        response = await sendPost('toggleAccessState', {id, type});
    }

    $('#accessToggle' + id).prop('checked', response.state);
}
