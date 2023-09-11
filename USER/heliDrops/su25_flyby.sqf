params ["_filename", "_index"];

private _type = selectRandom [
	"RHS_Su25SM_vvsc"
];
private _su25 = [[_index * 200, _index * 200, 200], -152, _type, east] call BIS_fnc_spawnVehicle;
_su25 params ["_su25"];

[[_su25], "USER\heliDrops\endPlaybackAction.sqf"] remoteExec ["BIS_fnc_execVM", 0];

// systemchat str _su25;
private _recording = call compile loadFile ("USER\heliDrops\" + _filename);

[_su25,  _recording, [_su25, "unitPlayDone"]] spawn BIS_fnc_unitPlay;


[{
	params ["_su25"];
	_su25 getVariable ["unitPlayDone", false]
},{
	params ["_su25"];

	if (alive _su25 && canMove _su25 && ((getPos _su25) select 2 > worldsize)) then {
		deleteVehicleCrew _su25;
		deleteVehicle _su25;
	};

}, [_su25]] call CBA_fnc_waitUntilAndExecute;
