["serverloop1"] execVM "ServerFiles\server\commonloop.sqf";
[0, 0, 0, ["serverloop"]] execVM "mayor.sqf";
[0, 0, 0, ["serverloop"]] execVM "chief.sqf";
[0, 0, 0, ["serverloop"]] execVM "gangs.sqf";
[] execVM "ServerFiles\StatSave\druguse.sqf";
[] execVM "ServerFiles\StatSave\robpool.sqf";
[] execVM "ServerFiles\StatSave\hunting.sqf";

//=======================rob gas station init and variables================
[] execVM "stationrobloop.sqf";
station1money = 5000;
publicvariable "station1money";
station2money = 5000;
publicvariable "station2money";
station3money = 5000;
publicvariable "station3money";
station4money = 5000;
publicvariable "station4money";
station5money = 5000;
publicvariable "station5money";
station6money = 5000;
publicvariable "station6money";
station7money = 5000;
publicvariable "station7money";
station8money = 5000;
publicvariable "station8money";
station9money = 5000;
publicvariable "station9money";
pharmmoney = 5000;
publicvariable "pharmmoney";
barmoney = 5000;
publicvariable "barmoney";
barmoney1 = 5000;
publicvariable "barmoney1";
barmoney2 = 5000;
publicvariable "barmoney2";
barmoney3 = 5000;
publicvariable "barmoney3";
casinomoney = 50000;
publicvariable "casinomoney";