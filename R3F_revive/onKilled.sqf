/**
 * Réaction à l'évènement killed : gère les effets, l'attente de soins, ...
 *
 * Copyright (C) 2011 madbull ~R3F~
 *
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

if (_this select 0 != player) exitWith {};

call GetRadioID;
execVM "ServerLoad\respawn.sqf";


// On ferme tout les fils d'exécution éventuels
terminate R3F_REV_fil_exec_attente_reanimation;
terminate R3F_REV_fil_exec_reapparaitre_camp;
terminate R3F_REV_fil_exec_effet_inconscient;

// Contexte interruptible et mémorisation du fil d'exécution lancé
R3F_REV_fil_exec_attente_reanimation = [] spawn
{
	private ["_position_avant_mort", "_hauteur_ATL_avant_mort", "_direction_avant_mort", "_chargeurs_avant_mort", "_armes_avant_mort", "_sacados_avant_mort", "_unit"];

	call OL_CheckWater;

	// Mémorisation des données du cadavre
	_position_avant_mort = getPos R3F_REV_corps_avant_mort;
	_hauteur_ATL_avant_mort = getPosATL R3F_REV_corps_avant_mort select 2;
	_direction_avant_mort = getDir R3F_REV_corps_avant_mort;
	_chargeurs_avant_mort = magazines R3F_REV_corps_avant_mort;
	_armes_avant_mort = weapons R3F_REV_corps_avant_mort;

	// OA 1.54+ seulement : récupération des infos du sac à dos du cadavre
	if !(isNil "R3F_REV_FNCT_obtenir_infos_sacados") then
	{
		_sacados_avant_mort = [R3F_REV_corps_avant_mort] call R3F_REV_FNCT_obtenir_infos_sacados;
	};

	closeDialog 0;

	call R3F_REV_FNCT_detruire_marqueur_inconscient;

	// Au cas où le joueur était en attente de réanimation lorsqu'il est mort,
	// informer tout le monde son cadavre n'est plus dans l'état inconscient
	R3F_REV_fin_inconscience = R3F_REV_corps_avant_mort;
	publicVariable "R3F_REV_fin_inconscience";
	["R3F_REV_fin_inconscience", R3F_REV_fin_inconscience] spawn R3F_REV_FNCT_fin_inconscience;
	R3F_REV_corps_avant_mort setVariable ["R3F_REV_est_inconscient", false, true];
	R3F_REV_corps_avant_mort setVariable ["R3F_REV_est_pris_en_charge_par", nil, true];

	sleep 2;

	// Effet de fondu en noir pour symbolisé la mort du joueur
	ppEffectDestroy R3F_REV_effet_video_flou;
	R3F_REV_effet_video_flou = ppEffectCreate ["DynamicBlur", 472];
	R3F_REV_effet_video_flou ppEffectEnable true;
	R3F_REV_effet_video_flou ppEffectAdjust [0.3+random 0.3];
	R3F_REV_effet_video_flou ppEffectCommit 2;

	ppEffectDestroy R3F_REV_effet_video_couleur;
	R3F_REV_effet_video_couleur = ppEffectCreate ["ColorCorrections", 1587];
	R3F_REV_effet_video_couleur ppEffectEnable true;
	R3F_REV_effet_video_couleur ppEffectAdjust [0.25, 1, 0, [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]];
	R3F_REV_effet_video_couleur ppEffectCommit 2;

	// Attendre que le nouveau corps apparaissent
	waitUntil {alive player};
	sleep 0.2;

	_unit = player;

	// Mémorisation de la position du joueur lors de la réapparition
	R3F_REV_position_reapparition = getPosATL _unit;

	if (R3F_REV_nb_reanimations > 0) then
	{
		// Isoler le nouveau corps
		_unit setPosATL [_position_avant_mort select 0, _position_avant_mort select 1, 2000];

		_unit setCaptive true;

		// Retrait de l'équipement
		removeAllWeapons _unit;
		removeAllItems _unit;

		// Couché sans arme dans les mains, posture blessé
		_unit switchMove "AdthPpneMstpSlowWrflDnon_binocular";

		// Restauration des armes d'avant le décès
		{_unit addMagazine _x;} forEach _chargeurs_avant_mort;
		{_unit addWeapon _x;} forEach _armes_avant_mort;

		// OA 1.54+ seulement : restaurer le sac à dos d'avant le décès ou le supprimer s'il n'en avait pas
		if !(isNil "R3F_REV_FNCT_assigner_sacados") then
		{
			[_unit, _sacados_avant_mort] call R3F_REV_FNCT_assigner_sacados;
		};

		// Si le joueur est blessé involontairement (explosion d'une carcasse, chute, ...), il n'est pas tué
		_unit setVariable
		[
			"R3F_REV_id_EH_HandleDamage",
			_unit addEventHandler ["HandleDamage",
			{
				private ["_victime", "_blessure", "_agresseur", "_munition"];
				_victime = _this select 0;
				_blessure = _this select 2;
				_agresseur = _this select 3;
				_munition = _this select 4;

				if (isNull _agresseur || _agresseur == _victime || _munition == "") then {0}
				else {_blessure};
			}],
			false
		];

		// Ouverture de la boîte de dialogue qui permet le respawn base et de désactivation les interactions in-game
		closeDialog 0;
		titleText [STR_R3F_REV_attente_reanimation, "PLAIN"];
		removeAllWeapons player;

		if (playerSide == west) then {
	      removeAllWeapons _unit;
	      removeAllItems _unit;
	      {_unit addMagazine _x;} forEach _chargeurs_avant_mort;
    		{_unit addWeapon _x;} forEach _armes_avant_mort;
	      _unit selectWeapon (primaryWeapon _unit);
	  };

		execVM "R3F_revive\time.sqf";
		sleep 5;

		// Ramener le nouveau corps au lieu du décès
		_unit setVelocity [0, 0, 0];
		_unit setDir _direction_avant_mort;
		_unit setPos [_position_avant_mort select 0, _position_avant_mort select 1, _hauteur_ATL_avant_mort - (_position_avant_mort select 2)];

		// Suppression de l'ancien corps
		if (R3F_REV_corps_avant_mort != _unit) then
		{deleteVehicle R3F_REV_corps_avant_mort;};

		// On mémorise le nouveau corps pour la prochaine fois que le joueur mourra
		R3F_REV_corps_avant_mort = _unit;

		// Informer tout le monde du début de l'état inconscient
		R3F_REV_nouvel_inconscient = _unit;
		publicVariable "R3F_REV_nouvel_inconscient";
		_unit setVariable ["R3F_REV_est_inconscient", true, true];
		_unit setVariable ["R3F_REV_est_pris_en_charge_par", nil, true];

		//call R3F_REV_FNCT_creer_marqueur_inconscient;

		// Fil d'exécution générant des effets visuels symbolisant l'état inconscient
		// Il sera terminé dès que le joueur aura reçu des soins
		R3F_REV_fil_exec_effet_inconscient = [] spawn
		{
			while {true} do
			{
				R3F_REV_effet_video_flou ppEffectAdjust [0.3+random 0.3];
				R3F_REV_effet_video_flou ppEffectCommit 0;

				R3F_REV_effet_video_couleur ppEffectAdjust [0.1+random 0.1, 0.4+random 0.2, 0, [1, 0, 0, 0], [1, 0, 0, 0], [1, 0, 0, 0]];
				R3F_REV_effet_video_couleur ppEffectCommit (2.2+random 0.4);
				sleep 4.2+random 0.7;

				R3F_REV_effet_video_couleur ppEffectAdjust [0.25, 1, 0, [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]];
				R3F_REV_effet_video_couleur ppEffectCommit (1.7+random 0.2);
				sleep (6+random 8);
			};
		};

		// Attente de réanimation
		while {_unit getVariable "R3F_REV_est_inconscient"} do
		{
			// Si on était traîné ou soigné par quelqu'un
			if !(isNil {_unit getVariable "R3F_REV_est_pris_en_charge_par"}) then
			{
				private ["_est_traite_par"];
				_est_traite_par = _unit getVariable "R3F_REV_est_pris_en_charge_par";

				// Mais que ce joueur est mort ou déconnecté
				if (isNull _est_traite_par || !alive _est_traite_par || !isPlayer _est_traite_par) then
				{
					detach _unit;
					if !(isNull _est_traite_par) then {detach _est_traite_par;};
					_unit switchMove "AinjPpneMstpSnonWrflDnon";
					_unit setVariable ["R3F_REV_est_pris_en_charge_par", nil, true];
				};
			};

			sleep 0.3;
		};

		call R3F_REV_FNCT_detruire_marqueur_inconscient;

		if (R3F_REV_CFG_revived_players_are_still_injured) then
		{
			// Le joueur réanimer est encore blessé par mesure de réalisme
			_unit setDamage 0.4;
		};

		// Retour en vue normale du jeu
		terminate R3F_REV_fil_exec_effet_inconscient;
		closeDialog 0;
		ppEffectDestroy R3F_REV_effet_video_flou;
		ppEffectDestroy R3F_REV_effet_video_couleur;

		sleep 0.2;
		// Sélection de l'arme
		_unit selectWeapon (primaryWeapon _unit);

		R3F_REV_nb_reanimations = R3F_REV_nb_reanimations - 1;

		_unit removeEventHandler ["HandleDamage", _unit getVariable "R3F_REV_id_EH_HandleDamage"];
		_unit setVariable ["R3F_REV_id_EH_HandleDamage", nil, false];

		// Il est de retour au combat, donc il n'est plus ignoré par l'IA
		_unit setCaptive false;

		if (R3F_REV_nb_reanimations > 0) then
		{
			if (R3F_REV_nb_reanimations > 1) then {titleText [format [STR_R3F_REV_nb_reanimations_plusieurs, R3F_REV_nb_reanimations], "PLAIN"];}
			else {titleText [format [STR_R3F_REV_nb_reanimations_une, R3F_REV_nb_reanimations], "PLAIN"];};
		}
		else {titleText [STR_R3F_REV_nb_reanimations_zero, "PLAIN"];};
	}
	else
	{
		titleText [STR_R3F_REV_plus_de_reanimation, "PLAIN"];

		if (!R3F_REV_CFG_autoriser_reapparaitre_camp) then
		{
			// Suppression de l'ancien corps
			if (R3F_REV_corps_avant_mort != _unit) then
			{deleteVehicle R3F_REV_corps_avant_mort;};

			if (R3F_REV_CFG_autoriser_camera) then
			{
				_unit execVM "";
			};

			// Rendre le corps mort sans activer son respawn
			_unit switchMove "AdthPpneMstpSrasWrflDnon_2";
			_unit setDamage 0.6;
			_unit setCaptive true;

			sleep 5;
			titleText [STR_R3F_REV_hors_jeu, "PLAIN"];
			sleep 2;
			ppEffectDestroy R3F_REV_effet_video_flou;
			ppEffectDestroy R3F_REV_effet_video_couleur;
		}
		else
		{
			R3F_REV_nb_reanimations = R3F_REV_CFG_nb_reanimations;

			/*/ Restauration des armes d'avant le décès
			removeAllWeapons _unit;
			removeAllItems _unit;
			{_unit addMagazine _x;} forEach _chargeurs_avant_mort;
			{_unit addWeapon _x;} forEach _armes_avant_mort;
			_unit selectWeapon (primaryWeapon _unit);
			*/
			// OA 1.54+ seulement : restaurer le sac à dos d'avant le décès ou le supprimer s'il n'en avait pas
			if !(isNil "R3F_REV_FNCT_assigner_sacados") then
			{
				[_unit, _sacados_avant_mort] call R3F_REV_FNCT_assigner_sacados;
			};

			// Retour du corps au marqueur de réapparition
			_unit setVelocity [0, 0, 0];
			_unit setPosATL R3F_REV_position_reapparition;
			sleep 5;
			titleText [STR_R3F_REV_respawn_camp, "PLAIN"];

			ppEffectDestroy R3F_REV_effet_video_flou;
			ppEffectDestroy R3F_REV_effet_video_couleur;
		};

		R3F_REV_corps_avant_mort = _unit;
	};
};
