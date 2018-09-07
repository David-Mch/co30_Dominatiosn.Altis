/*
@filename: fn_vSetup02.sqf
Author:

	???
	
Last modified:

	5/09/2017 by stanhope
	
modified:
	
tweaked random loadouts
	
Description:

	Apply code to vehicle
	vSetup02 deals with code that is already applied where it should be.
_______________________________________________*/

//============================================= CONFIG

private ["_u","_t","_camo","_missilepod","_doorstatus","_innerpylon","_AMRAAMcount","_outerpylon","_wingtipAA","_middlepylon","_rocketpod","_missilepod","_bombs"];

_u = _this select 0;
_t = typeOf _u;

if (isNull _u) exitWith {};

//============================================= ARRAYS
//===jets===
_Neophron = ["O_Plane_CAS_02_F","O_Plane_CAS_02_dynamicLoadout_F"];





//===== qilin black skin

if (_t in _Neophron) then {
	_u setObjectTextureGlobal[0, 'media\images\vskins\to199\russia_fighter02_ext01.paa'];
	_u setObjectTextureGlobal[1, 'media\images\vskins\to199\russia_fighter02_ext02.paa'];

};