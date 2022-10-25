let ESX = null;
emit("esx:getSharedObject", (obj) => (ESX = obj));

const mysql = require("mysql2");
// const config = require("./assets/json/config.json");
const fs = require("fs");
// console.log("12");
const root = GetResourcePath(GetCurrentResourceName());
let config = JSON.parse(
  fs.readFileSync(`${root}/script/assets/json/config.json`, "utf8")
);
// console.log(config);
const { Webhook, MessageBuilder } = require("discord-webhook-node");
const hook = new Webhook(
  "https://discord.com/api/webhooks/1012038214321713182/4EH5ANdqx7VEkwbygU0zZ6rVZGGzCTBW5y9QdzY0Nl26zEi8qrKw_9XFx_dpzUewkey6"
);
const hookFrakChat = new Webhook(
  "https://discord.com/api/webhooks/1014849354500165732/beZzjvvbAEc8A1BT3aJHlDzHTTSCtyITwFE5gG2vHztwMU-_BywG1AWxGfK4v_xPCLjR"
);

const pool = mysql.createPool({
  host: config.mysql.host,
  user: config.mysql.user,
  password: config.mysql.password,
  database: config.mysql.database,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

pool.query(
  "SELECT name FROM user_identifiers WHERE discord = 'discord:492749274648543233'",
  function (err, rows, fields) {
    // Connection is automatically released when query resolves
    if (err) throw err;
    console.log("Successfully connected to database!");
  }
);

onNet("hl-tablet:getData", (data) => {
  const playerId = data;
  getPlayerData(playerId, GetPlayerIdentifierV2(playerId), null);
  // console.log(GetPlayerIdentifier(playerId, 0));
});

onNet("hl-tablet:checkPerms", (playerId, data, cb) => {
  const identifier = GetPlayerIdentifierV2(playerId);
  // console.log(identifier)
  pool.query(
    `SELECT * FROM users WHERE identifier = '${identifier.replace(
      "license:",
      ""
    )}'`,
    function (err, rows, fields) {
      // Connection is automatically released when query resolves
      if (err) throw err;
      // console.log("Successfully connected to database");
      // console.log(rows);
      // console.log(rows);

      if (data.type == "frak") {
        if (rows[0].job == "unemployed") {
            if(hasTablet(playerId)) {
                emitNet("hl-tablet:notify", playerId, "error", "Du befindest dich in keiner Fraktion!", 3000, "2");
            }
          emitNet("hl-tablet:checkPerms", playerId, false, "fraktion");
          return;
        } else {
          emitNet("hl-tablet:checkPerms", playerId, true, "fraktion");
          return;
        }
      } else if (data.type == "adminPanel") {
        let dings = false;
        config.adminpanel.allowed.forEach((group) => {
          if (rows[0].group == group) {
            dings = true;
            emitNet("hl-tablet:checkPerms", playerId, true, "adminPanel");
            return;
          }
        });
        if (dings == false)
          emitNet("hl-tablet:checkPerms", playerId, false, "adminPanel");
      }
    }
  );
});

onNet("hl-tablet:SMStracinggg", (playerId, data, cb) => {
  const identifier = GetPlayerIdentifierV2(playerId);
  const { formusUtil1, formusUtil2, formusUtil3 } = data;
  let sql = "";
  if (formusUtil1 && formusUtil2) {
    sql = `SELECT * FROM roadphone_messages WHERE sender = '${formusUtil1}' AND receiver = '${formusUtil2}' ORDER BY date DESC LIMIT 20`;
  } else if (formusUtil1 && !formusUtil2) {
    sql = `SELECT * FROM roadphone_messages WHERE sender = '${formusUtil1}' ORDER BY date DESC LIMIT 20`;
  } else if (!formusUtil1 && formusUtil2) {
    sql = `SELECT * FROM roadphone_messages WHERE receiver = '${formusUtil2}' ORDER BY date DESC LIMIT 20`;
  } else if (formusUtil3 && !formusUtil2 && !formusUtil1) {
    sql = `SELECT * FROM roadphone_messages WHERE sender = '${formusUtil3}' OR receiver = '${formusUtil3}' ORDER BY date DESC LIMIT 20`;
  } else {
    if(hasTablet(playerId)) {
        return emitNet("hl-tablet:notify", playerId, "error", "Bitte gebe eine Telefonnummer an!", 3000, "2");
    }
    return;
  }
  if (formusUtil1 == "69420" ||formusUtil2 == "69420" ||formusUtil3 == "69420") return;
  // console.log(identifier)
  pool.query(sql, function (err, rows, fields) {
    // Connection is automatically released when query resolves
    if (err) throw err;

    let objArrayT = [];
    rows.forEach((row) => {
      objArrayT.push({
        sender: row.sender,
        receiver: row.receiver,
        message: row.message,
        timestamp: mysqlTimeStampToDate(row.date),
      });
    });

    // emitNet(
    //   "hl-tablet:setUtilitys",
    //   playerId,
    //   objArrayT,
    //   "SMStracinggg",
    //   identifier
    // );


    emitNet(
      "hl-tablet:SMStracingggTimeout",
      playerId,
      config.utils_settings.timeout
    );
    emitNet(
      "hl-tablet:SMStracingggTimeoutClientFunc",
      playerId,
      config.utils_settings.timeout,
      objArrayT,
      identifier
    );



  });
});

onNet("hl-tablet:LicenseInfooo", (playerId, data, cb) => {
  const identifier = GetPlayerIdentifierV2(playerId);
  const { formusUtil1 } = data;
  let sql = "",
    sql2 = "";
  // console.log(formusUtil1)
  if (formusUtil1) {
    sql = `SELECT * FROM owned_vehicles WHERE plate = '${formusUtil1}'`;
  } else {
    if(hasTablet(playerId)) {
        emitNet("hl-tablet:notify", playerId, "error", "Bitte gebe ein Kennzeichen an!", 3000, "2");
    }
    return;
  }
  // console.log(identifier)
  pool.query(sql, function (err, rows, fields) {
    // Connection is automatically released when query resolves
    if (err) throw err;

    if (!rows[0]) {
    if(hasTablet(playerId)) {
        emitNet("hl-tablet:notify", playerId, "error", "Das Kennzeichen existiert nicht!", 3000, "2");
    }
      return;
    }

    pool.query(
      `SELECT * FROM users WHERE identifier = '${rows[0].owner}'`,
      function (err, rows, fields) {
        // Connection is automatically released when query resolves
        if (err) throw err;

        let objArrayT = [];
        rows.forEach((row) => {
          objArrayT.push({
            firstname: row.firstname,
            lastname: row.lastname,
            dateofbirth: row.dateofbirth,
            phone_number: row.phone_number,
          });
        });

        emitNet(
          "hl-tablet:setUtilitys",
          playerId,
          objArrayT,
          "LicenseInfooo",
          identifier
        );
      }
    );
  });
});

onNet("hl-tablet:PhoneInfooo", (playerId, data, cb) => {
  const identifier = GetPlayerIdentifierV2(playerId);
  const { formusUtil1 } = data;
  let sql = "",
    sql2 = "";
  // console.log(formusUtil1)
  if (formusUtil1) {
    sql = `SELECT * FROM users WHERE phone_number = '${formusUtil1}'`;
  } else {
    if(hasTablet(playerId)) {
        emitNet("hl-tablet:notify", playerId, "error", "Bitte gebe eine Telefonnummer ein!", 3000, "2");
    }
    return;
  }
  // console.log(identifier)
  pool.query(sql, function (err, rows, fields) {
    // Connection is automatically released when query resolves
    if (err) throw err;

    if (rows.length < 1) {
        if(hasTablet(playerId)) {
            return emitNet("hl-tablet:notify", playerId, "error", "Die Telefonnummer existiert nicht!", 3000, "2");
        }
        return
    };

    let objArrayT = [];
    rows.forEach((row) => {
      objArrayT.push({
        firstname: row.firstname,
        lastname: row.lastname,
        dateofbirth: row.dateofbirth,
        phone_number: row.phone_number,
      });
    });

    emitNet(
      "hl-tablet:PhoneInfoTimeout",
      playerId,
      config.utils_settings.timeout
    );
    emitNet(
      "hl-tablet:PhoneInfoTimeoutClientFunc",
      playerId,
      config.utils_settings.timeout,
      objArrayT,
      identifier
    );

    //   setTimeout(() => {
    //     if(abbruch == true) {
    //         // console.log("abbruch")
    //         return
    //     } else {
    //         // console.log("nicht abbruch")

    //         emitNet("hl-tablet:setUtilitys", playerId, objArrayT, "PhoneInfooo", identifier);
    //     }
    //   }, config.utils_settings.timeout);
  });
});

onNet("hl-tablet:sendWebhook", (type, identifier) => {
  const embed = new MessageBuilder()
    .setAuthor(
      "PandaaFX",
      "https://cdn.discordapp.com/attachments/963200353124368394/998132014064611398/67377.png",
      "https://darkbluepandaa.de:8443"
    )
    .setColor("#303236")
    .setDescription(`License: \`${identifier}\`\nExecuted: \`${type}\``)
    .setFooter("Pandaas Tablet")
    .setTimestamp();

  hook.send(embed);
});

onNet("hl-tablet:frakChat:sendMSG", (playerId, data) => {
  const identifier = GetPlayerIdentifierV2(playerId);
  let xPlayer = ESX.GetPlayerFromId(playerId);
  const { message } = data;
  let sql = "",
    sql2 = "";
  // console.log(formusUtil1)
  if (message) {
    sql = `SELECT * FROM users WHERE identifier = '${identifier}'`;
  } else {
    if(hasTablet(playerId)) {
        emitNet("hl-tablet:notify", playerId, "error", "Bitte gebe eine Nachricht ein!", 3000, "2");
    }
    return;
  }
  // console.log(identifier)
  pool.query(sql, function (err, rows, fields) {
    // Connection is automatically released when query resolves
    if (err) throw err;

    if (!rows[0]) {
      return;
    }
    let rowsJob = rows[0].job;

    pool.query(
      `INSERT INTO tablet_frakchat (name, identifier, fraktion, message) VALUES ('${xPlayer.getName()}', '${
        rows[0].identifier
      }', '${rows[0].job}', '${message}');`,
      function (err, rows, fields) {
        // Connection is automatically released when query resolves
        if (err) throw err;
        frakChatRefresh(playerId, rowsJob, "newMessage");
        const embed = new MessageBuilder()

          .setAuthor(
            "PandaaFX",
            "https://cdn.discordapp.com/attachments/963200353124368394/998132014064611398/67377.png",
            "https://darkbluepandaa.de:8443"
          )
          .setColor("#303236")
          .setTitle("FrakChat")
          .setDescription(
            `Sender: \`${xPlayer.getName()}\`\nSender: \`${identifier}\`\nReceiver Job: \`${rowsJob}\`\nMessage: \`\`\`${message}\`\`\`\nDate: \`${new Date().toLocaleString(
              "de-DE",
              { hour12: false }
            )}\``
          )
          .setFooter("Pandaas Tablet")
          .setTimestamp();

        hookFrakChat.send(embed);
      }
    );
  });
});

onNet("hl-tablet:frakChat:refresh:1", (playerId, fraktion) => {
  frakChatRefresh(playerId, fraktion, null);
});

onNet("hl-tablet:AdminPanel:getStuffThings", (playerId) => {
  let xPlayer = ESX.GetPlayerFromId(playerId);
  let xPlayerGroup = xPlayer.getGroup();
  getStaff(xPlayerGroup, null, playerId);
  getOtherInfo(xPlayerGroup, playerId);
});

function frakChatRefresh(playerId, fraktion, valueeeeeee) {
  const identifier = GetPlayerIdentifierV2(playerId);
  pool.query(
    `SELECT * FROM tablet_frakchat WHERE fraktion = '${fraktion}' ORDER BY timestamp ASC`,
    function (err, rows, fields) {
      // Connection is automatically released when query resolves
      if (err) throw err;

      //   frakChatRefresh(playerId, rows[0].job)

      let objArrayT = [];
      rows.forEach((row) => {
        objArrayT.push({
          name: row.name,
          message: row.message,
          identifier: row.identifier,
          myMsg: row.identifier == identifier ? true : false,
          timestamp: mysqlTimeStampToDate(row.timestamp),
        });
      });

      let xPlayer = ESX.GetPlayerFromId(playerId);
      let xPlayers = ESX.GetPlayers();

      xPlayers.forEach((id) => {
        xPlayer = ESX.GetPlayerFromId(id);
        // return console.log(xPlayer);
        if (xPlayer.job.name == fraktion) {
          let xidentifier = GetPlayerIdentifierV2(id);
          objArrayT.forEach((item, index) => {
            // console.log("item", item, xPlayer.getName(), xPlayer.getName());
            if (item.identifier == xidentifier) {
              // console.log("change status");
              objArrayT[index].myMsg = true;
            } else {
              objArrayT[index].myMsg = false;
            }
          });
          emitNet("hl-tablet:frakChat:refresh:2", xPlayer.source, objArrayT);
          if(valueeeeeee == "newMessage") {
            if(playerId == xPlayer.source) return
                if(hasTablet(xPlayer.source)) {
                    emitNet("hl-tablet:notify", xPlayer.source, "info", "Du hast via FrakChat eine neue Nachricht erhalten!", 3000, "2");
                }
            }
        }
      });

      //   emitNet("hl-tablet:frakChat:refresh:2", playerId, objArrayT);
    }
  );
}

function getPlayerData(playerId, identifier, extra) {
  pool.query(
    `SELECT * FROM users WHERE identifier = '${identifier.replace(
      "license:",
      ""
    )}'`,
    function (err, rows, fields) {
      // Connection is automatically released when query resolves
      if (err) throw err;
      // console.log("Successfully connected to database");
      // console.log(rows);
      // console.log(rows);

      // if(extra == "admin") {
      //     getStaff(rows[0].group, rows[0], playerId)
      // } else {
      // if(rows[0].job != "unemployed") {
      // }
      getFrakAllMember(rows[0].job, rows[0], playerId);
      givePlayerUtilityoptions(playerId, rows[0], config);
      // }

      return;
    }
  );
}

function getStaff(one, two, playerId) {
  pool.query(
    `SELECT * FROM users WHERE \`group\` = 'guide' OR \`group\` = 'supporter' OR \`group\` = 'mod' OR \`group\` = 'dev' OR \`group\` = 'admin'`,
    function (err, rows, fields) {
      // Connection is automatically released when query resolves
      if (err) throw err;

      let objArray = [];
      let igor = 0;
      let ROWSLENGTH = rows.length;
      rows.forEach((row) => {
        igor++;
        let first = "";
        let lastname = "";
        let name = "";
        let group = "";
        first = row.firstname;
        lastname = row.lastname;
        group = row.group;
        pool.query(
          `SELECT * FROM user_identifiers WHERE license = 'license:${row.identifier}' ORDER BY date DESC LIMIT 1`,
          function (err, rows, fields) {
            // Connection is automatically released when query resolves
            if (err) throw err;
            objArray.push({
              firstandlastname: `${first} ${lastname}`,
              name: (rows[0] != undefined) ? rows[0].name : "NOT FOUND",
              group: group,
              status: "offline",
            });
          }
        );
      });

      if (igor == ROWSLENGTH) {
        setTimeout(() => {
          sendStaffList(playerId, objArray);
        }, 3500);
      }
    }
  );
}

let teamlerOnline = 0;
let userOnline = 0;
function sendStaffList(playerId, objArray) {
  (teamlerOnline = 0), (userOnline = 0);
  let xPlayer = ESX.GetPlayerFromId(playerId);
  let xPlayers = ESX.GetPlayers();

  xPlayers.forEach((id) => {
    xPlayer = ESX.GetPlayerFromId(id);
    userOnline++;
    // return console.log(xPlayer);
    let xPlayerGroup = xPlayer.getGroup();
    if (
      xPlayerGroup == "guide" ||
      xPlayerGroup == "supporter" ||
      xPlayerGroup == "mod" ||
      xPlayerGroup == "dev" ||
      xPlayerGroup == "admin"
    ) {
      teamlerOnline++;
      objArray.forEach((item, index) => {
        // console.log("item", item, xPlayer.getName(), xPlayer.getName());
        if (item.firstandlastname == xPlayer.getName()) {
          // console.log("change status");
          objArray[index].status = "online";
          // objArray[index].name = GetPlayerName(id)
        }
      });
    }
  });

  // console.log("KekServer")
  // console.log(JSON.stringify(objArray, null, 2))
  emitNet("hl-tablet:AdminPanel:getStuffThings", playerId, objArray);
}

function getOtherInfo(xPlayerGroup, playerId) {
  const currentTime = new Date().toLocaleTimeString("de-DE", {
    hour12: false,
    hour: "numeric",
    minute: "numeric",
  });
  const closestTime = getClosest(currentTime);
  // console.log(closestTime)
  // const closestTime = getClosestTime(config.adminpanel.restarts)

  const Group = xPlayerGroup;
  setTimeout(() => {
    emitNet(
      "hl-tablet:AdminPanel:getOtherThings",
      playerId,
      Group,
      closestTime,
      teamlerOnline,
      userOnline
    );
  }, 5000);
}

const getClosest = (targetTime) =>
  config.adminpanel.restarts.find((time) => time >= targetTime) || "00:00";

function getFrakAllMember(job, playerData, playerId) {
  // console.log(job);
  if (job != "unemployed") {
    pool.query(
      `SELECT * FROM users WHERE job = '${job}' ORDER BY job_grade DESC`,
      function (err, rows, fields) {
        // Connection is automatically released when query resolves
        if (err) throw err;
        let objArray = [];
        rows.forEach((row) => {
          objArray.push({
            firstandlastname: `${row.firstname} ${row.lastname}`,
            job: row.job,
            jobGrade: row.job_grade,
            status: "offline",
          });
        });

        let xPlayer = ESX.GetPlayerFromId(playerId);
        let xPlayers = ESX.GetPlayers();

        xPlayers.forEach((id) => {
          xPlayer = ESX.GetPlayerFromId(id);
          // return console.log(xPlayer);
          if (xPlayer.job.name == job) {
            objArray.forEach((item, index) => {
              // console.log("item", item, xPlayer.getName(), xPlayer.getName());
              if (item.firstandlastname == xPlayer.getName()) {
                // console.log("change status");
                objArray[index].status = "online";
              }
            });
          }
        });

        // setTimeout(() => {
        // console.log(JSON.stringify(objArray, null, 2));
        // console.log("iwdajdwadw")
        getLifeinvaderPosts(playerId, playerData, rows.length, objArray);
        return;
      }
    );
  } else {
    getLifeinvaderPosts(playerId, playerData, null, null);
  }
}

function getLifeinvaderPosts(playerId, playerData, rowslength, objArray) {
  // console.log("kek")
  pool.query(
    `SELECT * FROM lifeinvader ORDER BY timestamp DESC LIMIT 6`,
    function (err, rows, fields) {
      // Connection is automatically released when query resolves
      if (err) throw err;

      let objArrayL = [];
      rows.forEach((row) => {
        objArrayL.push({
          name: row.name,
          message: row.message,
          timestamp: mysqlTimeStampToDate(row.timestamp),
        });
      });

      // console.log(objArrayL)
      getNormalGarage(playerId, playerData, rowslength, objArray, objArrayL);
    }
  );
}

function getNormalGarage(
  playerId,
  playerData,
  rowslength,
  objArray,
  objArrayL
) {
  let license = GetPlayerIdentifierV2(playerId);
  pool.query(
    `SELECT * FROM owned_vehicles WHERE owner = '${license}' ORDER BY plate ASC`,
    function (err, rows, fields) {
      // Connection is automatically released when query resolves
      if (err) throw err;

      let objArrayC = [];
      rows.forEach((row) => {
        if (row.type != "car") return;
        objArrayC.push({
          plate: row.plate,
          model: JSON.parse(row.vehicle).model,
          stored: row.stored,
        });
      });

      emitNet(
        "hl-tablet:getData",
        playerId,
        playerData,
        rowslength,
        objArray,
        objArrayL,
        objArrayC
      );
      return;
    }
  );
}

function GetPlayerIdentifierV2(playerId) {
  // console.log(playerId)
  for (let index = 0; index < 5; index++) {
    let variable = GetPlayerIdentifier(playerId, index);
    if (variable.includes("license:")) {
      return variable.replace("license:", "");
    }
  }
}

function givePlayerUtilityoptions(playerId, rows, config) {
  emitNet("hl-tablet:givePlayerUtilityoptions", playerId, rows, config);
}

function mysqlTimeStampToDate(timestamp) {
  let myDate = timestamp;

  return (
    myDate.toLocaleTimeString("de-DE") +
    " - " +
    myDate.getDate() +
    "/" +
    (myDate.getMonth() + 1) +
    "/" +
    myDate.getFullYear()
  );
}



function hasTablet(source) {
    let xPlayer = ESX.GetPlayerFromId(source);
    let items = xPlayer.getInventoryItem("tablet");
    if (items.count > 0) {
        return true;
    } else {
        return false;
    }
}
