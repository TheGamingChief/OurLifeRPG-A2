_vcl = vehicle player;
_unit = _this select 1;
_gridPos = mapGridPosition getpos _unit;
_message = "RUN FOR IT!!!! A BOMB IS ABOUT TO GO OFF!!!!";
format ['server globalchat "%1";',_message] call broadcast;
sleep 1;
_message = "30 SEC TO BOOM!!!";
format ['server globalchat "%1";',_message] call broadcast;
sleep 30;
_bomb = "Bo_Mk82" createvehicle (getpos _vcl);
_message = format["A BOMB HAS JUST GONE OFF AT: %1",_gridPos];
format ['server globalchat "%1";',_message] call broadcast;