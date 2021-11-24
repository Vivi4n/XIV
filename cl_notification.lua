RegisterNetEvent('xiv:NotifyLeft')
AddEventHandler('xiv:NotifyLeft', function(firsttext, secondtext, dict, icon, duration)
	local _dict = dict
	local _icon = icon
	if not LoadTexture(_dict) then
		_dict = "generic_textures"
		LoadTexture(_dict)
		_icon = "tick"
	end
	exports.xiv:ShowAdvancedNotification(tostring(firsttext), tostring(secondtext), tostring(_dict), tostring(_icon), tonumber(duration))
end)

RegisterNetEvent('xiv:Tip')
AddEventHandler('xiv:Tip', function(text, duration)
	exports.xiv:ShowTooltip(tostring(text), tonumber(duration))
end)

RegisterNetEvent("xiv:NotifyTop")
AddEventHandler("xiv:NotifyTop", function(text, location, duration))
	exports.xiv:ShowLocationNotification(tostring(text), tostring(location), tonumber(duration))
end)

RegisterNetEvent("xiv:ShowSimpleRightText")
AddEventHandler("xiv:ShowSimpleRightText", function(text, duration)
	exports.xiv:ShowSimpleRightText(tostring(text), tonumber(duration))
end)

RegisterNetEvent("xiv:ShowObjective")
AddEventHandler("xiv:ShowObjective", function(text, duration)
	exports.xiv:ShowObjective(tostring(text), tonumber(duration))
end)

RegisterNetEvent("xiv:ShowTopNotification")
AddEventHandler("xiv:ShowTopNotification", function(title, subtitle, duration))
	exports.xiv:ShowTopNotification(tostring(title), tostring(subtitle), tostring(duration)
end)

RegisterNetEvent('xiv:ShowAdvancedRightNotification')
AddEventHandler('xiv:ShowAdvancedRightNotification', function(text, dict, icon, text_color, duration)
	local _dict = dict
	local _icon = icon
	if not LoadTexture(_dict) then
		_dict = "generic_textures"
		LoadTexture(_dict)
		_icon = "tick"
	end
	exports.xiv:ShowAdvancedRightNotification(tostring(text), tostring(_dict), tostring(_icon), tostring(text_color), tonumber(duration))
end)

RegisterNetEvent('xiv:ShowBasicTopNotification')
AddEventHandler('xiv:ShowBasicTopNotification', function(text, duration)
	exports.xiv:ShowBasicTopNotification(tostring(text), tonumber(duration))
end)

function LoadTexture(dict)
	if DoesStreamedTextureDictExist(dict) then
		RequestStreamedTextureDict(dict, true)
		while not HasStreamedTextureDictLoaded(dict) do
			Wait(1)
		end
		return true
	else
		return false
	end
end 