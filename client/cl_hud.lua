local money = 0
local gold = 0
local id
local hidehud = false

function roundMe(n, dec)
	local power = 10 ^ dec
	return math.floor(n * power) / power
end

RegisterCommand("hud", function(source, args, rawCommand)
	if (hidehud ~= false) then
		hidehud = false
		TriggerEvent("xiv:showHUD")
		DisplayHud(true)
	else
		hidehud = true
		DisplayHud(false)
		TriggerEvent("xiv:hideHUD")
	end
end, false)

RegisterNetEvent('xiv:showHUD')
AddEventHandler('xiv:showHUD', function()
	SendNUIMessage({
		showhud = true
	})
end)

RegisterNetEvent('xiv:hideHUD')
AddEventHandler('xiv:hideHUD', function()
	SendNUIMessage({
		hidehud = true
	})
end)

RegisterNetEvent('xiv:showID')
AddEventHandler('xiv:showID', function(_id)
	if Config.ShowID == 1 then
		SendNUIMessage({
			showid = true,
			id = _id
		})
	end
end)

