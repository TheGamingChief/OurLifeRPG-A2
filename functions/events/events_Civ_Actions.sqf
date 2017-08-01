OL_PlayerActions = [
  [player addaction ["Gather ILLEGAL Organs", "bodypart.sqf", '', 1, true, true, "", 'player distance (nearestobjects [getpos player, ["body"],  3] select 0) < 2']],
  [player addaction ["Take Hostage Mission", "hostage.sqf", ["getajob_hostage"], 1, false, true, "", "player distance hostage <= 3 and isciv"]],
  [player addaction ["Rob Safe", "noscript.sqf", "[] call OL_bank_ShowDialog;", 1, false, true, "", "player distance Safe1 <= 3 and isciv"]],
  [player addaction ["Crack Safe", "noscript.sqf",'[safe1] call OL_bank_CrackSafe;', 1, false, true, "", "player distance Safe1 <= 3 and isciv"]],
  [player addaction ["Take Hostage", "noscript.sqf", "[hostage1] join (group player); player groupchat ""Keep the hostage close or you will fail!"";", 1, false, true, "", "player distance hostage1 < 5"]],
  [player addaction ["Gang Menu", "maindialogs.sqf", ["gangmenu"], 1, false, true, "", "player distance rathaus <= 3 and isciv"]],
  [player addaction ["Get Assassination job", "assassination.sqf", ["getajob_assassin"], 1, false, true, "", "player distance assassin <= 3 and isciv"]],
  [player addaction ["Strip Vehicle", "noscript.sqf", 'call Chopshop_fnc_stripVehicle', 1, false, true, "", "(player distance chopshop <= 5) and chopavailable"]],
  [player addaction ["Chop Vehicle", "noscript.sqf", 'call Chopshop_fnc_sellVehicle', 1, false, true, "", "(player distance chopshop <= 5) and chopavailable"]],
  [player addaction ["Get Gun Running Mission", "noscript.sqf", 'call GunRunning_fnc_takeJob', 1, false, true, "", "(player distance guss <= 2) and gunrunavailable"]],
  [player addaction ["Turn in Shipment", "noscript.sqf", 'call GunRunning_fnc_deliverShipment', 1, false, true, "", '(player distance guss <= 2) and gunrun3available']],
  [player addaction ["Pick Up Gun Shipment", "noscript.sqf", '[] spawn GunRunning_fnc_pickupShipment', 1, false, true, "", "(player distance gman <= 2) and gunrun2available"]],
  [player addaction ["Factory Guide", "noscript.sqf", '[] call Factory_fnc_InfoGuide;', 1, false, true, "", '(player distance Vehiclefactory <= 5 || player distance weaponfactory <= 5 || player distance illegalweaponfactory <= 5)']],
  [player addaction ["Pay 1 Line Slots - $1000", "noscript.sqf", '["1line"] call Casino_fnc_playSlots;', 1, false, true, "", "(player distance slots1 <= 2 or player distance slots2 <= 2 or player distance slots3 <= 2 or player distance slots4 <= 2 or player distance slots5 <= 2 or player distance slots6 <= 2 or player distance slots7 <= 2 or player distance slots8 <= 2 or player distance slots9 <= 2 or player distance slots10 <= 2 or player distance slots11 <= 2 or player distance slots12 <= 2) and slots1available and !IsSpinningSlots"]],
  [player addaction ["Pay 2 Line Slots - $10000", "noscript.sqf", '["2line"] call Casino_fnc_playSlots;', 1, false, true, "", "(player distance slots1 <= 2 or player distance slots2 <= 2 or player distance slots3 <= 2 or player distance slots4 <= 2 or player distance slots5 <= 2 or player distance slots6 <= 2 or player distance slots7 <= 2 or player distance slots8 <= 2 or player distance slots9 <= 2 or player distance slots10 <= 2 or player distance slots11 <= 2 or player distance slots12 <= 2) and slots2available and !IsSpinningSlots"]],
  [player addaction ["Pay MAX Line Slots - $25000", "noscript.sqf", '["maxline"] call Casino_fnc_playSlots;', 1, false, true, "", "(player distance slots1 <= 2 or player distance slots2 <= 2 or player distance slots3 <= 2 or player distance slots4 <= 2 or player distance slots5 <= 2 or player distance slots6 <= 2 or player distance slots7 <= 2 or player distance slots8 <= 2 or player distance slots9 <= 2 or player distance slots10 <= 2 or player distance slots11 <= 2 or player distance slots12 <= 2) and slots3available and !IsSpinningSlots"]],
  [player addaction ["Rob Casino Vault", "noscript.sqf", '[cvault] call CP_fnc_RobStuff', 1, false, true, "", "isciv and casinomoney >= 50000 and player distance cvault <= 2 and casinoavailable"]],
  [player addaction ["Take boar meat", "noscript.sqf", '_no = ceil(random 7);if (((call INV_GetOwnWeight) + ("boar" call INV_getitemTypeKg)*_no) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};(nearestobjects [getpos player, ["wildboar"],  3] select 0) setvariable ["inuse", 1, true]; player playmove "AinvPknlMstpSlayWrflDnon_medic";sleep 4;waituntil {animationstate player != "AinvPknlMstpSlayWrflDnon_medic"};deletevehicle (nearestobjects [getpos player, ["wildboar"],  3] select 0);["boar", _no] call INV_AddInvItem;player groupchat format["you got %1 boar meat", _no];', 1, true, true, "", '_w = (nearestobjects [getpos player, ["wildboar"],  3] select 0) getvariable "inuse"; isnil "_w" and player distance (nearestobjects [getpos player, ["wildboar"],  3] select 0) < 5 and !alive (nearestobjects [getpos player, ["wildboar"],  3] select 0) and isciv']],
  [player addaction ["Take cow meat", "noscript.sqf", '_no = ceil(random 2);if (((call INV_GetOwnWeight) + ("rawcow" call INV_getitemTypeKg)*_no) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};(nearestobjects [getpos player, ["cow01"],  3] select 0) setvariable ["inuse", 1, true]; player playmove "AinvPknlMstpSlayWrflDnon_medic";sleep 4;waituntil {animationstate player != "AinvPknlMstpSlayWrflDnon_medic"};deletevehicle (nearestobjects [getpos player, ["cow01"],  3] select 0);["rawcow", _no] call INV_AddInvItem;player groupchat format["you got %1 raw cow meat", _no];', 1, true, true, "", '_w = (nearestobjects [getpos player, ["cow01"],  3] select 0) getvariable "inuse"; isnil "_w" and player distance (nearestobjects [getpos player, ["cow01"],  3] select 0) < 5 and !alive (nearestobjects [getpos player, ["cow01"],  3] select 0) and isciv']],
  [player addaction ["Impound Lot", "noscript.sqf", '[impoundbuy] call OL_ui_ImpoundLot', 1, false, true, "", "player distance impoundbuy <= 5"]],
  [player addaction ["Elect a Governor", "maindialogs.sqf", ["wahlen"], 1, false, true, "", "player distance rathaus <= 3"]],
  [player addaction ["Change the Law", "maindialogs.sqf", ["gesetz"], 1, false, true, "", "player distance rathaus <= 3 and isMayor"]],
  [player addaction ["Change taxes", "maindialogs.sqf", ["steuern"], 1, false, true, "", "player distance rathaus <= 3 and isMayor"]],
//  [player addaction ["Resign as Governor", "noscript.sqf",'[] call OL_governor_Resign;', 1, false, true, "", "player distance rathaus <= 3 and isMayor"]],
  [player addaction ["Make License Plate", "noscript.sqf", '[] call Jail_fnc_createPlates;', 1, false, true, "", "(player distance plate1 <= 3 || player distance plate2 <= 3) and platesavailable"]],
  [player addaction ["Crime Log", "maindialogs.sqf", ["coplog"], 1, false, true, "", "player distance rathaus <= 3"]],
  [player addaction [format ["Buy Hooker ($%1)", huren_cost], "worker.sqf", ["holen"], 1, false, true, "", "player distance hookerking <= 5 and isciv"]],
  [player addaction [format ["Pay Bail", slave_cost], "maindialogs.sqf", ["bail"], 1, false, true, "", "player distance bailflag <= 3 and isciv"]],
  [player addaction ["Process Diamond", "itemprocess.sqf", ["diamond rock", "diamond", 5, ""], 1, false, true, "", "player distance diamond_1 <= 5 and isciv"]],
  [player addaction ["Process Meth", "itemprocess1.sqf", ["pharm", "meth", 2, ""], 1, false, true, "", "player distance methlab <= 5 and isciv"]],
  [player addaction ["Process Oil", "itemprocess.sqf", ["Oil", "OilBarrel", 2, "oil"], 1, false, true, "", "player distance Oil_1 <= 5 and isciv"]],
  [player addaction ["Process Wheat", "itemprocess.sqf", ["getreide", "Bread", 2, "Baker"], 1, false, true, "", "player distance bakery <= 5 and isciv"]],
  [player addaction ["Process Strawberries", "itemprocess.sqf", ["straw", "Frozens", 3, "Baker"], 1, false, true, "", "player distance bakery <= 5 and isciv"]],
  [player addaction ["Process LSD", "itemprocess.sqf", ["Unprocessed_LSD", "lsd", 5, "lsd ga1"], 1, false, true, "", "player distance OL_Shop_Gangarea1 <= 5 and isciv"]],
  [player addaction ["Process Cocaine", "itemprocess.sqf", ["Unprocessed_Cocaine", "cocaine", 5, "cocaine ga1"], 1, false, true, "", "player distance OL_Shop_Gangarea1 <= 5 and isciv"]],
  [player addaction ["Process LSD", "itemprocess.sqf", ["Unprocessed_LSD", "lsd", 5, "lsd ga2"], 1, false, true, "", "player distance OL_Shop_Gangarea2 <= 5 and isciv"]],
  [player addaction ["Process Heroin", "itemprocess.sqf", ["Unprocessed_Heroin", "heroin", 5, "heroin ga2"], 1, false, true, "", "player distance OL_Shop_Gangarea2 <= 5 and isciv"]],
  [player addaction ["Process Heroin", "itemprocess.sqf", ["Unprocessed_Heroin", "heroin", 5, "heroin ga3"], 1, false, true, "", "player distance OL_Shop_Gangarea3 <= 5 and isciv"]],
  [player addaction ["Process Marijuana", "itemprocess.sqf", ["Unprocessed_Marijuana", "marijuana", 5, "marijuana ga3"], 1, false, true, "", "player distance OL_Shop_Gangarea3 <= 5 and isciv"]],
  [player addaction ["Process Heroin", "itemprocess.sqf", ["Unprocessed_Heroin", "heroin", 5, "heroin ga4"], 1, false, true, "", "player distance OL_Shop_Gangarea4 <= 5 and isciv"]],
  [player addaction ["Process Marijuana", "itemprocess.sqf", ["Unprocessed_Marijuana", "marijuana", 5, "marijuana ga4"], 1, false, true, "", "player distance OL_Shop_Gangarea4 <= 5 and isciv"]],
  [player addaction ["Get in Trailer", "trucking.sqf", [4], 1, true, true, "", '_vcl = (nearestobjects [getpos player, ["cl_mackr", "cl_trucktest_mackr", "cl_flatbed_mackr"], 5] select 0);player distance _vcl < 5 and _vcl in INV_ServerVclArray']],
  [player addaction ["Get taxi job", "taxi.sqf", ["getajob_taxi"], 1, false, true, "", "player distance taxishop <= 5 and isciv"]],
  [player addaction ["Finish taxi mission", "taxi.sqf", ["canceljob_taxi"], 1, false, true, "", "(player distance taxishop <= 5) and isciv and workplacejob_taxi_active"]],
  [player addaction ["Pull out", "noscript.sqf", '(nearestobjects [getpos player, ["Air", "Ship", "LandVehicle"], 3] select 0) execVM "pullout.sqf";', 1, true, true, "", '_vcl = (nearestobjects [getpos player, ["Air", "Ship", "LandVehicle"], 3] select 0);player distance _vcl < 5 and count (crew _vcl) > 0 and _vcl in INV_ServerVclArray and (call INV_isArmed)']],
  [player addaction ["Vehicle information", "noscript.sqf", '(nearestobjects [getpos player, ["Air", "Ship", "LandVehicle"], 3] select 0) execVM "vehinfo.sqf";', 1, true, true, "", '_vcl = (nearestobjects [getpos player, ["Air", "Ship", "LandVehicle"], 3] select 0);player distance _vcl < 5 and _vcl in INV_ServerVclArray']],
  [player addaction ["Neutralise flag", "gangflags.sqf", [OL_Shop_Gangarea1, "neutralise"], 1, false, true, "", '_control = OL_Shop_Gangarea1 getvariable "control";player distance OL_Shop_Gangarea1 <= 6 and _control != (call INV_mygang) and gangmember and !pickingup']],
  [player addaction ["Neutralise flag", "gangflags.sqf", [OL_Shop_Gangarea2, "neutralise"], 1, false, true, "", '_control = OL_Shop_Gangarea2 getvariable "control";player distance OL_Shop_Gangarea2 <= 6 and _control != (call INV_mygang) and gangmember and !pickingup']],
  [player addaction ["Neutralise flag", "gangflags.sqf", [OL_Shop_Gangarea3, "neutralise"], 1, false, true, "", '_control = OL_Shop_Gangarea3 getvariable "control";player distance OL_Shop_Gangarea3 <= 6 and _control != (call INV_mygang) and gangmember and !pickingup']],
  [player addaction ["Neutralise flag", "gangflags.sqf", [OL_Shop_Gangarea4, "neutralise"], 1, false, true, "", '_control = OL_Shop_Gangarea3 getvariable "control";player distance OL_Shop_Gangarea4 <= 6 and _control != (call INV_mygang) and gangmember and !pickingup']],
  [player addaction ["Capture flag", "gangflags.sqf", [OL_Shop_Gangarea4, "capture"], 1, false, true, "", 'player distance OL_Shop_Gangarea4 <= 6 and gangmember and !pickingup and getpos OL_Shop_Gangarea4 select 2 < 0']],
  [player addaction ["Capture flag", "gangflags.sqf", [OL_Shop_Gangarea1, "capture"], 1, false, true, "", 'player distance OL_Shop_Gangarea1 <= 6 and gangmember and !pickingup and getpos OL_Shop_Gangarea1 select 2 < 0']],
  [player addaction ["Capture flag", "gangflags.sqf", [OL_Shop_Gangarea2, "capture"], 1, false, true, "", 'player distance OL_Shop_Gangarea2 <= 6 and gangmember and !pickingup and getpos OL_Shop_Gangarea2 select 2 < 0']],
  [player addaction ["Capture flag", "gangflags.sqf", [OL_Shop_Gangarea3, "capture"], 1, false, true, "", 'player distance OL_Shop_Gangarea3 <= 6 and gangmember and !pickingup and getpos OL_Shop_Gangarea3 select 2 < 0']],
  [player addaction ["Gang Shop", "shopdialogs.sqf", [OL_Shop_Gangarea1 call INV_getshopnum], 1, false, true, "", "_control = OL_Shop_Gangarea1 getvariable ""control"";!isnil ""_control"" and player distance OL_Shop_Gangarea1 <= 5 and (_control == (call INV_mygang))"]],
  [player addaction ["Gang Shop", "shopdialogs.sqf", [OL_Shop_Gangarea2 call INV_getshopnum], 1, false, true, "", "_control = OL_Shop_Gangarea2 getvariable ""control"";!isnil ""_control"" and player distance OL_Shop_Gangarea2 <= 5 and (_control == (call INV_mygang))"]],
  [player addaction ["Gang Shop", "shopdialogs.sqf", [OL_Shop_Gangarea3 call INV_getshopnum], 1, false, true, "", "_control = OL_Shop_Gangarea3 getvariable ""control"";!isnil ""_control"" and player distance OL_Shop_Gangarea3 <= 5 and (_control == (call INV_mygang))"]],
  [player addaction ["Gang Shop", "shopdialogs.sqf", [OL_Shop_Gangarea4 call INV_getshopnum], 1, false, true, "", "_control = OL_Shop_Gangarea4 getvariable ""control"";!isnil ""_control"" and player distance OL_Shop_Gangarea4 <= 5 and (_control == (call INV_mygang))"]],
  [player addaction ["Rob Gas Station", "noscript.sqf", '[fuel2] call CP_fnc_RobStuff', 1, false, true, "", "isciv and station2money >= 5000 and player distance fuel2 <= 2 and pornavailable"]],
  [player addaction ["Rob Gas Station", "noscript.sqf", '[fuel4] call CP_fnc_RobStuff', 1, false, true, "", "isciv and station4money >= 5000 and player distance fuel4 <= 2 and gaspitavailable"]],
  [player addaction ["Rob Gas Station", "noscript.sqf", '[fuel5] call CP_fnc_RobStuff', 1, false, true, "", "isciv and station5money >= 5000 and player distance fuel5 <= 2 and chipsavailable"]],
  [player addaction ["Rob Gas Station", "noscript.sqf", '[fuel7] call CP_fnc_RobStuff', 1, false, true, "", "isciv and station7money >= 5000 and player distance fuel7 <= 2 and mikesavailable"]],
  [player addaction ["Rob Gas Station", "noscript.sqf", '[fuel8] call CP_fnc_RobStuff', 1, false, true, "", "isciv and station8money >= 5000 and player distance fuel8 <= 2 and hausavailable"]],
  [player addaction ["Rob Pharmacy", "noscript.sqf", '[pharmacy] call CP_fnc_RobStuff', 1, false, true, "", "isciv and pharmmoney >= 5000 and player distance pharmacy <= 2"]],
  [player addaction ["Rob Bar", "noscript.sqf", '[pub1] call CP_fnc_RobStuff', 1, false, true, "", "isciv and barmoney >= 5000 and player distance pub1 <= 2 and fionasavailable"]],
  [player addaction ["Rob Bar", "noscript.sqf", '[pub2] call CP_fnc_RobStuff', 1, false, true, "", "isciv and barmoney1 >= 5000 and player distance pub2 <= 2 and southavailable"]],
  [player addaction ["Rob Bar", "noscript.sqf", '[pub3] call CP_fnc_RobStuff', 1, false, true, "", "isciv and barmoney2 >= 5000 and player distance pub3 <= 2 and macksavailable"]],
  [player addaction ["Rob Bar", "noscript.sqf", '[pub4] call CP_fnc_RobStuff', 1, false, true, "", "isciv and barmoney3 >= 5000 and player distance pub4 <= 2 and hermannsavailable"]],
  [player addaction ["Rob Saloon", "noscript.sqf", '[pub5] call CP_fnc_RobStuff', 1, false, true, "", "isciv and barmoney5 >= 5000 and player distance pub5 <= 2 and binkysavailable"]],
  [player addaction ["Rob Store", "noscript.sqf", '[donutguy] call CP_fnc_RobStuff', 1, false, true, "", "isciv and donutmoney1 >= 5000 and player distance donutguy <= 5 and robdonutavailable"]],
  [player addaction ["Rob Store", "noscript.sqf", '[donutguy2] call CP_fnc_RobStuff', 1, false, true, "", "isciv and donutmoney2 >= 5000 and player distance donutguy2 <= 5 and robdonut1available"]],
  [player addaction ["Buy Donut", "noscript.sqf", '["donut 1"] call Shops_fnc_buyDonuts;', 1, false, true, "", "player distance donutguy <= 5 || player distance donutguy2 <= 5"]],
  [player addaction ["Buy Half Dozen Donuts", "noscript.sqf", '["donut 6"] call Shops_fnc_buyDonuts;', 1, false, true, "", "player distance donutguy <= 5 || player distance donutguy2 <= 5"]],
  [player addaction ["Buy Dozen Donuts", "noscript.sqf", '["donut 12"] call Shops_fnc_buyDonuts;', 1, false, true, "", "player distance donutguy <= 5 || player distance donutguy2 <= 5"]],
  [player addaction ["Unflip vehicle", "noscript.sqf", '_vcls = call CP_misc_NearestCar; [_vcls select 0] call OL_vehicle_Unflip;', 1, false, true, "", '_vcl = (nearestobjects [getpos player, ["Air", "Ship", "LandVehicle"], 3] select 0);player distance _vcl < 5 and _vcl in INV_VehicleArray']],
  [player addaction ["Sign-up for Debit Card", "debitcardsignup.sqf", ["mainbank"], 1, false, true, "", "player distance mainbank <= 15 and (!SigningUpForDebitCard)"]],
  [player addaction ["Raise / Lower Gates", "gateController.sqf", [cgate1], 1, false, true, "", "isciv and ((player distance pmcgatecp < 2) or (player distance pmcgatecp2 < 2)) and ((getPlayerUID player) in PMC_id)"]],
  [player addaction ["Raise / Lower Gates", "gateController.sqf", [cgate3], 1, false, true, "", "isciv and ((player distance pmcgatecp3 < 2) or (player distance pmcgatecp4 < 2)) and ((getPlayerUID player) in PMC_id)"]],
  [player addaction ["[Service Helicopter]", "noscript.sqf", '[] call PMC_fnc_repair;', 1, false, true, "", 'player distance pmchelipad2 <= 8 and ((getplayeruid player) in PMC_id)']],
  [player addaction ["Impound vehicle", "noscript.sqf", '_vcl = (nearestobjects [getpos player, ["Air", "Ship", "LandVehicle"], 3] select 0); [_vcl] call OL_vehicle_Impound;', 1, true, true, "", '_vcl = (nearestobjects [getpos player, ["Air", "Ship", "LandVehicle"], 3] select 0);_vcl in INV_ServerVclArray and player distance _vcl < 10 and _vcl distance towgate < 50']],
  [player addaction ["[Take Boat From Storage]", "noscript.sqf", '["Ship", BoatSaveSpawn] call OL_ui_VehicleMenu;', 1, false, true, "", "player distance BoatSavePoint <= 5"]],
  [player addaction ["[SAVE YOUR AIR VEHICLE]", "noscript.sqf", '_vcls = call CP_misc_NearestCar; [_vcls select 0] call OL_stats_saveVehicles;', 1, true, true, "", '_vcl = (nearestobjects [getpos player, ["Air"], 7] select 0);player distance _vcl < 7 and _vcl in INV_ServerVclArray and _vcl in INV_VehicleArray and (player distance AirSavePoint <= 50)']],
  [player addaction ["[Take Air Vehicle From Storage]", "noscript.sqf", '["Air", AirSaveSpawn] call OL_ui_VehicleMenu;', 1, false, true, "", "player distance AirSavePoint <= 3"]],
  [player addaction ["[SAVE YOUR BOAT]", "noscript.sqf", '_vcls = call CP_misc_NearestCar; [_vcls select 0] call OL_stats_saveVehicles;', 1, true, true, "", '_vcls = call CP_misc_NearestCar;player distance (_vcls select 0) < 5 and (_vcls select 0) in INV_ServerVclArray and (_vcls select 0) in INV_VehicleArray and player distance BoatSavePoint <= 50']],
  [player addaction ["[Take Land Vehicle From Storage]","noscript.sqf",'["LandVehicle", LandSaveSpawn] call OL_ui_VehicleMenu;',1,false,true,"","player distance LandSavePoint <= 3"]],
  [player addaction ["[Take Land Vehicle From Storage]","noscript.sqf",'["LandVehicle", SaveSpawn] call OL_ui_VehicleMenu;',1,false,true,"","player distance savepoint <= 3"]],
  [player addaction ["[Take Land Vehicle From Storage]","noscript.sqf",'["LandVehicle", carxspawn] call OL_ui_VehicleMenu;',1,false,true,"","player distance savepointx <= 3"]],
  [player addaction ["[SAVE YOUR LAND VEHICLE]","noscript.sqf",'_vcls = call CP_misc_NearestCar; [_vcls select 0] call OL_stats_saveVehicles;',1,true,true,"",'_vcl = (nearestobjects [getpos player, ["LandVehicle"], 3] select 0);player distance _vcl < 5 and _vcl in INV_ServerVclArray and _vcl in INV_VehicleArray and (player distance savepoint <= 30 or player distance savepointx <= 30 or player distance LandSavePoint <= 30)']],
  [player addAction ["Open Clothes Menu","noscript.sqf", '[] call OL_ui_ClothesMenu;', 1, false, true, "", "player distance atmuc <= 5 || player distance towatm <= 5 || player distance pmcbank <= 5 || player distance assassinshop <= 5"]]
];
