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

function addCharacter(_source, user, firstname, lastname)
	if (firstname and lastname) then
		TriggerEvent("xiv_db:createUser", user.getIdentifier(), firstname, lastname, function(charID)
			print("Character has been made.")
			loadCharacter(_source, user, charID)
		end)
	end
end

AddEventHandler("xiv:getPlayerFromId", function(user, cb)
	if (Users) then
		if (Users[user]) then
			cb(Users[user])
		else
			cb(nil)
		end
	else
		cb(nil)
	end
end)

AddEventHandler('playerDropped', function()
	local Source = source

	if (Users[Source]) then
		TriggerEvent("xiv:playerDropped", Users[Source])
		TriggerEvent("xiv_db:updateUser", Users[Source].getIdentifier(), tonumber(Users[Source].getSessionVar("charid")), {money = Users[Source].getMoney(), gold = Users[Source].getGold(), xp = tonumber(Users[Source].getXP()), level = tonumber(Users[Source].getLevel()) , job = Users[Source].getJob(), jobgrade = tonumber(Users[Source].getJobgrade())}, function()
		Users[Source] = nil
		end)
	end
end)

AddEventHandler("xiv:getAllPlayers", function(cb)
	cb(Users)
end)

function getPlayerFromId(id)
	return Users[id]
end

local function savePlayerMoney()
	SetTimeout(60000, function()
		Citizen.CreateThread(function()
			for k, v in pairs(Users) do
				if Users[k] ~= nil then
					TriggerEvent('xiv_db:updateUser', v.getIdentifier(), tonumber(v.getSessionVar("charid")), {money = v.getMoney(), gold = v.getGold(), xp = tonumber(v.getXP()), level = tonumber(v.getLevel()), job = v.getJob(), jobgrade = tonumber(v.getJobgrade())}, function()					
					end)
				end
			end

			savePlayerMoney()
		end)
	end)
end

AddEventHandler('xiv_db:doesUserExist', function(identifier, cb)
    MySQL.Async.fetchAll('SELECT 1 FROM users WHERE `identifier`=@identifier;', {identifier = identifier}, function(users)
        if users[1] then
            cb(true)
        else
            cb(false)
        end
    end)
end)

local DBData

function CharacterExist (id)	
	local test = false
	    for k,v in pairs(DBData) do
			if v.characterid == id then
				test = true
			end
		end
    return (test)
end	

AddEventHandler('xiv_db:createUser', function(identifier, firstname, lastname, callback)
	MySQL.Async.fetchAll('SELECT * FROM characters WHERE `identifier`=@identifier', {identifier = identifier}, function(users)
		DBData = users
		local charID = 1
		while CharacterExist(charID) do 
		   charID = charID + 1
      		 end
		print("Found charID "..charID)
		MySQL.Async.execute('INSERT INTO characters (`identifier`, `firstname`, `lastname`, `characterid`) VALUES (@identifier, @firstname, @lastname, @characterid);',
		{
			identifier = identifier,
			firstname = firstname,
			lastname = lastname,
			characterid = charID
			
		}, function(rowsChanged)
			callback(charID)
		end)
	end)
end)

AddEventHandler('xiv_db:retrieveUser', function(identifier, charid, callback)
	local SavedCallback = callback
	MySQL.Async.fetchAll('SELECT * FROM characters WHERE `identifier`=@identifier AND `characterid`=@characterid;', {identifier = identifier, characterid = charid}, function(users)
		if users[1] then
			SavedCallback(users[1])
		else
			SavedCallback(false)
		end
	end)
end)

AddEventHandler('xiv_db:updateUser', function(identifier, charid, new, callback)
	Citizen.CreateThread(function()
		local updateString = ""

		local length = tLength(new)
		local cLength = 1
		for k,v in pairs(new)do
			if cLength < length then
				if(type(v) == "number")then
					updateString = updateString .. "`" .. k .. "`=" .. v .. ","
				else
					updateString = updateString .. "`" .. k .. "`='" .. v .. "',"
				end
			else
				if(type(v) == "number")then
					updateString = updateString .. "`" .. k .. "`=" .. v .. ""
				else
					updateString = updateString .. "`" .. k .. "`='" .. v .. "'"
				end
			end
			cLength = cLength + 1
		end
		MySQL.Async.execute('UPDATE characters SET ' .. updateString .. ' WHERE `identifier`=@identifier AND `characterid`=@characterid', {identifier = identifier, characterid = charid}, function(done)
			if callback then
				callback(true)
			end
		end)
	end)
end)