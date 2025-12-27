local QBCore = exports['qb-core']:GetCoreObject()
local isInMinigame = false

CreateThread(function()
    for _, model in pairs(Config.ATM_Models) do
        exports.ox_target:addModel(model, {
            {
                name = 'atm_robbery',
                label = 'ATM Soy',
                icon = 'fa-solid fa-sack-dollar',
                distance = 1.5,
                onSelect = function(data)
                    if not isInMinigame then
                        TriggerServerEvent('qb-atmminigame:server:canStart')
                    else
                        QBCore.Functions.Notify("Zaten bir soygun denemesi yapıyorsun!", "error")
                    end
                end
            }
        })
    end
end)

RegisterNetEvent("qb-atmminigame:client:Start", function()
    if isInMinigame then return end
    isInMinigame = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "open",
        config = {
            totalRounds = Config.ATMMinigame.TotalRounds,
            seqLen = Config.ATMMinigame.SequenceLength,
            startTimer = Config.ATMMinigame.StartTimer,
            stabilityMax = Config.ATMMinigame.StabilityMax,
            stabilityDrain = Config.ATMMinigame.StabilityDrainPerSec,
            correctGain = Config.ATMMinigame.CorrectGain,
            wrongPenalty = Config.ATMMinigame.WrongPenalty
        }
    })
    CreateThread(function()
        while isInMinigame do
            local controls = {1,2,24,25,257,140,141,142,143,21,22,44}
            for _, control in pairs(controls) do
                DisableControlAction(0, control, true)
            end
            Wait(0)
        end
    end)
end)

RegisterNUICallback("success", function(data, cb)
    isInMinigame = false
    SetNuiFocus(false, false)
    TriggerServerEvent("qb-atmminigame:server:reward")
    QBCore.Functions.Notify("ATM soygunu başarılı!", "success")
    cb("ok")
end)

RegisterNUICallback("fail", function(data, cb)
    isInMinigame = false
    SetNuiFocus(false, false)
    QBCore.Functions.Notify("ATM soygunu başarısız!", "error")
    cb("ok")
end)

RegisterNUICallback("close", function(data, cb)
    isInMinigame = false
    SetNuiFocus(false, false)
    cb("ok")
end)