

player addAction ["<t color='#FF0000'>Emergency Eject</t>",  CR_fnc_emergencyeject,[], 100, false, true, "eject", "(vehicle player) isKindOf 'Air' && !((vehicle player) isKindOf 'ParachuteBase')"],
player addAction ["<t color='#FF0000'>Open parachute</t>", CR_fnc_openParachute, [], 99, true, true, "", "vehicle player == player && (getPos player) select 2 > 2.5"],




//[] call compileFinal preprocessFileLineNumbers "ModdedVersion\scripts\3D_Markers_POI_init.sqf"; //load 3D Icons

//=========================== PILOTS ONLY

/*
if ((typeOf player) in [PILOT_CLASSES]) then {
	if (PARAMS_PilotRespawn isEqualTo 1) then {
		player setPosATL [((((getMarkerPos "respawn_pilot") select 0)+ 3)-(random 6)),((((getMarkerPos "respawn_pilot") select 1)+ 3)-(random 6)),0.1];
		player setDir (markerDir "respawn_pilot");
	};
	//===== UH-80 TURRETS
	if (PARAMS_UH80TurretControl != 0) then {
		inturretloop = false;
		UH80TurretAction = player addAction [(localize "STR_V16_INIT_ADDACTION_TURRETCONTROL"),QS_fnc_uh80TurretControl,[],-95,false,false,'','[] call QS_fnc_conditionUH80TurretControl'];
	};
};*/