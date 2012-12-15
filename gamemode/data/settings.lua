
CitizenLoadout = {
"weapon_physcannon",
"weapon_physgun",
"weapon_rp_keys",
"weapon_rp_fists",
"gmod_tool",
}

local PoliceLoadout = {
"weapon_rp_coppistol",
"weapon_rp_baton",
"weapon_rp_arrestbaton",
"weapon_rp_batteringram"
}
local GangLoadout = {
"weapon_rp_knife"
}
local MobBossLoadout = {
"weapon_rp_unarrestbaton",
"weapon_rp_knife"
}

local RebelModels = {
"models/player/group03/male_01.mdl",
"models/player/group03/male_02.mdl",
"models/player/group03/male_03.mdl",
"models/player/group03/male_04.mdl",
"models/player/group03/male_05.mdl",
"models/player/group03/male_06.mdl",
"models/player/group03/male_07.mdl",
"models/player/group03/male_08.mdl",
"models/player/group03/male_09.mdl"
}

function RP.FirstInitializeData()
	RP.LoadDataDefaults()
	RP.LoadClassDefaults()
	RP.LoadJailDefaults()
	RP.Print("First run data initalization complete!", true)
end

function RP.LoadDataDefaults()
	RP.SetData("StaticDataInitialized", 1)
	RP.SetData("DefaultClass", "citizen")
	RP.SetData("ArrestTime", 120)
	RP.SetData("RunSpeed", 200)
	RP.SetData("WalkSpeed", 125)
	RP.SetData("SprintSpeed", 300)
	RP.SetData("DoorCost", 50)
	RP.SetData("DoorLimit", 5)
	RP.SetData("CarCost", 75)
	RP.SetData("CarLimit", 3)
	RP.SetData("InitialMoney", 5000)
	RP.SetData("DataInitialized", 1)
	RP.SetData("AdminNoLimits", 1)
	RP.SetData("SpawnProps", 1)
	RP.SetData("SpawnNPCs", 0)
	RP.SetData("SpawnEffects", 0)
	RP.SetData("SpawnSENTs", 0)
	RP.SetData("SpawnVehicles", 1)
	RP.SetData("SpawnRagdolls", 0)
end

function RP.LoadClassDefaults()
	RP.AddClass("Citizen", Color(0, 160, 255), "usersel", CitizenLoadout, 100, 0, "citizen", -1, 75, -1, [[Your average every day person.]]) -- Base Class, Don't edit me.
	RP.AddClass("Police Officer", Color(30, 30, 255), {"models/player/police.mdl"}, PoliceLoadout, 100, 50, "police", 1, 100, -1, [[Uphold the law and arrest criminal scum.]])
	RP.AddClass("Mayor", Color(255, 30, 30), {"models/player/breen.mdl"}, CitizenLoadout, 100, 100, "mayor", -2, 150, -1, [[Enact and enforce the laws of your city with political power!]])
	RP.AddClass("Gangster", Color(190, 190, 190), RebelModels, GangLoadout, 100, 0, "gangster", -1, 50, -1, [[Participate in the underground crime scene.]])
	RP.AddClass("Mob Boss", Color(225, 225, 225), {"models/player/gman_high.mdl"}, MobBossLoadout, 100, 20, "mobboss", -2, 125, 4, [[Participate in the underground crime scene.]])
end

