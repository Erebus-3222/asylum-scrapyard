
Config = {
	Lan = "en",
	Debug = false, -- Toggle Debug Mode
	Blips = true, -- Enable Blips?
	BlipNamer = false, -- Enable to Name Blips different things, disable if you already have too many blips as this will group them together

	img = "qs-inventory/html/images/", -- Set this to your inventory
	JobRole = "salvage", -- Whats the job role you want to use this? "nil" for none

	Locations =  {
		['scrapyard'] = {
			{ name = "Scrapyard", coords = vector3(-499.02, -1713.81, 19.9), blipTrue = true, sprite = 527, col = 5},
		},
	},

	MinPay 	= 50,
	MaxPay 	= 100,
	MaxItemsReceived 	= 2,
	MinItemReceivedQty 	= 1,
	MaxItemReceivedQty 	= 3,

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-- ██████╗░░█████╗░███╗░░██╗██╗░░░██╗░██████╗  ██╗████████╗███████╗███╗░░░███╗░██████╗
-- ██╔══██╗██╔══██╗████╗░██║██║░░░██║██╔════╝  ██║╚══██╔══╝██╔════╝████╗░████║██╔════╝
-- ██████╦╝██║░░██║██╔██╗██║██║░░░██║╚█████╗░  ██║░░░██║░░░█████╗░░██╔████╔██║╚█████╗░
-- ██╔══██╗██║░░██║██║╚████║██║░░░██║░╚═══██╗  ██║░░░██║░░░██╔══╝░░██║╚██╔╝██║░╚═══██╗
-- ██████╦╝╚█████╔╝██║░╚███║╚██████╔╝██████╔╝  ██║░░░██║░░░███████╗██║░╚═╝░██║██████╔╝
-- ╚═════╝░░╚════╝░╚═╝░░╚══╝░╚═════╝░╚═════╝░  ╚═╝░░░╚═╝░░░╚══════╝╚═╝░░░░░╚═╝╚═════╝░
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
	BonusBrakesChance	= 1,
	BonusBrakes			= "brakes1",
	BonusEngineChance	= 1,
	BonusEngine			= "engine1",
	BonusTransChance	= 1,
	BonusTransmission	= "transmission1",
	BonusCosmeticChance = 1,
	BonusCosmetic		= "hood",


	ItemTable = {
		[1] = "metalscrap",
		[2] = "copper",
		[3] = "iron",
		[4] = "aluminum",
		[5] = "steel",
		[6] = "rubber",
		[7] = "electronicscrap",
		
	}


}

Loc = {}
