// by Xeno
//#define __DEBUG__
#define THIS_FILE "init.sqf"
#include "x_setup.sqf"
diag_log [diag_frameno, diag_ticktime, time, "Executing Dom init.sqf"];

d_IS_HC_CLIENT = !isDedicated && {!hasInterface};
__TRACE_1("","d_IS_HC_CLIENT")

if (isDedicated) then {disableRemoteSensors true};

if (isMultiplayer && {hasInterface}) then {
	enableRadio false;
	showChat false;
	0 fadeSound 0;
	titleText ["", "BLACK FADED"];
};

enableSaving [false,false];
enableTeamSwitch false;

addMissionEventhandler ["EachFrame", {
	if (isNil "d_init_processed") then {
		call compile preprocessFileLineNumbers "d_init.sqf";
	};
	removeMissionEventHandler ["EachFrame", _thisEventHandler];
}];

diag_log [diag_frameno, diag_ticktime, time, "Dom init.sqf processed"];


"ColorCorrections" ppEffectEnable true;
"ColorCorrections" ppEffectAdjust [0.88, 0.88, 0, [0.2, 0.29, 0.4, -0.22], [1, 1, 1, 1.3], [0.15, 0.09, 0.09, 0.0]];
"ColorCorrections" ppEffectCommit 0;