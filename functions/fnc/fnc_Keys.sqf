switch (_this select 0) do {
  case "LOCK": {
    _vcl = _this select 1;

    if (isNil "_vcl" || isNull _vcl) exitWith { player groupChat "Could not find the vehicle you are trying to lock." };
    if (player distance _vcl > 20) exitWith { player groupChat "You must be within 20m of the vehicle." };
    if (locked _vcl) then { format ["%1 lock false", _vcl] call OL_network_Swag } else { format ["%1 lock true", _vcl] call OL_network_Swag };
  };
  case "USE": {
    if (!(createDialog "schluessel")) exitWith { hint "Dialog Error!" };

    {
      if (!isNull _x) then {
        _index = lbAdd [1, format ["%1 (%2)", typeOf _x, _x]];
        lbSetData [1, [_index, _x]];
      };
    } forEach INV_VehicleArray;

    buttonSetAction [2, "if ((lbCurSel 1) > -1) then { [""LOCK"", (INV_VehicleArray select lbCurSel 1), lbCurSel 1] call OL_fnc_Keys }; closeDialog 0;"]; // Lock/Unlock
    buttonSetAction [4, "if ((lbCurSel 1) > -1) then { [""DROP"", (INV_VehicleArray select lbCurSel 1), lbCurSel 1] call OL_fnc_Keys }; closedialog 0;"]; // Drop Keys
    buttonSetAction [5, "if ((lbCurSel 1) > -1) then { [""GIVE"", (INV_VehicleArray select lbCurSel 1), lbCurSel 1] call OL_fnc_Keys }; closedialog 0;"]; // Give Keys
  };
  case "GIVE": {
    _civ = INV_PLAYERLIST select (call compile (INV_InventarGiveReceiver));

    if (!(_civ call OL_ISSE_UnitExists)) exitWith { player groupChat "The person you are trying to give keys to doesn't actually exist." };
    if (player distance _civ > 20) exitWith { player groupChat "You must be within 20m of the player you are trying to give keys too." };

    format['if (player == &1) then {
        INV_VehicleArray = INV_VehicleArray + [%2];
    };'] call OL_network_Swag;
  };
  case "DROP": {
    INV_VehicleArray = INV_VehicleArray - [_this select 0];
    player groupChat format ["You have dropped keys for %1", _this select 0];
  };
};