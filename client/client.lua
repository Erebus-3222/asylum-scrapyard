local QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('QBCore:Client:UpdateObject', function() QBCore = exports['qb-core']:GetCoreObject() end)

PlayerJob = {}
onDuty = false
Peds = {}
Targets = {}
scrapProps = {}
Props = {}
local CrusherProp = nil

scrapPool = {
	--{ model = ``, xPos = , yPos = , zPos = , xRot = , yRot = , zRot = },
	--{ model = `sf_prop_sf_art_box_cig_01a`, xPos = 0.16, yPos = -0.06, zPos = 0.21, xRot = 52.0, yRot = 288.0, zRot = 175.0},
	{ model = `prop_car_door_01`, xPos = 0.08, yPos = 0.05, zPos = 0.06, xRot = 7.0, yRot = 0.0, zRot = 0.0},
	{ model = `prop_car_engine_01`, xPos = 0.0, yPos = 0.28, zPos = 0.0, xRot = 136.0, yRot = 114.0, zRot = 181.0},
	{ model = `prop_car_seat`, xPos = -0.08, yPos = 0.04, zPos = 0.32, xRot = 76.0, yRot = 110.0, zRot = 185.0},
	{ model = `prop_rub_scrap_06`, xPos = 0.01, yPos = 0.02, zPos = 0.27, xRot = 85.0, yRot = 371.0, zRot = 177.0 },
	{ model = `prop_cs_cardbox_01`, xPos = 0.04, yPos = 0.04, zPos = 0.28, xRot = 52.0, yRot = 294.0, zRot = 177.0 },
	{ model = `v_ind_cs_toolbox2`, xPos = 0.04, yPos = 0.12, zPos = 0.29, xRot = 56.0, yRot = 287.0, zRot = 169.0 },
}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	QBCore.Functions.GetPlayerData(function(PlayerData) PlayerJob = PlayerData.job if PlayerData.job.name == Config.JobRole then onDuty = PlayerJob.onduty end end)
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty) if Config.JobRole then if PlayerJob.name == Config.JobRole then onDuty = duty end end end)

AddEventHandler('onResourceStart', function(resource) if GetCurrentResourceName() ~= resource then return end
	QBCore.Functions.GetPlayerData(function(PlayerData) PlayerJob = PlayerData.job if PlayerData.job.name == Config.JobRole then onDuty = PlayerJob.onduty end end)
end)

