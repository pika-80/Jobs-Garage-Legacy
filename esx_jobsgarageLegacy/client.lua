ESX = nil
local jobBlips = {}
local currentJobGarages = {}
local garagePeds = {}

-- Inicializa ESX
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

-- Evento spawn de veículo do servidor
-- Evento spawn de veículo do servidor
RegisterNetEvent('garage:spawnVehicleClient')
AddEventHandler('garage:spawnVehicleClient', function(vehicleData)
    local model = GetHashKey(vehicleData.model)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(10) end

    -- verificar spawn livre (se tiver vários no config)
    local chosenSpawn = nil
    if vehicleData.spawns then
        for _, spawn in ipairs(vehicleData.spawns) do
            local spawnCoords = vector3(spawn.x, spawn.y, spawn.z)
            if IsSpawnPointClear(spawnCoords, 2.5) then -- raio menor para evitar falso ocupado
                chosenSpawn = spawn
                break
            end
        end
    elseif vehicleData.spawn then
        -- fallback caso seja só 1 spawn
        local spawnCoords = vector3(vehicleData.spawn.x, vehicleData.spawn.y, vehicleData.spawn.z)
        if IsSpawnPointClear(spawnCoords, 2.5) then
            chosenSpawn = vehicleData.spawn
        end
    end

    if not chosenSpawn then
        lib.notify({
            title = "Garagem",
            description = "🚫 Nenhum local de spawn livre!",
            type = "error"
        })
        return
    end

    -- criar veículo
    local veh = CreateVehicle(model, chosenSpawn.x, chosenSpawn.y, chosenSpawn.z, chosenSpawn.w, true, false)
    SetVehicleOnGroundProperly(veh)
    SetPedIntoVehicle(PlayerPedId(), veh, -1)
    SetEntityAsMissionEntity(veh, true, true)
    SetVehicleFuelLevel(veh, 100.0)
    SetModelAsNoLongerNeeded(model)

end)

-- função para verificar se local está livre
function IsSpawnPointClear(coords, radius)
    local vehicles = GetGamePool('CVehicle')
    for _, veh in ipairs(vehicles) do
        if #(coords - GetEntityCoords(veh)) < radius then
            return false
        end
    end
    return true
end



-- Evento resultado do spawn (erro/sucesso)
RegisterNetEvent('garage:spawnResult')
AddEventHandler('garage:spawnResult', function(success, msg)
    exports['okokNotify']:Alert("Garagem", msg, 3000, success and 'success' or 'error')
end)

-- Evento devolver veículo do servidor
RegisterNetEvent('garage:returnVehicleClient')
AddEventHandler('garage:returnVehicleClient', function(vehicleType, garage)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    if vehicle ~= 0 then
        DeleteVehicle(vehicle)
        exports['okokNotify']:Alert("Garagem", "Veículo devolvido!", 3000, 'success')

        if vehicleType == "boats" and garage.returnPlayer then
            SetEntityCoords(ped, garage.returnPlayer.x, garage.returnPlayer.y, garage.returnPlayer.z)
            SetEntityHeading(ped, garage.returnPlayer.w or 0.0)
            exports['okokNotify']:Alert("Transporte", "Você foi transportado para o cais!", 3000, 'info')
        end
    else
        exports['okokNotify']:Alert("Garagem", "Nenhum veículo por perto!", 3000, 'error')
    end
end)

-- Menu spawn de veículos (ox_lib)
function OpenSpawnMenu(garage, vehicleType)
    local playerJob = ESX.GetPlayerData().job
    local options = {}

    for _, v in ipairs(garage.vehicles) do
        local allowed = true
        if v.minGrade and playerJob.grade < v.minGrade then
            allowed = false
        end

        local emoji = (vehicleType=='cars' and '🚙 ') or (vehicleType=='boats' and '🚤 ') or '🚁 '
        local label = allowed and v.label or (v.label .. " (Sem autorização)")
        table.insert(options, {
            title = emoji .. label,
            description = "Modelo: " .. v.model,
            onSelect = function()
                if not allowed then
                    exports['okokNotify']:Alert("Garagem", "🚫 Não tens autorização para este veículo!", 3000, 'error')
                    return
                end
                v.type = vehicleType
                TriggerServerEvent('garage:trySpawnVehicle', garage.job, v)
            end
        })
    end

    lib.registerContext({
        id = 'garage_spawn_menu',
        title = garage.label,
        options = options
    })
    lib.showContext('garage_spawn_menu')
end

-- Menu devolver veículo
function OpenReturnMenu(garage, vehicleType)
    TriggerServerEvent("garage:returnVehicle", garage.job, vehicleType, garage)
end

