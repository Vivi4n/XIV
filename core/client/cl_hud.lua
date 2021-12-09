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

RegisterNetEvent('xiv:activeMoney')
AddEventHandler('xiv:activateMoney', function(_money)
	SendNUIMessage({
		setmoney = true,
		money = roundMe(_money, 2)
	})
end)

RegisterNetEvent('xiv:activateGold')
AddEventHandler('xiv:activateGold', function(_gold)
	SendNUIMessage({
		setgold = true,
		gold = _gold
	})
end)

RegisterNetEvent('xiv:moneyLoaded')
AddEventHandler('xiv:moneyLoaded', function(_money)
	SendNUIMessage({
		setmoney = true,
		money = roundMe(_money, 2)
	})
end)

RegisterNetEvent('xiv:xpLoaded')
AddEventHandler('xiv:xpLoaded', function(_xp)
	if Config.ShowXPandLevel == 1 then
		SendNUIMessage({
			setxp = true,
			xp = _xp
		})
	end
end)

RegisterNetEvent('xiv:levelLoaded')
AddEventHandler('xiv:levelLoaded', function(_level)
	if Config.ShowXPandLevel == 1 then
		SendNUIMessage({
			setlevel = true,
			level = _level
		})
	end
end)

RegisterNetEvent('xiv:activateXP')
AddEventHandler('xiv:activateXP', function(_xp)
	if Config.ShowXPandLevel == 1 then
		SendNUIMessage({
			setxp = true,
			xp = _xp
		})
	end
end)

RegisterNetEvent('xiv:activateLevel')
AddEventHandler('xiv:activateLevel', function(_level)
	if Config.ShowXPandLevel == 1 then
		SendNUIMessage({
			setlevel = true
			level = _level
		})
	end
end)

RegisterNetEvent('xiv:goldLoaded')
AddEventHandler('xiv:goldLoaded', function(_gold)
	SendNUIMessage({
		setgold = true,
		gold = _gold
	})
end)

-- Updating
RegisterNetEvent('xiv:addMoney')
AddEventHandler('xiv:addMoney', function(_money, native, current)
	SendNUIMessage({
		addcash = true,
		money = roundMe(_money, 2)
	})
end)

RegisterNetEvent('xiv:addXP')
AddEventHandler('xiv:addXP', function(_xp, native, current)
	if Config.ShowXPandLevel == 1 then
		SendNUIMessage({
			addxp = true,
			xp = _xp
		})
	end
end)

RegisterNetEvent('xiv:removeXP')
AddEventHandler('xiv:removeXP', function(_xp, native, current)
	if Config.ShowXPandLevel == 1 then
		SendNUIMessage({
			removexp = true,
			xp = _xp
		})
	end
end)

RegisterNetEvent('xiv:removeLevel')
AddEventHandler('xiv:removeLevel', function(_level, native, current)
	if Config.ShowXPandLevel == 1 then
		SendNUIMessage({
			removelevel = true,
			level = _level
		})
	end
end)

RegisterNetEvent('xiv:addLevel')
AddEventHandler('xiv:addLevel', function(_level, native, current)
	if Config.ShowXPandLevel == 1 then
		SendNUIMessage({
			addlevel = true,
			level = _level
		})
	end
end)

RegisterNetEvent('xiv:addGold')
AddEventHandler("xiv:addGold", function(_gold, native, current)
	SendNUIMessage({
		addgold = true,
		gold = _gold
	})
end)

RegisterNetEvent('xiv:removeMoney')
AddEventHandler("xiv:removeMoney", function(_money, native, current)
	SendNUIMessage({
		removecash = true,
		money = roundMe(_money, 2)
	})
end)

RegisterNetEvent('redem:removeMoney')
AddEventHandler('redem:removeMoney', function(_money, native, current)
	SendNUIMessage({
		removecash = true,
		money = roundMe(_money, 2)
	})
end)


RegisterNetEvent('xiv:removeGold')
AddEventHandler('xiv:removeGold', function(_gold, native, current)
	SendNUIMessage({
		removegold = true,
		gold = _gold
	})
end)