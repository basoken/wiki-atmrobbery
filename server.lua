local QBCore = exports['qb-core']:GetCoreObject()
local cooldowns = {}

RegisterNetEvent('qb-atmminigame:server:canStart', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local now = os.time()
    if cooldowns[src] and now - cooldowns[src] < Config.Cooldown then
        local remaining = Config.Cooldown - (now - cooldowns[src])
        local minutes = math.floor(remaining / 60)
        local seconds = remaining % 60
        TriggerClientEvent("QBCore:Notify", src, ("Yeni bir ATM soygunu için %s dakika %s saniye bekle!"):format(minutes, seconds), "error")
        return
    end
    cooldowns[src] = now
    TriggerClientEvent('qb-atmminigame:client:Start', src)
end)

RegisterNetEvent("qb-atmminigame:server:reward", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local rewardMoney = math.random(Config.MinReward, Config.MaxReward)
    Player.Functions.AddMoney("cash", rewardMoney, "atm-robbery")
    TriggerClientEvent("QBCore:Notify", src, ("ATM'den $%s çaldın!"):format(rewardMoney), "success")
end)

AddEventHandler('playerDropped', function()
    local src = source
    cooldowns[src] = nil
end)
