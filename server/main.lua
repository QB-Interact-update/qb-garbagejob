
local flags = {}
local Active = {}
local giveItemChance = 10
local itemsGiven = {
    'cryptostick',
    'tosti'
}
local function checkDistance(src, location, dist)
    local pcoords, coords = GetEntityCoords(GetPlayerPed(src)), vector3(location.x, location.y, location.z)
    if #(pcoords - coords) <= dist then
        return true
    else
        local Player = QBCore.Functions.GetPlayer(src)
        local ID = Player.PlayerData.citizenid
        if not flags[ID] then
            flags[ID] = 1
        else
            flags[ID] = flags[ID] + 1
        end
        if flags[ID] >= 5 then
            DropPlayer(src, Lang:t('error.Dropped'))
        end
        print('^1 [WARN] ' .. string.format(Lang:t('error.droppedWarn'), ID, flags[ID]) .. '^0')
        return false
    end
end
local function determineRoute(loc)
    local route = Config.Locations[loc].routes[math.random(1, #Config.Locations[loc].routes)]
    local routeFinal = {}
    for i = 1, #route do
        routeFinal[i] = {
            location = Config.Locations[loc].trashcan[route[i]].coords,
            bags = math.random(Config.MinBagsPerStop, Config.MaxBagsPerStop),
            collected = 0,
        }
    end
    return routeFinal
end

QBCore.Functions.CreateCallback('qb-garbagejob:server:start', function(source, cb, loc)
    local Player = QBCore.Functions.GetPlayer(source)
    if Active[Player.PlayerData.citizenid] then
        print('^1 [WARN] ' .. string.format(Lang:t('error.already_started'), Player.PlayerData.citizenid) .. '^0')
        cb(false)
        return
    end
    if Player.PlayerData.job.name ~= Config.Jobname then
        print('^1 [WARN] ' .. string.format(Lang:t('error.not_employee'), Player.PlayerData.citizenid) .. '^0')
        cb(false)
        return
    end
    if not checkDistance(source, Config.Locations[loc].ped.coords, 3.0) then
        cb(false)
        return
    end
    if Player.Functions.RemoveMoney('bank', Config.TruckPrice) or Player.Functions.RemoveMoney('cash', Config.TruckPrice) then
        local CID = Player.PlayerData.citizenid
        Active[CID] = {
            list = determineRoute(loc),
            current = 1,
        }
        cb(Active[CID].list[Active[CID].current])
        return
    else
        QBCore.Functions.Notify(source, string.format(Lang:t('Notify.too_poor'), Config.TruckPrice), 'error')
        cb(false)
        return
    end
end)

QBCore.Functions.CreateCallback('qb-garbagejob:server:nextStop', function(source, cb, data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CID = Player.PlayerData.citizenid
    if not Active[CID] then
        print('^1 [WARN] ' .. string.format(Lang:t('error.notActice'), CID) .. '^0')
        cb(false)
        return
    end
    if not checkDistance(src, Active[CID].list[Active[CID].current].location, 15.0) then
        cb(false)
        return
    end
    if Active[CID].list[Active[CID].current].collected < Active[CID].list[Active[CID].current].bags then
        print('^1 [WARN] ' .. string.format(Lang:t('error.notEnoughBags'), CID) .. '^0')
        cb(false)
        return
    end
    Active[CID].current = Active[CID].current + 1
    if Active[CID].current > #Active[CID].list then
        cb('Completed')
        Active[CID] = nil
        return
    else
        cb(Active[CID].list[Active[CID].current])
        return
    end
end)

RegisterNetEvent('qb-garbagejob:server:bagCollected', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CID = Player.PlayerData.citizenid
    if not Active[CID] then
        print('^1 [WARN] ' .. string.format(Lang:t('error.notActice'), CID) .. '^0')
        return
    end
    if not checkDistance(src, Active[CID].list[Active[CID].current].location, 35.0) then
        return
    end
    Active[CID].list[Active[CID].current].collected = Active[CID].list[Active[CID].current].collected + 1
    local itemChance = math.random(1, 100)
    if itemChance <= giveItemChance then
        local itemToGive = itemsGiven[math.random(1, #itemsGiven)]
        Player.Functions.AddItem(itemToGive, 1)
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[itemToGive], 'add')
        QBCore.Functions.Notify(src, string.format(Lang:t('Notify.foundItem'), QBCore.Shared.Items[itemToGive].label), 'success')
    end
end)

local function getBagCount(cid)
    if not Active[cid] then
        return 0
    end
    local count = 0
    for i = 1, #Active[cid].list do
        count = count + Active[cid].list[i].collected
    end
    return count
end

RegisterNetEvent('qb-garbagejob:server:finishJob', function(loc)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CID = Player.PlayerData.citizenid
    if not checkDistance(src, Config.Locations[loc].ped.coords, 10.0) then
        QBCore.Functions.Notify(src, Lang:t('error.too_far'), 'error')
        return
    end
    if not Active[CID] then
        QBCore.Functions.Notify(src, Lang:t('error.notActice'), 'error')
        return
    end
    local bagsCollected = getBagCount(CID)
    local price = 0
    for i = 1, bagsCollected do
        local bagWorth = math.random(Config.BagLowerWorth, Config.BagUpperWorth)
        price = price + bagWorth
    end
    Player.Functions.AddMoney('bank', price + Config.TruckPrice)
    Active[CID] = nil
end)