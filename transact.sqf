_art  = _this select 2;
_geld = 'geld' call INV_GetItemAmount;

if (_art == "deposit") then 

{
if (atmscriptrunning == 1) exitwith {player groupchat "script already running"};
atmscriptrunning = 1;
_transfer      = _this select 0; 
_transfermoney = _this select 1; 
_gridPos = mapGridPosition getpos player;
if (!(_transfermoney call OL_ISSE_str_isInteger)) exitWith {player groupChat localize "STRS_bank_no_valid_number";};
_transfermoney = _transfermoney call OL_ISSE_StrToInt;  
if (_transfermoney <= 0) exitWith {};
_steuern       = round((_transfermoney*100)/(100-bank_steuer));
//_targetString  = INV_PLAYERLIST select _transfer; 
_targetString  = call compile (INV_PLAYERSTRINGLIST select _transfer);

//if (INV_PLAYERLIST select _transfer == player) exitWith 
if (_targetString == player) exitWith

	{	

	if (_geld < _transfermoney) then 

		{

		player groupChat format[localize "STRS_bank_deposit_self_no", (_transfermoney call OL_ISSE_str_IntToStr)];

		} 
		else 
		{

		player groupChat format[localize "STRS_bank_deposit_self_yes", (_transfermoney call OL_ISSE_str_IntToStr)];
		Kontostand = Kontostand + _transfermoney;
		['geld', -(_transfermoney)] call INV_AddInvItem;
		["money_to_bank", format ["%1 (%2) has transferred $%3 to their bank at GRID: %4", player getVariable "RealName", getPlayerUID player, _transfermoney, _gridPos]] call RM_fnc_LogToServer;

		};

	};

//if (not((format["%1", (INV_PLAYERLIST select _transfer)]) call OL_ISSE_UnitExists)) exitWith {player groupChat localize "STRS_bank_player_not_ingame";};
if (not((INV_PLAYERSTRINGLIST select _transfer) call OL_ISSE_UnitExists)) exitWith {player groupChat localize "STRS_bank_player_not_ingame";};

if (KontoStand < _steuern) then 

	{

	player groupChat format[localize "STRS_bank_no_money", (_transfermoney call OL_ISSE_str_IntToStr), (bank_steuer call OL_ISSE_str_IntToStr)];	

	} 
	else 
	{

	Kontostand = Kontostand - _steuern;
	INV_SteuernGezahlt = (INV_SteuernGezahlt + (_steuern - _transfermoney));
	(format ["if (INV_ROLESTRING == ""%1"") then {Kontostand = Kontostand + %2; player groupChat format[localize ""STRS_bank_account_getmoney"", %2, %3];};", _targetString, (_transfermoney call OL_ISSE_str_IntToStr), player]) call OL_network_Swag;
	player groupChat format[localize "STRS_bank_deposit_yes", (_transfermoney call OL_ISSE_str_IntToStr), (bank_steuer call OL_ISSE_str_IntToStr), (_steuern call OL_ISSE_str_IntToStr)];
	["money_transferred", format ["%1 (%2) has transferred $%3 to %4's (%5) bank at GRID: %6", player getVariable "RealName", getPlayerUID player, _transfermoney, name _targetString, getPlayerUID _targetString, _gridPos]] call RM_fnc_LogToServer;

	};

};

if (_art == "withdraw") then 

{
if (atmscriptrunning == 1) exitwith {player groupchat "script already running"};
atmscriptrunning = 1;
_withdraw = _this select 0;
_gridPos = mapGridPosition getpos player;
if (!(_withdraw call OL_ISSE_str_isInteger)) exitWith {player groupChat localize "STRS_bank_no_valid_number";};
_withdraw = _withdraw call OL_ISSE_StrToInt;  
if (_withdraw <= 0) exitWith {};

if (Kontostand >= _withdraw) then 

	{

	Kontostand = Kontostand - _withdraw;
	['geld', (_withdraw)] call INV_AddInvItem;
	player groupChat format[localize "STRS_bank_withdraw_yes", (_withdraw call OL_ISSE_str_IntToStr)];
	["money_withdraw", format ["%1 (%2) has withdrawn $%3 from their bank to money on hand at GRID: %4", player getVariable "RealName", getPlayerUID player, _withdraw, _gridPos]] call RM_fnc_LogToServer;

	} else {player groupChat localize "STRS_bank_no_money";};

};

sleep 2;
atmscriptrunning = 0;