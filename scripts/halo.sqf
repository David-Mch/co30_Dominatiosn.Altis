// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2018 509th.net *
// ******************************************************************************************
// @file Name: halo.sqf
// @file Author: Unknown
// @file Edit: [509th] Coyote Rogue on 5/28/2018
// @description: Provides ability for player to teleport via parachute
// @deployment: Place the following in the init of any object: halo = this addAction [""<t color='#00ffff'>HALO Jump</t> "", ""scripts\halo.sqf"", [false,600,70], 5, true, true, """",""alive _target""];

_host = _this select 0;
_caller = _this select 1;
_id = _this select 2;
_params = _this select 3;
_typehalo = _params select 0;//true for all group, false for player only.
_althalo = _params select 1;//altitude of halo jump
_altchute = _params select 2;//altitude for autochute deployment

if (not alive _host) exitwith {
hint "Halo Not Available"; 
_host removeaction _id;
};

if (vehicle _caller == _caller) then {
//Unit(s) not in aircraft
	private ["_pos"];
	
	_caller groupchat "Click on the map where you want to jump";

	openMap true;

	mapclick = false;

	onMapSingleClick "clickpos = _pos; mapclick = true; onMapSingleClick """";true;";

	waituntil {mapclick or !(visiblemap)};
	
	if (!visibleMap) exitwith {
		_caller groupchat "Not gonna jump today?!";
	};
	_pos = clickpos;

openMap false;	
	
	if (_typehalo) then {
	
		_grp1 = group _caller;
		{
			_x setpos [_pos select 0, _pos select 1, _althalo];
			_x spawn CR_fnc_emergencyeject;
		} foreach units _grp1;

	} else {
	
		_caller setpos [_pos select 0, _pos select 1, _althalo];
		_caller spawn CR_fnc_emergencyeject;

	};

} else {
//Unit(s) in aircraft
	
	if (_typehalo) then {
	
		_grp1 = group _caller;
		
		{
			_x allowdamage false;
			unassignVehicle (_x);
			(_x) action ["EJECT", vehicle _x];
			_x spawn CR_fnc_emergencyeject;
			sleep 0.5;
			_x allowdamage true;
		} foreach units _grp1;

	} else {

		_caller allowdamage false;
		unassignVehicle (_caller);
		(_caller) action ["EJECT", vehicle _caller];
		_caller spawn CR_fnc_emergencyeject;
		sleep 0.5;
		_caller allowdamage true;

	};
};