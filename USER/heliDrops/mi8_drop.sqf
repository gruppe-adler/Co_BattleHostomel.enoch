params ["_filename", "_index"];

private _type = selectRandom [
	"RHS_Mi8mt_Cargo_vdv",
	"RHS_Mi8mtv3_Cargo_vdv",
	"RHS_Mi8MTV3_heavy_vdv",
	"RHS_Mi8mt_vdv"
];
private _mi8 = [[_index * 200, _index * 200, 200], -152, _type, east] call BIS_fnc_spawnVehicle;
_mi8 params ["_mi8"];

[[_mi8], "USER\heliDrops\endPlaybackAction.sqf"] remoteExec ["BIS_fnc_execVM", 0];

// systemchat str _mi8;
private _recording = call compile loadFile ("USER\heliDrops\" + _filename);

[_mi8,  _recording, [_mi8, "unitPlayDone"]] spawn BIS_fnc_unitPlay;

private _group = creategroup east;

// fill slowly so lag spikes are circumvented
[_mi8, _group] spawn {
	params ["_mi8", "_group"];

	{
		private _unit = _group createUnit [_x, [0,0,0], [], 0, "NONE"];
		sleep 1;
	} forEach 
	[
		"rhs_vdv_sergeant",
		"rhs_vdv_efreitor",
		"rhs_vdv_arifleman",
		"rhs_vdv_arifleman",
		"rhs_vdv_arifleman",
		"rhs_vdv_arifleman",
		"rhs_vdv_arifleman",
		"rhs_vdv_machinegunner",
		"rhs_vdv_LAT",
		"rhs_vdv_at",
		"rhs_vdv_marksman",
		"rhs_vdv_medic",
		"rhs_vdv_LAT",
		"rhs_vdv_machinegunner_assistant",
		"rhs_vdv_LAT",
		"rhs_vdv_grenadier"
	];

	{
		_x assignAsCargo _mi8;
		_x moveInCargo _mi8;
	} forEach units _group; 
};




[{
	params ["_mi8", "_group"];
	!isTouchingGround _mi8
},{
	params ["_mi8", "_group"];
	[{
		params ["_mi8", "_group"];
		private _position = getPosATL _mi8;
		_position#1 < worldSize && _position#2 < 2 && speed _mi8 < 3
	},{
		params ["_mi8", "_group"];
		doGetOut units _group;
		[_group] spawn {
			params ["_group"];
			{ moveOut _x; sleep random 0.1; } forEach units _group;
		};
		
	}, [_mi8, _group]] call CBA_fnc_waitUntilAndExecute;

}, [_mi8, _group]] call CBA_fnc_waitUntilAndExecute;




[{
	params ["_mi8"];
	_mi8 getVariable ["unitPlayDone", false]
},{
	params ["_mi8"];

	if (alive _mi8 && canMove _mi8 && ((getPos _mi8) select 2 > worldsize)) then {
		deleteVehicleCrew _mi8;
		deleteVehicle _mi8;
	};

}, [_mi8]] call CBA_fnc_waitUntilAndExecute;
