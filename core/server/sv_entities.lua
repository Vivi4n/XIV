Entities = {}

function entity(type, location, name, metadata, update)
	local ent = {}
	ent.__index = ent

	ent.type = type or "no-persist"
	ent.uid = math.random()
	ent.location = location or { x = 0.0, y = 0.0, z = 0.0, heading = 0.0 }
	ent.metadata = metadata or {}
	ent.name = name or "Default"

	function ent:setLocation(x, y, z, heading)
		self.location = { x = x, y = y, z = z, heading = (heading or 0.0) }
	end

	function ent:getLocation()
		return self.location
	end

	function ent:get(key)
		return self[key]
	end

	function ent:set(key, value)
		self[key] = value
		return self[key]
	end

	Entities[ent.uid] = ent

	print("[XIV] Entity created (" ..tostring(self.uid) .. "): " ..tostring(self.type) .. " " .. tostring(self.name))
end

Citizen.CreateThread(function()
	for k, v in pairs(Entities) do
		if v.update ~= nil then
			if v.type == "no-persist" then
				Entities[v.uid] = nil
			else
				update(v)
			end
		end
	end
end)

function distance (x1, y1, x2, y2)
	local dx = x1 - x2
	local dy = y1 - y2
	return math.sqrt(dx * dx + dy * dy)
end

entity("npc", {x = -1782.99, y = -383.39, z = 159.05}, "NPC-01", { hash = "A_C_Horse_Arabian_White" })

RegisterCommand("requestentities", function(source, args, rawCommand)
	TriggerClientEvent("xiv:manual_entity_update", source)
end)

RegisterServerEvent("xiv:request_entities")
AddEventHandler("xiv:request_entities", function(x, y)
	print("[XIV] Entity update requested by: " .. GetPlayerName(source) .. " at x" .. tostring(x) .. ", y" .. tostring(y))

	local _source = source

	local entities = {}

	for k, v in pairs(Entities) do
		if (distance(v.getLocation().x, v.getLocation().y, x, y) < Config.EntityDistance) then
			entities[k] = { type = v.get('type'), location = v.getLocation(), hash = v.get('metadata')}

			print("[XIV] Entity sent to client(" .. tostring(v.get('uid')) .. "): " .. v.get('name'))
		end
	end

	TriggerClientEvent("xiv:full_entity_list", _source, entities)
end)
