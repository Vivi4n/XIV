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