// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_initadmindialog.sqf"
#include "..\..\..\x_setup.sqf"

if (isDedicated) exitWith {};

disableSerialization;

private _ctrl = (uiNamespace getVariable "d_AdminDialog") displayCtrl 1001;

lbClear _ctrl;
{
	private _index = _ctrl lbAdd (_x call d_fnc_getplayername);
	_ctrl lbSetData [_index, str _x];
} forEach ((allPlayers - entities "HeadlessClient_F") select {!isNull _x});

_ctrl lbSetCurSel 0;
ctrlSetFocus ((uiNamespace getVariable "d_AdminDialog") displayCtrl 1212);