_target = _this select 0;
_dog = player getVariable "CLAY_DogUnit";
//player setVariable ["CLAY_DogStatus", "Searching"];
(DOGCTRL_MENU select 6) set [6, "0"];

if (_dog distance _target <= 4) then {
  _dog doMove getPos _target;
  player groupchat format ["Checking %1 for Drugs", _target];
  drugsValue = 0;
  (format ["if (player == %1) then {[""drugs"", %2] execVM ""civmenu.sqf"";};", _target, player]) call OL_network_Swag;
} else {
  _dog doMove getPos _target;
  player groupchat "Your Dog is not close enough to civilian"
};
(DOGCTRL_MENU select 6) set [6, "1"];
