if Config.AdminCommands == 1 then
	RegisterCommand("setgold", function(source, args, rawCommand)
		if args[1] == nil or args[2] == nil then
			print("Argument #1 or #2 is bad")
		else
			TriggerEvent("xiv:setGold", source, args[1], args[2], function(cb)end)
		end
	end, false)

	RegisterCommand("setmoney", function(source, args, rawCommand)
		if args[1] == nil or args[2] == nil then
			print("Argument #1 or #2 is bad")
		else
			TriggerEvent("xiv:setMoney", source, args[1], args[2], function(cb)end)
		end
	end, false)

	RegisterCommand("setlevel", function(source, args, rawCommand)
		if args[1] == nil or args[2] == nil then
			print("Argument #1 or #2 is bad")
		else
			TriggerEvent("xiv:setLevel", source, args[1], args[2], function(cb)end)
		end
	end, false)

	RegisterCommand("setxp", function(source, args, rawCommand)
		if args[1] == nil or args[2] == nil then
			print("Argument #1 or #2 is bad")
		else
			TriggerEvent("xiv:setXP", source, args[1], args[2], function(cb)end)
		end
	end, false)

	RegisterCommand("setjob", function(source, args, rawCommand)
		if args[1] == nil or args[2] == nil or args[3] == nil then
			print("Argument #1, #2 or #3 is bad")
		else
			TriggerEvent("xiv:setJob", source, args[1], args[2], args[3], function(cb)end)
		end
	end, false)

	RegisterCommand("addmoney", function(source, args, rawCommand)
		if args[1] == nil or args[2] == nil then
			print("Argument #1 or #2 is bad")
		else
			TriggerEvent("xiv:addMoney", source, args[1], args[2], function(cb)end)
		end
	end, false)

	RegisterCommand("addgold", function(source, args, rawCommand)
		if args[1] == nil or args[2] == nil then
			print("Argument #1 or #2 is bad")
		else
			TriggerEvent("xiv:addGold", source, args[1], args[2], function(cb)end)
		end
	end, false)

	RegisterCommand("addxp", function(source, args, rawCommand)
		if args[1] == nil or args[2] == nil then
			print("Argument #1 or #2 is bad")
		else
			TriggerEvent("xiv:addXP", source, args[1], args[2], function(cb)end)
		end
	end, false)

	RegisterCommand("removemoney", function(source, args, rawCommand)
		if args[1] == nil or args[2] == nil then
			print("Argument #1 or #2 is bad")
		else
			TriggerEvent("xiv:removeMoney", source, args[1], args[2], function(cb)end)
		end
	end, false)

	RegisterCommand("removegold", function(source, args, rawCommand)
		if args[1] == nil or args[2] == nil then
			print("Argument #1 or #2 is bad")
		else
			TriggerEvent("xiv:removeGold", source, args[1], args[2], function(cb)end)
		end
	end, false)

	RegisterCommand("setgroup", function(source, args, rawCommand)
		if args[1] == nil or args[2] == nil then
			print("Argument #1 or #2 is bad")
		else
			TriggerEvent("xiv:setGroup", source, args[1], args[2], function(cb)end)
		end
	end, false)
end

AddEventHandler("xiv:SetSomeGold", function(source, id, count, cb)
	print("[" .. GetInvokingResource() .. "] ^1" .. " called deprecated event `xiv:SetSomeGold` please be sure to update to the standarized API introduced in v1.0.0")
	TriggerEvent("xiv:setGold", source, id, count, cb)
end)

