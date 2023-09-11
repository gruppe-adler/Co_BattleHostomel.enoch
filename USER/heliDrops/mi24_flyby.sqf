params ["_filename", "_index"];

private _type = selectRandom [
	"RHS_Mi24P_vdv",
	"RHS_Mi24V_vdv"
];
private _mi24 = [[_index * 200, _index * 200, 200], -152, _type, east] call BIS_fnc_spawnVehicle;
_mi24 params ["_mi24"];

[[_mi24], "USER\heliDrops\endPlaybackAction.sqf"] remoteExec ["BIS_fnc_execVM", 0];

// systemchat str _mi24;
private _recording = call compile loadFile ("USER\heliDrops\" + _filename);

[_mi24,  _recording, [_mi24, "unitPlayDone"]] spawn BIS_fnc_unitPlay;


[{
	params ["_mi24"];
	_mi24 getVariable ["unitPlayDone", false]
},{
	params ["_mi24"];

	if (alive _mi24 && canMove _mi24 && ((getPos _mi24) select 2 > worldsize)) then {
		deleteVehicleCrew _mi24;
		deleteVehicle _mi24;
	};

}, [_mi24]] call CBA_fnc_waitUntilAndExecute;
