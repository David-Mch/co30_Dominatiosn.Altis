// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_cdorevive.sqf"
#include "..\..\x_macros.sqf"

if (isDedicated) exitWith {};

player setVariable ["xr_cursorTarget", _this select 0];

call xr_fnc_dorevive;