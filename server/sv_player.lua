function CreateRoleplayPlayer(source, identifier, name, money, gold, license, group, firstname, lastname, xp, level, job, jobgrade)
	local pl = {}
	pl.__index = pl

	pl.source = source
	pl.gold = gold
	pl.group = group
	pl.fristname = firstname
	pl.lastname = lastname
	pl.xp = xp
	pl.level = level
	pl.job = job
	pl.jobgrade = jobgrade

	local rTable = {}
	rTable.setLevelwXP = function(m)
		if type(m) == "number" then
			if m > pl.level then
				pl.level = m
				TriggerClientEvent('xiv:addLevel', pl.source, m)
				TriggerClientEvent('xiv:activateLevel', pl.source, pl.level)
			else
				pl.level = m
				TriggerClientEvent('xiv:removeLevel', pl.source, m)
				TriggerClientEvent('xiv:activateLevel', pl.source, pl.level)
			end
		else
			print("XIV Error: There's an issue whilst setting level, something different than a number was entered.")
		end
	end