AddEventHandler("xiv:setGold", function(source, id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('xiv:getPlayerFromId', _perm, function(pg)
		if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
			print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")	
		else
			local _source = tonumber(id)
			TriggerEvent('xiv:getPlayerFromId', _source, function(user)
				if user == nil then
					--TODO Temporary command Feeback	
					print("Admin command Feedback: this user doesnt exist")
				else
					user.setGold(tonumber(count))
					print("Done set gold to user: "..user.getName())
				end
			end)
		end
	end)
end)

AddEventHandler("xiv:SetSomeJob", function(source, id, count, grade, cb)
	print("[" .. GetInvokingResource() .. "] ^1" .. " called deprecated event `xiv:SetSomeJob` please be sure to update to the standarized API introduced in v1.0.0")
	TriggerEvent("xiv:setJob", source, id, count, grade, cb)
end)

AddEventHandler("xiv:setJob", function(source, id, count, grade, cb)
	local _perm = tonumber(source)
	TriggerEvent('xiv:getPlayerFromId', _perm, function(pg)
		if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
			print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
		else
			local _source = tonumber(id)
			TriggerEvent('xiv:getPlayerFromId', _source, function(user)
				if user == nil then
					--TODO Temporary command Feeback	
					print("Admin command Feedback: this user doesnt exist")
				else
					user.setJob(count)
					user.setJobgrade(tonumber(grade))
					print("Done set job to user: "..user.getName())
				end
			end)
		end
	end)
end)

AddEventHandler("xiv:SetSomeMoney", function(source, id, count, cb)
	print("[" .. GetInvokingResource() .. "] ^1" .. " called deprecated event `xiv:SetSomeMoney` please be sure to update to the standarized API introduced in v1.0.0")
	TriggerEvent("xiv:setMoney", source, id, count, cb)
end)

AddEventHandler("xiv:setMoney", function(source, id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('xiv:getPlayerFromId', _perm, function(pg)
		if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
			print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
		else
			local _source = tonumber(id)
			TriggerEvent('xiv:getPlayerFromId', _source, function(user)
				if user == nil then
					--TODO Temporary command Feeback	
					print("Admin command Feedback: this user doesnt exist")
				else
					user.setMoney(tonumber(count))
					print("Done set money to user: "..user.getName())
				end
			end)
		end
	end)
end)

AddEventHandler("xiv:AddSomeGold", function(source, id, count, cb)
	print("[" .. GetInvokingResource() .. "] ^1" .. " called deprecated event `xiv:AddSomeGold` please be sure to update to the standarized API introduced in v1.0.0")
	TriggerEvent("xiv:addGold", source, id, count, cb)
end)

AddEventHandler("xiv:addGold", function(source, id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('xiv:getPlayerFromId', _perm, function(pg)
		if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
			print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
		else
			local _source = tonumber(id)
			TriggerEvent('xiv:getPlayerFromId', _source, function(user)
				if user == nil then
					--TODO Temporary command Feeback	
					print("Admin command Feedback: this user doesnt exist")
				else
					user.addGold(tonumber(count))
					print("Done add gold to user: "..user.getName())
				end
			end)
		end
	end)
end)
	
AddEventHandler("xiv:AddSomeMoney", function(source, id, count, cb)
	print("[" .. GetInvokingResource() .. "] ^1" .. " called deprecated event `xiv:AddSomeMoney` please be sure to update to the standarized API introduced in v1.0.0")
	TriggerEvent("xiv:addMoney", source, id, count, cb)
end)

AddEventHandler("xiv:addMoney", function(source, id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('xiv:getPlayerFromId', _perm, function(pg)
		if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then	
			print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
		else
			local _source = tonumber(id)
			TriggerEvent('xiv:getPlayerFromId', _source, function(user)
				if user == nil then
					--TODO Temporary command Feeback
					print("Admin command Feedback: this user doesnt exist")
				else
					user.addMoney(tonumber(count))
					print("Done add money to user: "..user.getName())
				end
			end)
		end
	end)
end)
	
AddEventHandler("xiv:RemoveSomeGold", function(source, id, count, cb)
	print("[" .. GetInvokingResource() .. "] ^1" .. " called deprecated event `xiv:RemoveSomeGold` please be sure to update to the standarized API introduced in v1.0.0")
	TriggerEvent("xiv:removeGold", source, id, count, cb)
end)

AddEventHandler("xiv:removeGold", function(source, id, count, cb)
	local _perm = tonumber(source)
		TriggerEvent('xiv:getPlayerFromId', _perm, function(pg)
		if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
			print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
		else
			local _source = tonumber(id)
			TriggerEvent('xiv:getPlayerFromId', _source, function(user)
				if user == nil then
					--TODO Temporary command Feeback	
					print("Admin command Feedback: this user doesnt exist")
				else
					user.removeGold(tonumber(count))
					print("Done remove gold to user: "..user.getName())
				end
			end)
		end
	end)
end)
	
AddEventHandler("xiv:RemoveSomeMoney", function(source, id, count, cb)
	print("[" .. GetInvokingResource() .. "] ^1" .. " called deprecated event `xiv:RemoveSomeMoney` please be sure to update to the standarized API introduced in v1.0.0")
	TriggerEvent("xiv:removeMoney", source, id, count, cb)
end)

AddEventHandler("xiv:removeMoney", function(source, id, count, cb)
	local _perm = tonumber(source)
		TriggerEvent('xiv:getPlayerFromId', _perm, function(pg)
		if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
			print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
		else
			local _source = tonumber(id)
			TriggerEvent('xiv:getPlayerFromId', _source, function(user)
				if user == nil then
					--TODO Temporary command Feeback	
					print("Admin command Feedback: this user doesnt exist")
				else
					user.removeMoney(tonumber(count))
					print("Done remove money to user: "..user.getName())
				end
			end)
		end
	end)
end)
	
AddEventHandler("xiv:AddSomeXP", function(source, id, count, cb)
	print("[" .. GetInvokingResource() .. "] ^1" .. " called deprecated event `xiv:AddSomeXP` please be sure to update to the standarized API introduced in v1.0.0")
	TriggerEvent("xiv:addXP", source, id, count, cb)
end)

AddEventHandler("xiv:addXP", function(source, id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('xiv:getPlayerFromId', _perm, function(pg)
		if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
			print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
		else
			local _source = tonumber(id)
			TriggerEvent('xiv:getPlayerFromId', _source, function(user)
				if user == nil then
					--TODO Temporary command Feeback	
					print("Admin command Feedback: this user doesnt exist")
				else
					user.addXP(tonumber(count))
					print("Done add XP to user: "..user.getName())
				end
			end)
		end
	end)
end)
	
AddEventHandler("xiv:SetSomeLevel", function(source, id, count, cb)
	print("[" .. GetInvokingResource() .. "] ^1" .. " called deprecated event `xiv:SetSomeLevel` please be sure to update to the standarized API introduced in v1.0.0")
	TriggerEvent("xiv:setLevel", source, id, count, cb)
end)

AddEventHandler("xiv:setLevel", function(source, id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('xiv:getPlayerFromId', _perm, function(pg)
		if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
			print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
		else
			local _source = tonumber(id)
			TriggerEvent('xiv:getPlayerFromId', _source, function(user)
				if user == nil then
					--TODO Temporary command Feeback	
					print("Admin command Feedback: this user doesnt exist")
				else
					user.setLevel(tonumber(count))
					print("Done set leveling to user: "..user.getName())
				end
			end)
		end
	end)
end)
	
AddEventHandler("xiv:SetSomeXP", function(source, id, count, cb)
	print("[" .. GetInvokingResource() .. "] ^1" .. " called deprecated event `xiv:SetSomeXP` please be sure to update to the standarized API introduced in v1.0.0")
	TriggerEvent("xiv:setXP", source, id, count, cb)
end)

AddEventHandler("xiv:setXP", function(source, id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('xiv:getPlayerFromId', _perm, function(pg)
		if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
			print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
		else
			local _source = tonumber(id)
			TriggerEvent('xiv:getPlayerFromId', _source, function(user)
				if user == nil then
					--TODO Temporary command Feeback	
					print("Admin command Feedback: this user doesnt exist")
				else
					user.setXP(tonumber(count))
					print("Done set XP to user: "..user.getName())
				end
			end)
		end
	end)
end)	
	
AddEventHandler("xiv:SetSomeGroup", function(source, id, count, cb)
	print("[" .. GetInvokingResource() .. "] ^1" .. " called deprecated event `xiv:SetSomeGroup` please be sure to update to the standarized API introduced in v1.0.0")
	TriggerEvent("xiv:setGroup", source, id, count, cb)
end)

AddEventHandler("xiv:setGroup", function(source, id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('xiv:getPlayerFromId', _perm, function(pg)
		if _perm ~= 0 and pg.getGroup() ~= 'superadmin' then
			print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN SUPER ADMIN COMMAND WITHOUT PERMISSION")
		else
			local _source = tonumber(id)
			TriggerEvent('redem:getPlayerFromId', _source, function(user)
				if user == nil then
					--TODO Temporary command Feeback	
					print("Admin command Feedback: this user doesnt exist")
				else
					user.setGroup(count)
					print("Done set group to user: "..user.getName() .." Group: "..user.getGroup())
				end
			end)
		end
	end)
end)