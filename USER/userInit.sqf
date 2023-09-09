/*
*   Wird zum Missionsstart auf Server und Clients ausgeführt.
*   Funktioniert wie die init.sqf.
*/

// create hostomel location
private _terrainLocation = nearestLocation [[3990.1,10256.4,-67.9478], "NameLocal"]; 
_terrainLocation setType "Invisible";  
private _editableLocation = createLocation [_terrainLocation]; _editableLocation setType "Airport"; 
_editableLocation setText "Hostomel Airport";



// add white armbands to russians
["CAManBase", "init", {
	params ["_unit"];

	if (local _unit) then {
		if (side _unit == east) then {
			_unit linkItem "Armband_White_medium2_NVG";
		};
	};

}, true, [], true] call CBA_fnc_addClassEventHandler;


// add action to russian flags 
["rhs_Flag_Russia_F", "init", {
	params ["_flag"];

	_flag addAction
	[
		"Raise UA Flag",
		{
			player playAction "PutDown";
			sleep 0.5;
			(_this select 0) forceFlagTexture "data\flag_ua.paa";
			[_this select 0, flagAnimationPhase (_this select 0) + 0.2, 0.2] call BIS_fnc_animateFlag;
			_this select 0 removeAction (_this select 2);
		},
		"",
		10,
		true,
		true,
		"",
		"_this distance2D _target < 2"
	];

}, true, [], true] call CBA_fnc_addClassEventHandler;



// 
//Uncomment following if used as function
//params["_area", "_minMinesCount", "_maxMinesCount"];
//Uncomment following if used as script

grad_hostomel_fnc_createMineField =
{
	params ["_markerArea", "_minMinesCount", "_maxMinesCount"];

	_minesArray = ["gm_minestatic_ap_pfm1","gm_minestatic_at_tm46"];
	_minesCountInArea = random [_minMinesCount, _maxMinesCount/2, _maxMinesCount];
	_areaDimensions = getMarkerSize _markerArea;
	_minesPositionRange = _areaDimensions select 0;

	diag_log format ["mine count in area : %1", _minesCountInArea];

	//Creating random position and spawning mines
	for "_i" from 0 to _minesCountInArea - 1 do {
		_randomPos = [[_markerArea], ["water"]] call BIS_fnc_randomPos;
		_randomPos set [2, 0];
		private _mine = createMine [selectRandom _minesArray, _randomPos, [], 0];
		_mine enableDynamicSimulation true; 

		diag_log format ["created : %1", _mine];

		if (true) then {
			private _markerName = format ["%1_marker", _mine];
			private _pos = getPosATL _mine;
			private _marker = createMarker [_markerName, _pos];

			_marker setMarkerColor "ColorRED";
			_marker setMarkerType "mil_dot";
			_marker setMarkerShape "ICON";

			private _arrow = createVehicle ["Sign_Arrow_F", _pos, [], 0, "CAN_COLLIDE"];
		};
	};
};


if(isServer) then {
	// Markers into grass cutters script by Sa-Matra
	{
		if(
			markerShape _x == "RECTANGLE" &&
			toLower _x find "mrk_minefield" == 0
		) then {
			private _size = markerSize _x;
			_size params ["_xSize", "_ySize"];

			private _mineCount = (_xSize max _ySize)/1;
			[_x, floor _mineCount, floor (_mineCount + 20)] spawn grad_hostomel_fnc_createMineField;

			private _markerIconName = format ["mrk_iconName_%1", getMarkerPos _x];
			private _markerIcon = createMarker [_markerIconName, getMarkerPos _x];
			_markerIcon setMarkerColor "ColorRED";
			_markerIcon setMarkerType "mil_triangle";
			_markerIcon setMarkerShape "ICON";
			_markerIcon setMarkerText " Minefield";
		};
	} forEach allMapMarkers;
};