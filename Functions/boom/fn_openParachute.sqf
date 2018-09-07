// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: fn_openParachute.sqf
//	@file Author: AgentRev

// make sure no crewed helicopters are within 10m, otherwise some will explode on contact with the parachute
#define PARACHUTE_PRECHECK ({player distance _x < 10 max sizeOf typeOf _x && count crew _x > 0} count (player nearEntities ["Helicopter_Base_F", 20]) == 0)

if (PARACHUTE_PRECHECK) then CR_fnc_forceOpenParachute
