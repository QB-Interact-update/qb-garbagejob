local isDelivering, isCarrying = false, false
local veh = nil
local peds = {}
local Blips = {}
local collectedBags = 0
local truckZone = nil

local function spawnBlip(loc)
    Blips[#Blips+1] = AddBlipForCoord(Config.Locations[loc].main.coords.x, Config.Locations[loc].main.coords.y, Config.Locations[loc].main.coords.z)
    SetBlipSprite(Blips[#Blips], 318)
    SetBlipDisplay(Blips[#Blips], 4)
    SetBlipScale(Blips[#Blips], 0.8)
    SetBlipAsShortRange(Blips[#Blips], true)
    SetBlipColour(Blips[#Blips], 5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.Locations[loc].main.label)
    EndTextCommandSetBlipName(Blips[#Blips])
end

local function Delete()
    if DoesEntityExist(veh) then
        SetEntityAsMissionEntity(veh, true, true)
        DeleteVehicle(veh)
    end
    veh = nil
end

local function LoadAnimation(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

local function requestModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end
end

local function AnimCheck()
    CreateThread(function()
        local ped = PlayerPedId()
        while isCarrying and not IsEntityPlayingAnim(ped, 'missfbi4prepp1', '_bag_throw_garbage_man',3) do
            if not IsEntityPlayingAnim(ped, 'missfbi4prepp1', '_bag_walk_garbage_man', 3) then
                ClearPedTasksImmediately(ped)
                LoadAnimation('missfbi4prepp1')
                TaskPlayAnim(ped, 'missfbi4prepp1', '_bag_walk_garbage_man', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
            end
            Wait(1000)
        end
    end)
end

local function setStop(data)
    if not isDelivering then return end
    SetNewWaypoint(data.location.x, data.location.y)
    local options = {
        {
            icon = Lang:t('Target.disposeBagIcon'),
            label = Lang:t('Target.disposeBag'),
            action = function()
                if isCarrying then return end
                isCarrying = true
                LoadAnimation('missfbi4prepp1')
                TaskPlayAnim(PlayerPedId(), 'missfbi4prepp1', '_bag_walk_garbage_man', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
                requestModel('prop_cs_rub_binbag_01')
                garbageObject = CreateObject('prop_cs_rub_binbag_01', 0, 0, 0, true, true, true)
                AttachEntityToEntity(garbageObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.12, 0.0, -0.05, 220.0, 120.0, 0.0, true, true, false, true, 1, true)
                StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                AnimCheck()
                local returnOptions = {
                    {
                    label = Lang:t('Target.tossInTruck'),
                    icon = Lang:t('Target.disposeBagIcon'),
                    action = function()
                        isCarrying = false
                        collectedBags = collectedBags + 1
                        TriggerServerEvent('qb-garbagejob:server:bagCollected')
                        ClearPedTasksImmediately(PlayerPedId())
                        DeleteObject(garbageObject)
                        if collectedBags == data.bags then
                            if Config.UseTarget then
                                exports['qb-target']:RemoveZone("garbagebagzone")
                                exports['qb-target']:RemoveTargetEntity(veh, "Talk to NPC")
                            else
                                exports['qb-interact']:removeInteractZones("garbagebagzone")
                                exports['qb-interact']:removeInteractZones(veh)
                            end
                            truckZone = nil
                            collectedBags = 0
                            local newStop = QBCore.Functions.TriggerCallback('qb-garbagejob:server:nextStop', data)
                            if not newStop then
                                return
                            end
                            if newStop == 'Completed' then
                                QBCore.Functions.Notify(Lang:t('Notify.doneWorking'), 'success')
                                SetNewWaypoint(Config.Locations[data.locationIndex].main.coords.x, Config.Locations[data.locationIndex].main.coords.y)
                                isDelivering = false
                                return
                            end
                            setStop(newStop)
                            QBCore.Functions.Notify(Lang:t('Notify.nextStop'), 'success')
                        end
                    end,
                    canInteract = function()
                        return isCarrying
                    end,
                    }
                }
                if truckZone then return end
                truckZone = true
                if Config.UseTarget then
                    exports['qb-target']:AddEntityTarget(veh, {
                        options = returnOptions,
                        distance = 2.5
                    })
                else
                    exports['qb-interact']:addInteractZone({
                        name = veh,
                        coords = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, "boot")),
                        length = 6.0,
                        width = 3.0,
                        height = 5.0,
                        heading = GetEntityBoneRotation(veh, GetEntityBoneIndexByName(veh, "boot")).z,
                        debugPoly = false,
                        options = returnOptions,
                    })
                end

            end,
            canInteract = function()
                if isCarrying then
                    return false
                end
                return true
            end,
        },
    }
    if Config.UseTarget then
        exports['qb-target']:AddBoxZone("garbagebagzone", data.location, 2.0, 2.0, {
            name="garbagebagzone",
            heading=0,
            debugPoly=false,
            minZ=data.location.z - 1,
            maxZ=data.location.z + 1,
        }, {
            options = options,
            distance = 2.5
        })
    else
        exports['qb-interact']:addInteractZone({
            name="garbagebagzone",
            coords=data.location,
            heading=0,
            debugPoly = false,
            minZ=data.location.z - 1,
            maxZ=data.location.z + 1,
            options = options,
        })
    end
end
local function openMenu(loc)
    local menu = {
        {
            isMenuHeader=true,
            header = Lang:t('Menu.header'),

        },
        {
            header = Lang:t('Menu.collect'),
            txt = Lang:t('Menu.collectText'),
            action = function()
                if veh then
                    TriggerServerEvent('qb-garbagejob:server:finishJob', loc)
                    if Config.UseTarget then
                        exports['qb-target']:RemoveZone("garbagebagzone")
                        exports['qb-target']:RemoveTargetEntity(veh)
                    else
                        exports['qb-interact']:removeInteractZones("garbagebagzone")
                        exports['qb-interact']:removeInteractZones(veh)
                    end
                    truckZone = nil
                    Delete(veh)
                    veh = false
                    isDelivering = false
                    QBCore.Functions.Notify(Lang:t('Notify.truckReturned'), 'success')
                    return
                end
            end
        },
    }
    if not veh then
        menu[#menu + 1] = {
            header = Lang:t('Menu.startJob'),
            txt = Lang:t('Menu.startJobText'),
            action = function()
                local jobData = QBCore.Functions.TriggerCallback('qb-garbagejob:server:start', loc)
                if not jobData then
                    return
                end
                isDelivering = true
                QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(netId)
                    veh = NetToVeh(netId)
                    SetVehicleEngineOn(veh, false, true)
                    SetVehicleNumberPlateText(veh, "QB-" .. tostring(math.random(1000, 9999)))
                    SetEntityHeading(veh, Config.Locations[loc].vehicle.coords[1].w)
                    exports['LegacyFuel']:SetFuel(veh, 100.0)
                    SetVehicleFixed(veh)
                    SetEntityAsMissionEntity(veh, true, true)
                    SetVehicleDoorsLocked(veh, 1)
                    TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                end, Config.Vehicle,Config.Locations[loc].vehicle.coords[1] , false)
                setStop(jobData)
                QBCore.Functions.Notify(Lang:t('Notify.nextStop'), 'success')
            end
        }
    end
    exports['qb-menu']:openMenu(menu)
end

CreateThread(function()
    for i = 1, #Config.Locations do
        RequestModel(GetHashKey(Config.Locations[i].ped.model))
        while not HasModelLoaded(GetHashKey(Config.Locations[i].ped.model)) do
            Wait(1)
        end
        peds[i] = CreatePed(0, GetHashKey(Config.Locations[i].ped.model), Config.Locations[i].ped.coords.x, Config.Locations[i].ped.coords.y, Config.Locations[i].ped.coords.z, Config.Locations[i].ped.coords.w, false, true)
        SetBlockingOfNonTemporaryEvents(peds[i], true)
        SetEntityInvincible(peds[i], true)
        FreezeEntityPosition(peds[i], true)
        local options = {
            {
                icon = Lang:t('Target.talkIcon'),
                label = Lang:t('Target.talk'),
                action = function()
                    openMenu(i)
                end,
                canInteract = function()
                    return QBCore.Functions.GetPlayerData().job.name == "garbage"
                end,
            },
        }
        if Config.UseTarget then
            exports['qb-target']:AddTargetEntity(peds[i], {
                options = options,
                distance = 2.5,
            })
        else
            exports['qb-interact']:addEntityZone(peds[i], {
                length = 3.0,
                width = 2.0,
                debugPoly = false,
                options = options,
            })
        end
    end
    if QBCore.Functions.GetPlayerData().job.name == Config.Jobname then
        for i = 1, #Config.Locations do
            spawnBlip(i)
        end
    end
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(data)
    if data.name ~= Config.Jobname then
        for i = 1, #Blips do
            RemoveBlip(Blips[i])
        end
        Blips = {}
    else
        for i = 1, #Config.Locations do
            spawnBlip(i)
        end
    end
end)