chopavailable = false;

private["_vcl","_tune","_payout"];
player groupChat "Please get back into your vehicle to strip it. You have 10 seconds!";
uiSleep 10;
_vcl = vehicle player;
if (player == _vcl) exitwith {player groupchat "You have must be in a vehicle to use this shop!";};

_tune = _vcl getvariable "tuning";

player groupChat "Stripping car of nice things! Please Wait!";
uiSleep 5;
player groupChat "Stealing 8/8 stereo system! Please Wait!";
uiSleep 5;

switch (_tune) do {
  case 1: {_payout = 13000};
  case 2: {_payout = 20000};
  case 3: {_payout = 30000};
  case 4: {_payout = 50000};
  case 5: {_payout = 65000};
  case 6: {_payout = 70000};
  default {_payout = 5000};
};

_vcl setVariable ["Tuning",0,true];

player groupchat format["You made $%1 from the car parts!",_payout];
['geld',_payout] call INV_AddInvItem;
chopavailable = true;