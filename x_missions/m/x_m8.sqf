// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m8.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[6223.51,4626.85,0]]; // index: 8,   Radio tower near Nadezhdino
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1815";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_727";
};

if (call d_fnc_checkSHC) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle [d_illum_tower, _poss, [], 0, "NONE"];
	_vec setPos _poss;
	_vec setVectorUp [0,0,1];
	_vec call d_fnc_addKilledEHSM;
	sleep 2.22;
	["specops", 1, "allmen", 2, _poss, 0] spawn d_fnc_CreateInf;
};