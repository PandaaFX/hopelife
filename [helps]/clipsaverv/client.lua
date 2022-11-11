Citizen.CreateThread(function ()
	while true do
		

		if GetPlayerName(PlayerId()) == "HL | MrsXeniaTv" or GetPlayerName(PlayerId()) == "HL I JAMAL" or
		 GetPlayerName(PlayerId()) == "HL | Thomas Changretto" or GetPlayerName(PlayerId()) == "HL | BIG Ch1ll4x0" then

		
			if(IsRecording()) then
				if(IsControlJustPressed(0,Config.binding.stop_save_record)) then
					ESX.ShowNotification("Aufname ~r~gestoppt", "success", 3000)
					StopRecordingAndSaveClip()					
				end
				
				if(IsControlJustPressed(0,Config.binding.stop_discard_record)) then
					ESX.ShowNotification("Aufname ~r~gestoppt und gelöscht", "success", 3000)
					StopRecordingAndDiscardClip()					
				end
			else
				--Doesn't seems to work
				if(IsControlJustPressed(0,Config.binding.start_record_replay)) then
					ESX.ShowNotification("Replay ~g~gestartet", "success", 3000)
					StartRecording(0)
					
				end
				
				if(IsControlJustPressed(0,Config.binding.start_record)) then
					ESX.ShowNotification("Aufname ~g~gestartet", "success", 3000)
					StartRecording(1)
					
				end
			end
			
			if(IsControlJustPressed(1,Config.binding.open_editor)) then
				NetworkSessionLeaveSinglePlayer()
				ActivateRockstarEditor()
			end
		end
		Citizen.Wait(1)
	end
end)