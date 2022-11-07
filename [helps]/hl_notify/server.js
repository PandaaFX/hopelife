let ESX = null;
emit("esx:getSharedObject", (obj) => (ESX = obj));

RegisterCommand("announce", async (source, args) => {
  let msg = args.join(" ");

  let xPlayer = ESX.GetPlayerFromId(source);
  if (checkGroup(xPlayer.getGroup())) {
    emitNet("txAdmin:receiveAnnounce", -1, msg, xPlayer.getGroup());
  } else {
    // console.log("err");
    // ESX.ShowNotification("You are not in the correct group to use this command.");
    emitNet(
      "hopelife:notify",
      source,
      1,
      "#b60000",
      "ERROR",
      "You are not in the correct group to use this command!",
      5500
    );
  }
  return;
});

const adminRoles = ["superadmin", "admin", "dev"];

function checkGroup(currentGroup) {
  let vari = false;
  // console.log(currentGroup);
  adminRoles.forEach((role) => {
    // console.log(role);
    if (currentGroup == role) {
      return (vari = true);
    }
  });

  return vari;
}
