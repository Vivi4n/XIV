_serverPrefix = "xiv: "
_VERSION = '1.0.0'
_firstCheckPerformed = false

Users = {}

RegisterServerEvent('xiv:selectCharacter')
AddEventHandler('xiv:selectCharcter', function(character)
	local _source = source
	TriggerEvent('xiv:getPlayerFromId', _source, function(user)
		loadCharacter(_source, user, character)
	end)
end)
