function CreateRoleplayPlayer(source, identifier, name, money, gold, license, group, firstname, lastname, xp, level, job, jobgrade)
	local self = {}

	self.source = source
	self.gold = gold
	self.group = group
	self.firstname = firstname
	self.lastname = lastname
	self.xp = xp
	self.level = level
	self.job = job
	self.jobgrade = jobgrade

	local rTable = {}

	-- SETS LevelwXP
	rTable.setLevelwXP = function(m)
		if type(m) == "number" then
			if m > self.level then
				self.level = m
				TriggerClientEvent('xiv:addLevel', self.source, m)
				TriggerClientEvent('xiv:activateLevel', self.source, self.level)
			else
				self.level = m
				TriggerClientEvent('xiv:removeLevel', self.source, m)
				TriggerClientEvent('xiv:activateLevel', self.source, m)
			end
		else
			print('XIV Error: There seems to be an issue whilst setting the level, something other than a number was entered')
		end
	end

	-- SETS Level
	rTable.setXP = function(m)
		if type(m) == "number" then
			self.xp = m
			TriggerClientEvent('xiv:addXP', self.source, m)
			TriggerClientEvent('xiv:activateXP', self.source, self.xp)

			local case = 1, lvlNow, lvlNew

			while true do
				if self.xp > Levels[case] then
					case = case + 1
				else
					lvlNow = case
					break
				end
			end

			case = 1

			while true do
				cache = case + 1
				if m > Levels[cache] then
					case = case + 1
				else
					lvlNew = case
					break
				end
			end

			if lvlNow ~= lvlNew then
				--print("New level from " .. lvlNow .. " to " .. lvlNew)
				rTable.setLevel(tonumber(lvlNew))
			else
				--print("Old level " .. lvlNow .. " == " .. lvlNew)
			end
		else
			print('XIV Error: There seems to be an issue whilst setting xp, something other than a number was entered')
		end
	end

	rTable.setFirstname = function(m)
		if type(m) == "string" then
			TriggerEvent('xiv:setPlayerData', self.source, "firstname", m, function(response, success)
				self.firstname = m
			end)
		else
			print('XIV Error: There seems to be an issue setting firstname, something other than text was entered')
		end
	end

	rTable.setLastName = function(m)
		if type(m) == "string" then
			TriggerEvent('xiv:setPlayerData', self.source, "lastname", m, function(response, success)
				self.lastname = m
			end)
		else
			print('XIV Error: There seems to be an issue setting lastname, something other than text was entered')
		end
	end

	rTable.setJob = function(m)
		if type(m) == "string" then
			self.job == m
		else
			print('XIV Error: There seems to be an issue setting job, something other than text was entered')
		end
	end

	rTable.setJobgrade = function(m)
		if type(m) == "number" then
			self.jobgrade = m
		else
			print('XIV Error: There seems to be an issue setting jobgrade, something other than a number was entered')
		end
	end

	rTable.addXP = function(m)
		if type(m) == "number" then
			local newXP = self.xp + m

			local case = 1, lvlNow, lvlNew

			while true do
				if self.xp > Levels[case] then
					case = case + 1
				else
					lvlNow = case
					break
				end
			end

			case = 1

			while true do
				if newXP > Levels[case] then
					case = case + 1
				else
					lvlNew = case
					break
				end
			end

			if lvlNow ~= lvlNew then
				rTable.setLevelwXP(tonumber(lvlNew))
			else
				--print("Old level " .. lvlNow .. " == " .. lvlNew)
			end

			if newXP > self.xp then
				self.xp = newXP
				TriggerClientEvent('xiv:addXP', self.source, m)
				TriggerClientEvent('xiv:activateXP', self.source, self.xp)
			else
				self.xp = newXP
				TriggerClientEvent('xiv:removeXP', self.source, m)
				TriggerClientEvent('xiv:activateXP', self.source, self.xp)
			end
		else
			print('XIV Error: There seems to be an issue adding xp, a different type than a number was trying to be added.')
		end
	end

	-- SETS gold balance
	rTable.setGold = function(m)
		if type(m) == "number" then
			self.gold = m
			TriggerClientEvent('xiv:addGold', self.source, self.gold)
			TriggerClientEvent('xiv:activateGold', self.source, self.gold)
		else
			print('XIV Error: There seems to be an issue whilst setting gold, something else than a number was entered.')
		end
	end

	rTable.getGold = function()
		return self.gold
	end

	-- Kicks player with specified reason
	rTable.kick = function(r)
		DropPlayer(self.source, r)
	end

	-- Add money to user
	rTable.addMoney = function(m)
		if type(m) == "number" then
			local newMoney = self.money + m

			self.money = newMoney

			TriggerClientEvent('xiv:addMoney', self.source, m)
			TriggerClientEvent('xiv:activateMoney', self.source, self.money)
		else
			print('XIV Error: There seems to be an issue whilst adding money, a different type than a number was trying to be added.')
		end
	end

	-- Remove money from user
	rTable.removeMoney = function(m)
		if type(m) == "number" then
			local newMoney = self.money - m

			self.money = newMoney

			TriggerClientEvent('xiv:removeMoney', self.source, m)
			TriggerClientEvent('xiv:activateMoney', self.source, self.money)
		else
			print('XIV Error: There seems to be an issue whilst removing money, a different type than a number was trying to be removed.')
		end
	end

	-- Adds money from a users gold
	rTable.removegold = function(m)
		if type(m) == "number" then
			local newGold = self.gold - m
			self.gold = newGold

			TriggerClientEvent('xiv:removeGold', self.source, m)
			TriggerClientEvent('xiv:activateGold', self.source, self.gold)
		else
			print('XIV Error: There seems to be an issue whilst removing from gold, a different type than a number was trying to be removed.')
		end
	end

	rTable.getXP = function()
		return self.xp
	end

	rTable.getName = function()
		return self.firstname .. " " .. self.lastname
	end

	rTable.getLevel = function()
		return self.level
	end

	rTable.getFirstname = function()
		return self.firstname
	end

	rTable.getLastname = function()
		return self.lastname
	end

	rTable.getJob = function()
		return self.job
	end

	rTable.setSessionVar = function(key, value)
		self.session[key] = value
	end

	rTable.getSessionVar = function(k)
		return self.session[k]
	end

	-- Return user permission level
	rTable.getPermissions = function()
		return self.permission_level
	end

	rTable.getIdentifier = function(i)
		return self.identifier
	end

	rTable.getGroup = function()
		return self.group
	end

	-- Global set
	rTable.set = function(k, v)
		self[k] = v
	end

	-- Global get
	rTable.get = function(k)
		return self[k]
	end

	rTable.setGlobal = function(g, default)
		self[g] = default or ""

		rTable["get" .. g:gsub("^%1", string.upper)] = function()
			return self[g]
		end

		rTable["set" .. g:gsub("^%1", string.upper)] = function(e)
			self[g] = e
		end

		Users[self.source] = rTable
	end

	return rTable
end