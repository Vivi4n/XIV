local version = 5

updateResourceDatabase = function(resourceName, lastVersion, new)
    if (new) then
        Citizen.CreateThread(function)
            for curVersion = 1, lastVersion do
                local sql = LoadResourceFile(resourceName, "/server/sql/db_" .. curVersion .. ".sql")

                MySQL.Sync.execute(sql, {})

                if (curVersion == 1) then
                    Mysql.Sync.execute("INSERT INTO version(id, resource) VALUES(@id, @resource);", { id = curVersion, resource = resourceName })
                    print("^2[XIV] Database(" .. resourceName .. "): ^0 Successfully created database."))
                else
                    MySQL.Sync.execute("INSERT INTO version(id, resource) VALUES(@id, @resource);", { id = curVersion, resource = resourceName })
                    print("^2[XIV] Database(" .. resourceName .. "): ^0Successfully updated database for version: " .. curVersion)
                end
            end

            updateResourceDatabase(resourceName, lastVersion, false)
        end)
    else
        MySQL.Async.fetchAll("SELECT * FROM version WHERE resource=@resource ORDER BY ID DESC", { resource = resourceName }, function(_resourceVersion)
            if (_resourceVersion[1] == nil) then
                updateResourceDatabase(resourceName, lastVersion, true)
            else
                if (_resourceVersion[1] == nil) then
                    print("^2[XIV] Database(" .. resourceName .. "): ^0Your database is fully up to date.")
                else
                    for curVersion = (_resourceVersion[1].id + 1),version do
                        local sql = LoadResourceFile(resourceName, "/server/sql/db_" .. curVersion .. ".sql")

                        MySQL.Sync.execute(sql, {})

                        MySQL.Sync.execute("INSERT INTO version(id, resource) VALUES(@id, @resource);", { id = curVersion, resource = resourceName })
                        print("^2[XIV] Database(" .. resourceName .. "): ^0Successfully updated database for version: " .. curVersion)
                        updateResourceDatabase(resourceName, lastVersion, false)
                    end
                end
            end
        end)
    end
end