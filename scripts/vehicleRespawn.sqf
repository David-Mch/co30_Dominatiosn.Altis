/*  
==================================================================================================================
  Simple Vehicle Respawn Script v1.81 for Arma 3
  by Tophe of �stg�ta Ops [OOPS]
  
  Put this in the vehicles init line:
  veh = [this] execVM "scripts\vehicleRespawn.sqf"

  
  Options:
  There are some optional settings. The format for these are:
  veh = [object, Delay, Deserted timer, Respawns, Effect, Dynamic] execVM "scripts\vehicleRespawn.sqf"
  
  Default respawn delay is 30 seconds, to set a custom respawn delay time, put that in the init as well. 
  Like this:
  veh = [this, 15] execVM "scripts\vehicleRespawn.sqf"

  Default respawn time when vehicle is deserted, but not destroyed is 120 seconds. To set a custom timer for this 
  first set respawn delay, then the deserted vehicle timer. (0 = disabled) 
  Like this:  
  veh = [this, 15, 10] execVM "scripts\vehicleRespawn.sqf"

  By default the number of respawns is infinite. To set a limit first set preceding values then the number of respawns you want (0 = infinite).
  Like this:
  veh = [this, 15, 10, 5] execVM "scripts\vehicleRespawn.sqf"

  Set this value to TRUE to add a special explosion effect to the wreck when respawning.
  Default value is FALSE, which will simply have the wreck disappear.
  Like this:
  veh = [this, 15, 10, 5, TRUE] execVM "scripts\vehicleRespawn.sqf"
  
  By default the vehicle will respawn to the point where it first was when the mission started (static). 
  This can be changed to dynamic. Then the vehicle will respawn to the position where it was destroyed. 
  First set all preceding values then set TRUE for dynamic or FALSE for static.
  Like this:
  veh = [this, 15, 10, 5, TRUE, TRUE] execVM "scripts\vehicleRespawn.sqf"
  
  If you you want to set the INIT field of the respawned vehicle, first set all other values, then set init commands. 
  Those must be inside quotations.
  Like this:
  veh = [this, 15, 10, 5, TRUE, FALSE, "this setDammage 0.5"] execVM "scripts\vehicleRespawn.sqf"
  
  Default values of all settings are:
  veh = [this, 60, 600, 0, FALSE, FALSE] execVM "scripts\vehicleRespawn.sqf"
	
Contact & Bugreport: cwadensten@gmail.com
================================================================================================================== */
  

private ["_hasname","_delay","_deserted","_respawns","_noend","_dead","_nodelay","_timeout","_position","_dir","_effect","_rounds","_run","_unit","_explode","_dynamic","_unitinit","_haveinit","_unitname","_type"];
if (!isServer) exitWith {};

// Define variables
_unit = _this select 0;
_delay = if (count _this > 1) then {_this select 1} else {30};
_deserted = if (count _this > 2) then {_this select 2} else {120};
_respawns = if (count _this > 3) then {_this select 3} else {0};
_explode = if (count _this > 4) then {_this select 4} else {false};
_dynamic = if (count _this > 5) then {_this select 5} else {false};
_unitinit = if (count _this > 6) then {_this select 6} else {};
_haveinit = if (count _this > 6) then {true} else {false};

_hasname = false;
_unitname = vehicleVarName _unit;
if (isNil _unitname) then {_hasname = false;} else {_hasname = true;};
_noend = true;
_run = true;
_rounds = 0;

if (_delay < 0) then {_delay = 0};
if (_deserted < 0) then {_deserted = 0};
if (_respawns <= 0) then {_respawns= 0; _noend = true;};
if (_respawns > 0) then {_noend = false};

_dir = getDir _unit;
_position = getPosASL _unit;
_type = typeOf _unit;
_dead = false;
_nodelay = false;


// Start monitoring the vehicle
while {_run} do 
{	
  sleep (5 + (random 20));
  if ((getDammage _unit > 0.8) and ({alive _x} count crew _unit == 0)) then {_dead = true};
/*
	// Check if the vehicle is deserted.
	if (_deserted > 0) then
	{
    _nearPlayers = false;
    {
      if ((_x distance _unit) < PARAMS_VehicleRespawnDistance) exitWith { _nearPlayers = true; };
    } forEach playableUnits;
		if ((getPosASL _unit distance _position > 10) and ({alive _x} count crew _unit == 0) and (getDammage _unit < 0.8) and !_nearPlayers) then 
		{
			_timeout = time + _deserted;
			sleep 0.1;
		 	waitUntil {_timeout < time or !alive _unit or {alive _x} count crew _unit > 0};
			if ({alive _x} count crew _unit > 0) then {_dead = false}; 
			if ({alive _x} count crew _unit == 0) then {_dead = true; _nodelay =true}; 
			if !(alive _unit) then {_dead = true; _nodelay = false}; 
		};
	};
*/
	
	// Respawn vehicle
  if (_dead) then 
	{	
		if (_nodelay) then {sleep 0.1; _nodelay = false;} else {sleep _delay;};
		if (_dynamic) then {_position = getPosASL _unit; _dir = getDir _unit;};
		if (_explode) then {_effect = "M_AT" createVehicle getPosASL _unit; _effect setPosASL getPosASL _unit;};
		sleep 0.1;

		deleteVehicle _unit;
		sleep 2;
		_unit = _type createVehicle _position;
		
// Add flares to MH-9s and guns to jets upon respawn
switch (true) do
{
	case ({_unit isKindOf _x} count ["B_Heli_Light_01_F", "B_Heli_Light_01_armed_F"] > 0):
	{

		_unit addWeaponTurret ["CMFlareLauncher", [-1]];
		_unit addMagazineTurret ["120Rnd_CMFlare_Chaff_Magazine", [-1]];
	};
	case (_unit isKindOf "Plane_Fighter_03_base_F"):
	{
		_unit addMagazineTurret ["300Rnd_20mm_shells", [-1]];
	};
	case ({_unit isKindOf _x} count ["Box_NATO_AmmoVeh_F", "I_truck_02_ammo_F", "Box_T_NATO_WpsSpecial_F"] > 0):
	{
		[_unit,"CR_fnc_addActionVABox",true,true] spawn BIS_fnc_MP;		
	};
};			
		_unit setPosASL _position;
		_unit setDir _dir;
		_unit setVariable ["safe_from_cleanup",true,false];
		[_unit] call AW_fnc_vSetup02;
		_dead = false;

		// Check respawn amount
		if !(_noend) then {_rounds = _rounds + 1};
		if ((_rounds == _respawns) and !(_noend)) then {_run = false;};
	};
};