function RP.LoadJailDefaults()
	RP.SetData("Jails_rp_downtown_v1-1p", glon.encode({{2839, 126877, -195}, {2905, 126337, -195}, {2919, 116332, -195}, {2845, 115388, -195}}))
	RP.SetData("Jails_rp_precinct_06_v1", glon.encode({{-2115, 317, -195}, {-2021, 322-195}, {-1927, 315 -195}, {-1826, 327, -195}}))
	RP.SetData("Jails_rp_ubyutown", glon.encode({{-1154, 33111, -195}, {-1260, 33101, -195}}))
	RP.SetData("Jails_rp_downtown_ubyutown", glon.encode({{-1028, 30449, -391}, {-1024, 31831, -391}}))
	RP.SetData("Jails_rp_downtown_v2", glon.encode({{-1905, 179, -195}, {-1997, 185, -195}, {-2099, 172, -195}, {-2200, 1784, -195}}))
	RP.SetData("Jails_rp_omgcity_final", glon.encode({{-743, 322791, 256}, {-740, 308453, 256}}))
	RP.SetData("Jails_rp_omgcity_night", glon.encode({{-743, 322791, 256}, {-740, 308453, 256}}))
	RP.SetData("Jails_rp_tb_city45_v01", glon.encode({{1404, 191599, 280}, {1407, 203461, 280}, {1397, 217077, 280}, {1411, 228622, 280}, {1258, 241822, 280}, {1158, 241429, 280}, {1070, 2405699, 280}}))
	RP.SetData("Jails_rp_tb_city45_v02", glon.encode({{1404, 191599, 280}, {1407, 203461, 280}, {1397, 217077, 280}, {1411, 228622, 280}, {1258, 241822, 280}, {1158, 241429, 280}, {1070, 2405699, 280}}))
	RP.SetData("Jails_rp_tb_city45_v02n", glon.encode({{1404, 191599, 280}, {1407, 203461, 280}, {1397, 217077, 280}, {1411, 228622, 280}, {1258, 241822, 280}, {1158, 241429, 280}, {1070, 2405699, 280}}))
	RP.SetData("Jails_rp_c18_v1", glon.encode({{3419, 894872, 368}, {3020, 7053, 368}, {1867, 9587, 368}, {2000, 9639, 368}, {2125, 961, 368}, {2284, 94368, 368}}))
	RP.SetData("Jails_rp_oviscity_gmc4", glon.encode({{-3077, -7726, -447}, {-3054, -3354, -447}, {-3249, -7639, -447}, {-3221, -340, -447}}))
	RP.SetData("Jails_rp_bigcity_life", glon.encode({{6089, 425322, -185}, {6261, 424375, -185}, {6256, 453645, -185}, {6084, 45524, -185}, {5916, 455304, -185}, {5707, 455018, -185}, {2376, 474162, -167}, {2373, 487771, -167}, {2373, 500429, -167}, {2375, 513299, -167}, {2394, 527819, -167}}))
	RP.SetData("Jails_rp_cargtown_b7", glon.encode({{993, -30958792, -39}, {981, -28600234, -39}, {984, -2577448, -39}, {981, -2339.084, -39}, {990, -30886626, -199}, {970, -28296362, -199}, {972, -25827537, -199}, {990, -2326127, -199}}))
	RP.SetData("Jails_rp_christmastown", glon.encode({{1148, -2974585, -125}, {1034, -2993699, -125}, {887, -29850645, -125}}))
	RP.SetData("Jails_rp_cscdesert_v2", glon.encode({{2753, -8763117, 8}, {8025, 406585, -895}, {8028, 387682, -895}, {8032, 3706992, -895}}))
	RP.SetData("Jails_rp_cscdesert_v2-1", glon.encode({{2753, -8763117, 8}, {8025, 406585, -895}, {8028, 387682, -895}, {8032, 3706992, -895}}))
	RP.SetData("Jails_rp_cscdesert_v2-1_propfix", glon.encode({{2753, -8763117, 8}, {8025, 406585, -895}, {8028, 387682, -895}, {8032, 3706992, -895}}))
	RP.SetData("Jails_rp_devcity", glon.encode({{-1433, -3626, 4}, {-1415, -1953, 4}}))
	RP.SetData("Jails_rp_flapcity_v1", glon.encode({{-863, 4644, 8}, {-861, 4077, 8}}))
	RP.SetData("Jails_rp_hotelcivil2_v2", glon.encode({{407, 76375, 512}, {539, 77224, 512}}))
	RP.SetData("Jails_rp_park_9", glon.encode({{1734, -15603, 68}, {1943, -16677, 68}, {2118, -16078, 68}, {2313, -692, 68}, {2491, 1067, 68}, {2500, 2922, 68}}))
	RP.SetData("Jails_rp_wreckrock", glon.encode({{-1951, -4814, -3519}, {-1921, -4567, -3519}}))
	RP.SetData("Jails_rp_zeekyboogydoogv10", glon.encode({{-1386, -2895, -509}, {-1467, -2926, -509}, {-1595, -2876, -509}, {-1690, -28372, -509}}))
	RP.SetData("Jails_rp_hometown1999", glon.encode({{-166, -831445, -127}, {-169, -10758, -127}, {10, -8387537, -127}, {12, -1069.6364, -127}}))
	RP.SetData("Jails_rp_hometown2000", glon.encode({{-388, 155898, 0}, {-272, 156508, 0}, {-155, 157167, 0}, {-46, 1567174, 0}}))
	RP.SetData("Jails_rp_evocity_v1p", glon.encode({{-8164, -784288, -695}, {-8159, -772298, -695}, {-8180, -761161, -695}, {-8164, -75062, -695}, {-8155, -73789, -695}, {-7987, -784578, -695}, {-7990, -772185, -695}, {-7994, -761994, -695}, {-7986, -750659, -695}, {-7991, -738134, -695}, {-7803, -782129, -695}, {-7803, -772637, -695}, {-7810, -761598, -695}, {-7809, -750262, -695}, {-7790, -739992, -695}}))
	RP.SetData("Jails_rp_evocity_v2d", glon.encode({{-7655, -929506, 840}, {-7890, -93072, 840}, {-8031, -93123, 840}, {-8172, -915127, 840}, {-8027, -899289, 840}, {-7855, -901334, 840}, {-7669, -901772, 840}}))
	RP.SetData("Jails_rp_amsterville", glon.encode({{3955, 312061, 192}, {3957, 299074, 192}, {3958, 286905, 192}}))
	RP.SetData("Jails_rp_themitropolis_v3c", glon.encode({{1846, -1258672, 12753}, {2011, -1264491, 12753}, {2186, -1265106, 12753}}))
	RP.SetData("Jails_rp_townsend_v1p", glon.encode({{-12723, 4453, 0}, {-12943, 4471, 0}, {-13164, 4443, 0}}))
end