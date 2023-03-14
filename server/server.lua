local QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('QBCore:Server:UpdateObject', function() if source ~= '' then return false end QBCore = exports['qb-core']:GetCoreObject() end)



RegisterServerEvent("arp-scrapyard:getrecyclablematerial", function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src) 
	local paymentTrue = math.random(Config.MinPay, Config.MaxPay)
	payment = paymentTrue
	for _ = 1, math.random(1, Config.MaxItemsReceived), 1 do
		local randItem = Config.ItemTable[math.random(1, #Config.ItemTable)]
		local amount = math.random(Config.MinItemReceivedQty, Config.MaxItemReceivedQty)
		Player.Functions.AddItem(randItem, amount)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randItem], 'add')
		Wait(500)
	  end
	Player.Functions.AddMoney("bank", payment, "Salvage-Yard")
	TriggerClientEvent("QBCore:Notify", src, Loc[Config.Lan].success["get_paid"]..payment, "success")
	exports["qb_gamepass"]:AddPlayerXp(Player.PlayerData.source, 15)
	Wait(500)
	

	local brakeschance = math.random(100)
	if brakeschance <= Config.BonusBrakesChance then
	  Player.Functions.AddItem(Config.BonusBrakes, 1, false)
	  TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.BonusBrakes], 'add')
	end

	local enginechance = math.random(100)
	if enginechance <= Config.BonusEngineChance then
	  Player.Functions.AddItem(Config.BonusEngine, 1, false)
	  TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.BonusEngine], 'add')
	end

	local transmissionchance = math.random(100)
	if transmissionchance <= Config.BonusTransChance then
	  Player.Functions.AddItem(Config.BonusTransmission, 1, false)
	  TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.BonusTransmission], 'add')
	end

	local hoodchance = math.random(100)
	if hoodchance <= Config.BonusCosmeticChance then
	  Player.Functions.AddItem(Config.BonusCosmetic, 1, false)
	  TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.BonusCosmetic], 'add')
	end
  end)