--- Blips + Peds
CreateThread(function()
	JobLocation = PolyZone:Create({
		vector2(-420.78, -1752.52),
		vector2(-388.15, -1678.5),
		vector2(-544.81, -1599.95),
		vector2(-595.11, -1578.4),
		vector2(-663.94, -1647.68),
		vector2(-599.95, -1706.9),
		vector2(-496.93, -1777.67),
	},
	{ name = "Scrapyard", debugPoly = Config.Debug })
	JobLocation:onPlayerInOut(function(isPointInside)
		if not isPointInside then
			EndJob() ClearProps()
			if Config.Debug then print("^5Debug^7: ^3PolyZone^7: ^2Leaving Area^7. ^2Clocking out and cleaning up^7") end
			if Config.JobRole then
				if onDuty then TriggerServerEvent("QBCore:ToggleDuty") end
			elseif onDuty == true then
				onDuty = false
			end
		else MakeProps()
		end
	end)
	for _, v in pairs(Config.Locations) do
		for i = 1, #v do
			local v = v[i]
			if Config.Blips and v.blipTrue then blip = makeBlip({coords = v.coords, sprite = v.sprite, col = v.col, name = v.name})	end
		end
	end



	Targets["ScrapyardDuty"] =
		exports['qb-target']:AddCircleZone("ScrapyardDuty", vector3(-498.89, -1713.84, 19.9), 1.0, { name="ScrapyardDuty", debugPoly=Config.Debug, useZ=true, },
			{ options = { { event = "arp-scrapyard:dutytoggle", icon = "fas fa-hard-hat", label = Loc[Config.Lan].target["duty"], job = Config.JobRole }, },
			distance = 1.5 })
end)
---- Render Props -------
function MakeProps()
	--Scrapyard Props
	if Config.Debug then print("^5Debug^7: ^3MakeProps^7() ^2Spawning props") end
	scrapProps[#scrapProps+1] = makeProp({prop = `prop_rub_carwreck_10`,		coords = vector4(-523.76, -1681.52, 18.23, 344.66)}, 1, 0)
	scrapProps[#scrapProps+1] = makeProp({prop = `prop_rub_carwreck_13`,		coords = vector4(-541.28, -1681.96, 18.34, 119.36)}, 1, 0)
	scrapProps[#scrapProps+1] = makeProp({prop = `prop_rub_carwreck_2`,			coords = vector4(-557.13, -1665.78, 18.27, 67.95)}, 1, 0)
	scrapProps[#scrapProps+1] = makeProp({prop = `prop_wrecked_buzzard`,			coords = vector4(-549.1, -1640.32, 18.01, 358.63)}, 1, 0)
	scrapProps[#scrapProps+1] = makeProp({prop = `prop_rub_carwreck_8`,			coords = vector4(-570.05, -1639.8, 18.4, 9.65)}, 1, 0)
	scrapProps[#scrapProps+1] = makeProp({prop = `prop_rub_carwreck_7`,			coords = vector4(-524.08, -1721.3, 18.18, 302.48)}, 1, 0)
	scrapProps[#scrapProps+1] = makeProp({prop = `prop_rub_carwreck_11`,			coords = vector4(-528.75, -1709.1, 18.32, 195.59)}, 1, 0)
	scrapProps[#scrapProps+1] = makeProp({prop = `prop_rub_trukwreck_1`,		coords = vector4(-515.39, -1732.51, 18.27, 84.34)}, 1, 0)
	scrapProps[#scrapProps+1] = makeProp({prop = `prop_rub_buswreck_06`,		coords = vector4(-553.05, -1701.01, 18.1, 206.26)}, 1, 0)
	scrapProps[#scrapProps+1] = makeProp({prop = `prop_rub_t34`,		coords = vector4(-562.82, -1685.94, 18.27, 87.57)}, 1, 0)
	scrapProps[#scrapProps+1] = makeProp({prop = `prop_rub_wreckage_3`,		coords = vector4(-579.1, -1669.7, 18.26, 25.92)}, 1, 0)
	scrapProps[#scrapProps+1] = makeProp({prop = `prop_rub_wreckage_9`,		coords = vector4(-560.63, -1658.75, 18.17, 124.68)}, 1, 0)
	scrapProps[#scrapProps+1] = makeProp({prop = `prop_rub_trukwreck_1`,		coords = vector4(-460.52, -1710.64, 17.71, 350.84)}, 1, 0)
	scrapProps[#scrapProps+1] = makeProp({prop = `prop_rub_buswreck_03`,	coords = vector4(-475.06, -1707.88, 17.7, 62.61)}, 1, 0)
	scrapProps[#scrapProps+1] = makeProp({prop = `prop_rub_railwreck_1`,		coords = vector4(-454.95, -1720.97, 17.7, 63.86)}, 1, 0)
	scrapProps[#scrapProps+1] = makeProp({prop = `prop_rub_frklft`,			coords = vector4(-453.2, -1735.08, 15.76, 307.03)}, 1, 0)
	scrapProps[#scrapProps+1] = makeProp({prop = `prop_dock_crane_04`,		coords = vector4(-485.54, -1756.98, 16.75, 178.78)}, 1, 0)
	scrapProps[#scrapProps+1] = makeProp({prop = `prop_rub_carwreck_13`,		coords = vector4(-492.98, -1747.05, 20.74, 150.93)}, 1, 0)
	scrapProps[#scrapProps+1] = makeProp({prop = `prop_rub_carwreck_9`,		coords = vector4(-497.48, -1728.98, 20.62, 203.92)}, 1, 0)
	scrapProps[#scrapProps+1] = makeProp({prop = `prop_rub_trukwreck_1`,		coords = vector4(-463.99, -1722.21, 17.62, 51.61)}, 1, 0)
	scrapProps[#scrapProps+1] = makeProp({prop = `prop_byard_machine03`,			coords = vector4(-506.44, -1750.85, 17.41, 265.97)}, 1, 0)

	for k in pairs(scrapPool) do loadModel(scrapPool[k].model) end
end
function EndJob()
	if Targets["Package"] then exports["qb-target"]:RemoveTargetEntity(randPackage) end
	destroyProp(CrusherProp) CrusherProp = nil
	for i = 1, #scrapProps do SetEntityDrawOutline(scrapProps[i], false) end
	randPackage = nil
	if trashProp then
		destroyProp(trashProp)
		trashProp = nil
	end
end

function ClearProps()
	if Config.Debug then print("^5Debug^7: ^3ClearProps^7() ^2Exiting building^7, ^2clearing previous props ^7(^2if any^7)") end
	for _, v in pairs(scrapProps) do unloadModel(GetEntityModel(v)) DeleteObject(v) end scrapProps = {}
	for _, v in pairs(Props) do unloadModel(GetEntityModel(v)) DeleteObject(v) end Props = {}
	for k in pairs(scrapPool) do unloadModel(scrapPool[k].model) end
	if Targets["DropOff"] then exports["qb-target"]:RemoveTargetEntity(CrusherProp) end
	unloadModel(GetEntityModel(CrusherProp)) DeleteObject(CrusherProp)
end

--Pick one of the crates for the player to choose, generate outline + target
function PickRandomPackage()
	if not CrusherProp then
		loadModel(`prop_ind_crusher`)
		CrusherProp = CreateObject(`prop_ind_crusher`, -515.78, -1702.66, 18.32, 0, 0, 0) FreezeEntityPosition(CrusherProp, true) SetEntityHeading(CrusherProp, 210.62)
	end
	--If somehow already exists, remove target
	if Targets["Package"] then exports["qb-target"]:RemoveTargetEntity(randPackage, "Search") end
	--Pick random prop to use
	randPackage = scrapProps[math.random(1, #scrapProps)]
	SetEntityDrawOutline(randPackage, true)
	SetEntityDrawOutlineColor(11, 235, 172, 0.8)
	SetEntityDrawOutlineShader(1)
	--Generate Target Location on the selected package
	Targets["Package"] =
		exports['qb-target']:AddTargetEntity(randPackage,
			{ options = { { event = "arp-scrapyard:PickupPackage:Start", icon = 'fas fa-magnifying-glass', label = Loc[Config.Lan].target["search"], } },
			distance = 2.5,	})
end
--Event to enter and exit warehouse

RegisterNetEvent("arp-scrapyard:PickupPackage:Start", function()
	TaskStartScenarioInPlace(PlayerPedId(), "CODE_HUMAN_MEDIC_KNEEL", 0, true)
	QBCore.Functions.Progressbar("open_locker_drill", Loc[Config.Lan].progressbar["search"], 5000, false, true, {
		disableMovement = true,	disableCarMovement = true, disableMouse = false, disableCombat = true, }, {}, {}, {}, function() -- Done
		ClearPedTasksImmediately(PlayerPedId())
		TriggerEvent("arp-scrapyard:PickupPackage:Hold")
	end, function() -- Cancel
	end, "fas fa-magnifying-glass")
end)
RegisterNetEvent("arp-scrapyard:PickupPackage:Hold", function()
	--Clear current target info
	exports["qb-target"]:RemoveTargetEntity(randPackage, "Search")
	SetEntityDrawOutline(randPackage, false)
	randPackage = nil

	--Make prop to put in hands
	loadAnimDict("anim@heists@box_carry@")
    TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@" ,"idle", 5.0, -1, -1, 50, 0, false, false, false)
	v = scrapPool[math.random(1, #scrapPool)]
    loadModel(v.model)
    trashProp = CreateObject(v.model, GetEntityCoords(PlayerPedId(), true), true, true, true)
    AttachEntityToEntity(trashProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), v.xPos, v.yPos, v.zPos, v.xRot, v.yRot, v.zRot, 20.0, true, true, false, true, 1, true)
	--Create target for drop off location
	SetEntityDrawOutline(CrusherProp, true)
	SetEntityDrawOutlineColor(11, 235, 172, 0.8)
	SetEntityDrawOutlineShader(1)
	Targets["DropOff"] =
		exports['qb-target']:AddTargetEntity(CrusherProp,
		{ options = { { event = "arp-scrapyard:PickupPackage:Finish", icon = 'fas fa-recycle', label = Loc[Config.Lan].target["drop_off"], } },
		distance = 2.5,	})

end)

RegisterNetEvent("arp-scrapyard:PickupPackage:Finish", function()
	--Once this is triggered it can't be stopped, so remove the target and prop
	if Targets["DropOff"] then exports["qb-target"]:RemoveTargetEntity(CrusherProp, "Drop Off") Targets["DropOff"] = nil end
	SetEntityDrawOutline(CrusherProp, false) destroyProp(CrusherProp) CrusherProp = nil
	--Remove target and the whole prop, seen as how no ones qb-target works and its my fault 😊
	CrusherProp = CreateObject(`prop_ind_crusher`, -515.78, -1702.66, 18.32, 0, 0, 0) FreezeEntityPosition(CrusherProp, true) SetEntityHeading(CrusherProp, 210.62)

	--Load and Start animation
	local dict = "mp_car_bomb" loadAnimDict("mp_car_bomb")
	local anim = "car_bomb_mechanic"
    local isScrapping = true
	FreezeEntityPosition(PlayerPedId(), true)
	Wait(100)
	TaskPlayAnim(PlayerPedId(), dict, anim, 3.0, 3.0, -1, 2.0, 0, 0, 0, 0)
	Wait(3000)
	--When animation is complete
	--Empty hands
	destroyProp(trashProp)
    trashProp = nil
	ClearPedTasks(PlayerPedId())
	FreezeEntityPosition(PlayerPedId(), false)
	TriggerServerEvent('arp-scrapyard:getrecyclablematerial') -- Give rewards
	PickRandomPackage()
end)

RegisterNetEvent('arp-scrapyard:dutytoggle', function()
	if Config.JobRole then
		if onDuty then EndJob() else PickRandomPackage() end
		TriggerServerEvent("QBCore:ToggleDuty")
	else
		onDuty = not onDuty
		if onDuty then TriggerEvent('QBCore:Notify', Loc[Config.Lan].success["on_duty"], 'success') PickRandomPackage()
		else TriggerEvent('QBCore:Notify', Loc[Config.Lan].error["off_duty"], 'error') EndJob() end
	end
end)


AddEventHandler('onResourceStop', function(resource) if resource ~= GetCurrentResourceName() then return end
	for k in pairs(Targets) do exports['qb-target']:RemoveZone(k) end
	for _, v in pairs(Peds) do unloadModel(GetEntityModel(v)) DeletePed(v) end
	for _, v in pairs(Props) do unloadModel(GetEntityModel(v)) DeleteObject(v) end
	for _, v in pairs(scrapProps) do unloadModel(GetEntityModel(v)) DeleteObject(v) end
	unloadModel(GetEntityModel(CrusherProp)) DeleteObject(CrusherProp)
	unloadModel(GetEntityModel(trashProp)) DeleteObject(trashProp)
	for _, v in pairs(scrapProps) do unloadModel(GetEntityModel(v)) DeleteObject(v) end
end)
