Citizen.CreateThread(function ()
	while true do
		

		if GetPlayerName(PlayerId()) == "HL | MrsXeniaTv" or GetPlayerName(PlayerId()) == "HL I JAMAL" or
		 GetPlayerName(PlayerId()) == "HL | Thomas Changretto" or GetPlayerName(PlayerId()) == "HL | BIG Ch1ll4x0" then

		
			if(IsRecording()) then
				if(IsControlJustPressed(0,Config.binding.stop_save_record)) then
					StopRecordingAndSaveClip()					
				end
				
				if(IsControlJustPressed(0,Config.binding.stop_discard_record)) then
					StopRecordingAndDiscardClip()					
				end
			else
				--Doesn't seems to work
				if(IsControlJustPressed(0,Config.binding.start_record_replay)) then
					StartRecording(0)
					
				end
				
				if(IsControlJustPressed(0,Config.binding.start_record)) then
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