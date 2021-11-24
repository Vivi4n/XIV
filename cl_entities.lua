Entities = {}

LoadModel = function(model)
	while not HasModelLoaded(model) do
		RequestModel(model)

		Citizen.Wait(1)
	end
end

function SpawnNPC(hash, x, y, z)
	local hash = GetHashKey(hash)
	LoadModel(hash)
	local result = CreatePed(hash, x, y, z, 0, 0, 0, 0, Citizen.ResultAsInteger())
	SetEntityVisible(result, 1)
	SetEntityAlpha(result, 255, false)
	Citizen.InvokeNative(0x283978A15512B2FE, result, true)
	SetModelAsNoLongerNeeded(hash)

	return result
end

RegisterNetEvent("xiv:full_entity_list")
AddEventHandler("xiv:full_entity_list", function(entities)
	Entities = entities

	for k, v in pairs (entities) do
		if (v. type == "npc") then
			local newNPC = SpawnNPC(v.metadata.hash, v.location.x, v.location.y, v.location.z)

			FreezeEntityPosition(newNPC, true)

			Citizen.CreateThread(function()
				Citizen.Wait(2000)
				SetEntityAsMissionEntity(newNPC, 1, 1)
				DeletePed(newNPC)
				DeleteEntity(newNPC)
			end)
		end
	end
end)

RegisterNetEvent("xiv:manual_entity_update")
AddEventHandler("xiv:manual_entity_update", function()
	local p_coords = GetEntityCoords(PlayerPedId())
	TriggerServerEvent("xiv:request_entities"), p_coords.x, p_coords.y)
end)