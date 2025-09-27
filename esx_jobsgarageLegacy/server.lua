ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('garage:trySpawnVehicle')
AddEventHandler('garage:trySpawnVehicle', function(jobName, vehicleData)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local playerJob = xPlayer.job

    if playerJob.name ~= jobName then
        TriggerClientEvent('garage:spawnResult', src, false, "🚫 Não tens permissão para este veículo.")
        return
    end

    if not Config.Garages[jobName] or not Config.Garages[jobName][vehicleData.type] then
        TriggerClientEvent('garage:spawnResult', src, false, "Erro na configuração da garagem.")
        return
    end

    for _, garage in ipairs(Config.Garages[jobName][vehicleData.type]) do
        for _, v in ipairs(garage.vehicles) do
            if v.model == vehicleData.model then
                local minGrade = v.minGrade or 0
                if playerJob.grade < minGrade then
                    TriggerClientEvent('garage:spawnResult', src, false, "🚫 Não tens autorização para este veículo.")
                    return
                end

                -- manda todos os spawns possíveis para o client decidir o livre
                local spawns = garage.spawns or {garage.spawn}
                vehicleData.spawns = spawns

                TriggerClientEvent('garage:spawnVehicleClient', src, vehicleData)
                TriggerClientEvent('garage:spawnResult', src, true, "✅ Veículo spawnado!")
                return
            end
        end
    end

    TriggerClientEvent('garage:spawnResult', src, false, "🚫 Veículo não encontrado.")
end)

-- Devolver veículo
RegisterServerEvent('garage:returnVehicle')
AddEventHandler('garage:returnVehicle', function(jobName, vehicleType, garage)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.job.name ~= jobName then
        return
    end
    TriggerClientEvent('garage:returnVehicleClient', src, vehicleType, garage)
end)
