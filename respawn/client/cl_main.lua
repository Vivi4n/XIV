local newCharacter = false
local pressed = false
local code
local revived = false

RegisterCommand("kys", function(source, args, rawCommand)
    local _source = source
    if Config.kysCommand then
        local pl = PlayerPedId()
        local ped = GetPlayerPed(pl)

        ApplyDamageToPed(ped, 500000, false, true, true)
    end
end, false)

RegisterNetEvent("xiv_respawn:TransferCode")
AddEventHandler("xiv_respawn:TransferCode", function(c)
    if code == nil then
        code = c
    end
end)

RegisterNetEvent("xiv_respawn:gotRevive")
AddEventHandler("xiv_respawn:gotRevive", function(c)
    if c ~= code then return end
    DoScreenFadeOut(500)
    Wait(500)
    revived = true
    Wait(1000)
    RespawnCamera(GetEntityCoords(PlayerPedId()))
end)

RegisterCommand("revive", function(source, args, rawCommand)
    print(code)
    if args[1] ~= nil then
        TriggerServerEvent('xiv_respawn:revive', tonumber(args[1]), code)
    else
        TriggerServerEvent('xiv_respawn:revive', source, code)
    end
end, false)

RegisterNetEvent("xiv_respawn:killPlayer")
AddEventHandler("xiv_respawn:killPlayer", function(c)
    if c ~= code then return end
    local pl = Citizen.InvokeNative(0x217E9DC48139933D)
    local ped = GetPlayerPed(pl)
    ApplyDamageToPed(ped, 500000, false, true, true)
end)

local onPlayerDead = false
Citizen.CreateThread(function()
    while true do
        Wait(0)
        while IsPlayerDead(PlayerPedId()) and not revived do
            Wait(1)
            local timer = GetGameTimer() * Config.RespawnTime
            while timer >= GetGameTimer() and not revived do
                if revived == false then
                    if onPlayerDead == false then
                        DisplayHud(false)
                        DisplayRadar(false)
                        exports.spawnmanager:setAutoSpawn(false)
                        Citizen.InvokeNative(0xFA08722A5EA82DA7, "LensDistDrunk")
                        Citizen.InvokeNative(0xFDB74C9CC54C3F37, 1.0)
                        TriggerServerEvent('xiv_respawn:DeadTable', "add", code)
                        AnimpostfxPlay("DeathFailMP01")
                        StartDeathCam()
                        onPlayerDead = true
                    end
                    Wait(1)
                    ProcessCamControls()
                    DrawTxt(Config.LocaleTimer .. " " .. tonumber(string.format("%.0f", (((GetGameTimer() - timer * -1)/1000))), 0.50, 0.80, 0.7, 0.7, true, 255, 255, 255, 255, true))
end)