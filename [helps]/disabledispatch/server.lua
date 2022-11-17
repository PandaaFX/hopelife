RegisterServerEvent("SyncEntityDamage")
AddEventHandler('SyncEntityDamage',function(nowhp,oldhp)

        TriggerClientEvent('OnEntityHealthChange',-1,source,nowhp,oldhp)

   
end )