params ["_filename"];

private _type = "RHS_Mi8mt_Cargo_vdv";
private _mi8 = [[0,0,0], -152, _type, east] call BIS_fnc_spawnVehicle;

// systemchat str _mi8;
private _recording = call compile loadFile ("USER\heliDrops\" + _filename);

[_mi8,  _recording] spawn BIS_fnc_unitPlay;

private _group = creategroup east;
{
	private _unit = _group createUnit [_x, [0,0,0], [], 0, "NONE"];
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

[{
	params ["_mi8", "_group"];
	private _position = getPosATL _mi8;
	_position#2 < 2 && speed _mi8 < 3
},{
	params ["_mi8", "_group"];
    doGetOut units _group;
	[_group] spawn {
		params ["_group"];
		{ moveOut _x; sleep random 0.1; } forEach units _group;
	};
	
}, [_mi8, _group]] call CBA_fnc_waitUntilAndExecute;