-- Reparar veículo (carros e barcos)
function RepairVehicle()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    if vehicle == 0 then
        exports['okokNotify']:Alert("Garagem", "🚫 Não estás dentro de um veículo!", 3000, 'error')
        return
    end
    SetVehicleFixed(vehicle)
    SetVehicleDeformationFixed(vehicle)
    SetVehicleUndriveable(vehicle, false)
    SetVehicleEngineOn(vehicle, true, true, true)
    SetVehicleFuelLevel(vehicle, 100.0) -- tanque cheio
    exports['okokNotify']:Alert("Garagem", "✅ Veículo reparado e abastecido!", 3000, 'success')
end

-- Criar peds com ox_target
function CreateGaragePeds(jobName)
    -- remover peds antigos
    for _, ped in ipairs(garagePeds) do
        if DoesEntityExist(ped) then DeleteEntity(ped) end
    end
    garagePeds = {}

    if not Config.Garages[jobName] then return end

    for vehicleType, garages in pairs(Config.Garages[jobName]) do
        for _, garage in ipairs(garages) do
            if garage.ped then
                local model = joaat(garage.ped.model)
                RequestModel(model)
                while not HasModelLoaded(model) do Wait(10) end

                local ped = CreatePed(4, model, garage.ped.coords.x, garage.ped.coords.y, garage.ped.coords.z, garage.ped.coords.w, false, true)
                SetEntityInvincible(ped, true)
                SetBlockingOfNonTemporaryEvents(ped, true)
                FreezeEntityPosition(ped, true)

                exports.ox_target:addLocalEntity(ped, {
                    {
                        name = 'garage_spawn_'..garage.label,
                        label = "🚙 Retirar veículo",
                        icon = "fa-solid fa-car",
                        onSelect = function() OpenSpawnMenu(garage, vehicleType) end
                    }
                })

                table.insert(garagePeds, ped)
            end
        end
    end
end

-- Thread de marcadores para devolver/reparar
-- Thread de marcadores para devolver/reparar
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        local playerCoords = GetEntityCoords(ped)

        for _, data in ipairs(currentJobGarages) do
            local garage = data.garage
            local vehicleType = data.type

            -- Marcador de devolver/reparar (funciona para carros, helis e barcos)
            if garage.returnCoords then
                local distReturn = #(playerCoords - garage.returnCoords)
                if distReturn < garage.markerSize then
                    DrawMarker(
                        1,
                        garage.returnCoords.x, garage.returnCoords.y, garage.returnCoords.z - 1.0,
                        0,0,0,0,0,0,
                        garage.markerSize, garage.markerSize, 1.0,
                        255,0,0,      -- 🔴 vermelho
                        100,false,true,2,nil,nil,false
                    )

                    if distReturn < 2.0 then
                        ESX.ShowHelpNotification("Pressione ~INPUT_CONTEXT~ para devolver/reparar veículo")
                        if IsControlJustReleased(0,38) then
                            lib.registerContext({
                                id = 'return_menu',
                                title = "⚙ Opções do Veículo",
                                options = {
                                    { title = "🛑 Devolver", onSelect = function() OpenReturnMenu(garage, vehicleType) end },
                                    { title = "🛠 Reparar", onSelect = function() RepairVehicle() end },
                                }
                            })
                            lib.showContext('return_menu')
                        end
                    end
                end
            end
        end
    end
end)


-- Criação de blips
function CreateJobBlips(jobName)
    for _, blip in pairs(jobBlips) do RemoveBlip(blip) end
    jobBlips = {}
    if Config.Garages[jobName] then
        for vehicleType, garages in pairs(Config.Garages[jobName]) do
            for _, garage in ipairs(garages) do
                local blip = AddBlipForCoord(garage.coords.x, garage.coords.y, garage.coords.z)
                SetBlipSprite(blip, (vehicleType=="cars" and 225) or (vehicleType=="boats" and 410) or (vehicleType=="heli" and 43) or 1)
                SetBlipDisplay(blip, 4)
                SetBlipScale(blip, 0.7)
                SetBlipColour(blip, (vehicleType=="cars" and 3) or (vehicleType=="boats" and 5) or (vehicleType=="heli" and 1) or 0)
                SetBlipAsShortRange(blip,true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(garage.label)
                EndTextCommandSetBlipName(blip)
                table.insert(jobBlips, blip)
            end
        end
    end
end

-- Inicialização
Citizen.CreateThread(function()
    while ESX==nil do Citizen.Wait(10) end
    while ESX.GetPlayerData().job==nil do Citizen.Wait(10) end
    local job = ESX.GetPlayerData().job.name
    CreateJobBlips(job)
    UpdateJobGarages(job)
    CreateGaragePeds(job)
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    CreateJobBlips(job.name)
    UpdateJobGarages(job.name)
    CreateGaragePeds(job.name)
end)

-- Atualiza garages do job
function UpdateJobGarages(jobName)
    currentJobGarages = {}
    if Config.Garages[jobName] then
        for vehicleType, garages in pairs(Config.Garages[jobName]) do
            for _, garage in ipairs(garages) do
                table.insert(currentJobGarages, {garage = garage, type = vehicleType})
            end
        end
    end
end
