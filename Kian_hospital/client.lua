--------------------------------------
-------- Script: Kian_hospital -------
------- Made by Kian Frostholm -------
--------------------------------------

HealingIgang = false

---------------------------------------------------------------------------
---								  Functions								---
---------------------------------------------------------------------------
Citizen.CreateThread(function() 
	while true do
		Citizen.Wait(1)
        for k,v in pairs(cfg.checkin) do
			distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v[1], v[2], v[3], false)
			if distance <= 10.0 and distance >= 2.0 then
				DrawMarker(20, v[1], v[2], v[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.7, 52, 103, 235, 100, false, true, 2, false, false, false, false)
				elseif distance <= 2.0 then
					DrawText3Ds(v[1], v[2], v[3]+0.20, '~b~[E]~w~ - Bliv tilset', 3.0, 7)
					if IsControlJustPressed(1, 38) then
						HealingIgang = true
						BlivTilset()
				end
			end
		end
	end
end)


function BlivTilset()
	Citizen.CreateThread(function()
		while HealingIgang == true do
			local seng = math.random(1, #cfg.senge)
				local ped = PlayerPedId()
				DoScreenFadeOut(500)
				Wait(500)
				SetEntityCoords(GetPlayerPed(-1), cfg.senge[seng].x,cfg.senge[seng].y,cfg.senge[seng].z)
				FreezeEntityPosition(ped,true)
				TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', cfg.senge[seng].x,cfg.senge[seng].y,cfg.senge[seng].z, cfg.senge[seng].h, 0, true, true)
				Wait(1500)
				DoScreenFadeIn(2500)
				exports['progressBars']:startUI(cfg.healtime*1000, "Du bliver helbredt")
				Wait(cfg.healtime*1000)
				SetEntityHealth(GetPlayerPed(-1), 200)
				print('Du er nu blevet helbredt') -- Tilføj eget notify her
				FreezeEntityPosition(ped,false)
				ClearPedTasks(ped)
				HealingIgang = false
			end
		end)
	end


-- 3D Text

function DrawText3Ds(x,y,z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	SetTextScale(0.36, 0.36)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 370
	DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 60)
end