_serverPrefix = "xiv: "
_VERSION = '1.0.0'
_firstCheckPerformed = false

Users = {}

RegisterServerEvent('xiv:selectCharacter')
AddEventHandler('xiv:selectCharcter', function(character)
	local _source = source
	TriggerEvent("xiv:getPlayerFromId", _source, function(user)
		loadCharacter(_source, user, character)
	end)
end)

RegisterServerEvent('xiv:createCharacter')
AddEventHandler('xiv:createCharacter', function(firstname, lastname)
	local _source = source
	TriggerEvent("xiv:getPlayerFromId", _source, function(user)
		addCharacter(_source, user, firstname, lastname)
	end)
end)

RegisterCommand("sc", function(source, args, rawCommand)
	local _source = source
	TriggerEvent("xiv:getPlayerFromId", _source, function(user)
		loadCharacter(_source, user, args[1])
	end)
end)

RegisterCommand("ac", function(source, args, rawCommand)
	local _source = source
	TriggerEvent("xiv:getPlayerFromId", _source, function(user)
		addCharacter(_source, user, args[1], args[2])
	end)
end)

function loadCharacter(_source, user, charid)
	TriggerEvent("xiv_db:retrieveUser", user.getIdentifier(), charid, function(_user)
		if _user ~= false then
			local rpPlayer = CreateRoleplayPlayer(_source, _user.identifier, _user.name, _user.money, _user.gold, _user.license, _user.group, _user.firstname, _user.lastname, _user.xp, _user.level, _user.job, _user.jobgrade)
			Users[_source] = rpPlayer

			for k, v in pairs(user) do Users[_source][k] = v end

			-- Set up the character related stuffs.
			Users[_source].setMoney(_user.money)
			Users[_source].setSessionVar("charid", charid)

			TriggerEvent('xiv:playerLoaded', _source, Users[_source])
			TriggerClientEvent('xiv:moneyLoaded', _source, Users[_source].getMoney())
			TriggerClientEvent('xiv:goldLoaded', _source, Users[_source].getGold())
			TriggerClientEvent('xiv:xpLoaded', _source, Users[_source].getXP())
			TriggerClientEvent('xiv:levelLoaded', _source, Users[_source].getLevel())
			TriggerClientEvent('xiv:showID', _source, _source)
		else
			print("That character does not exist!")
		end
	end)
end