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
{
	private _flag = _x;

	(_flag) forceFlagTexture "rhsafrf\addons\rhs_main\data\flag_rus_co.paa";

	_flag addAction
	[
		"Raise UA Flag",
		{
			private _flag = _this select 0;
			player playAction "PutDown";
			_flag removeAction (_this select 2);
			sleep 0.5;
			[_flag, 0] call BIS_fnc_animateFlag;
			waitUntil { flagAnimationPhase _flag < 0.1 };
			(_flag) forceFlagTexture "data\flag_ua.paa";
			[_flag, 1] call BIS_fnc_animateFlag;

			_flag setVariable ["flagRaisedUA", true, true];
		},
		"",
		10,
		true,
		true,
		"",
		"_this distance2D _target < 2 && !(_target getVariable ['flagRaisedUA', false])"
	];


	_flag addAction
	[
		"Raise Russian Flag",
		{
			private _flag = _this select 0;
			player playAction "PutDown";
			_flag removeAction (_this select 2);
			sleep 0.5;
			[_flag, 0] call BIS_fnc_animateFlag;
			waitUntil { flagAnimationPhase _flag < 0.1 };
			(_flag) forceFlagTexture "rhsafrf\addons\rhs_main\data\flag_rus_co.paa";
			[_flag, 1] call BIS_fnc_animateFlag;

			_flag setVariable ["flagRaisedUA", false, true];
		},
		"",
		10,
		true,
		true,
		"",
		"_this distance2D _target < 2 && (_target getVariable ['flagRaisedUA', false])"
	];

} forEach allMissionObjects "rhs_Flag_Russia_F";



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

	// diag_log format ["mine count in area : %1", _minesCountInArea];

	//Creating random position and spawning mines
	for "_i" from 0 to _minesCountInArea - 1 do {
		_randomPos = [[_markerArea], ["water"]] call BIS_fnc_randomPos;
		_randomPos set [2, 0];
		private _mine = createMine [selectRandom _minesArray, _randomPos, [], 0];
		_mine enableDynamicSimulation true; 

		// diag_log format ["created : %1", _mine];

		if (false) then {
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

// NORTH 
[
	"Hostomel Helis North",
	"4 Helis from North",
	{ 
		params ["_modulePosition"]; 
		
		{
			private _index = _forEachIndex;
			[[_x, _index], "USER\heliDrops\mi8_drop.sqf"] remoteExec ["BIS_fnc_execVM", 2];
		} forEach [
			"mi8_north_1.sqf",
			"mi8_north_2.sqf",
			"mi8_north_3.sqf",
			"mi8_north_4.sqf"
		];
	}
] call zen_custom_modules_fnc_register;

[
	"Hostomel Helis North",
	"3 Helis from North",
	{ 
		params ["_modulePosition"]; 
		
		private _helis = [
			"mi8_north_1.sqf",
			"mi8_north_2.sqf",
			"mi8_north_3.sqf",
			"mi8_north_4.sqf"
		];
		
		[_helis, true] call CBA_fnc_shuffle;
		_helis resize 3;

		{
			private _index = _forEachIndex;
			[[_x, _index], "USER\heliDrops\mi8_drop.sqf"] remoteExec ["BIS_fnc_execVM", 2];
		} forEach _helis;
	}
] call zen_custom_modules_fnc_register;

[
	"Hostomel Helis North",
	"2 Helis from North",
	{ 
		params ["_modulePosition"]; 
		
		private _helis = [
			"mi8_north_1.sqf",
			"mi8_north_2.sqf",
			"mi8_north_3.sqf",
			"mi8_north_4.sqf"
		];
		
		[_helis, true] call CBA_fnc_shuffle;
		_helis resize 2;

		{
			private _index = _forEachIndex;
			[[_x, _index], "USER\heliDrops\mi8_drop.sqf"] remoteExec ["BIS_fnc_execVM", 2];
		} forEach _helis;
	}
] call zen_custom_modules_fnc_register;

[
	"Hostomel Helis North",
	"1 Heli from North",
	{ 
		params ["_modulePosition"]; 
		
		private _helis = [
			"mi8_north_1.sqf",
			"mi8_north_2.sqf",
			"mi8_north_3.sqf",
			"mi8_north_4.sqf"
		];
		
		[_helis, true] call CBA_fnc_shuffle;
		_helis resize 1;

		{
			private _index = _forEachIndex;
			[[_x, _index], "USER\heliDrops\mi8_drop.sqf"] remoteExec ["BIS_fnc_execVM", 2];
		} forEach _helis;
	}
] call zen_custom_modules_fnc_register;


// CENTER
[
	"Hostomel Helis Center",
	"4 Helis from Center",
	{ 
		params ["_modulePosition"]; 

		private _helis = [
			"mi8_center_1.sqf",
			"mi8_center_2.sqf",
			"mi8_center_3.sqf",
			"mi8_center_4.sqf"
		];
		
		{
			private _index = _forEachIndex;
			[[_x, _index], "USER\heliDrops\mi8_drop.sqf"] remoteExec ["BIS_fnc_execVM", 2];
		} forEach _helis;
	}
] call zen_custom_modules_fnc_register;

[
	"Hostomel Helis Center",
	"3 Helis from Center",
	{ 
		params ["_modulePosition"]; 

		private _helis = [
			"mi8_center_1.sqf",
			"mi8_center_2.sqf",
			"mi8_center_3.sqf",
			"mi8_center_4.sqf"
		];

		[_helis, true] call CBA_fnc_shuffle;
		_helis resize 3;
		
		{
			private _index = _forEachIndex;
			[[_x, _index], "USER\heliDrops\mi8_drop.sqf"] remoteExec ["BIS_fnc_execVM", 2];
		} forEach _helis;
	}
] call zen_custom_modules_fnc_register;

[
	"Hostomel Helis Center",
	"2 Helis from Center",
	{ 
		params ["_modulePosition"]; 

		private _helis = [
			"mi8_center_1.sqf",
			"mi8_center_2.sqf",
			"mi8_center_3.sqf",
			"mi8_center_4.sqf"
		];

		[_helis, true] call CBA_fnc_shuffle;
		_helis resize 2;
		
		{
			private _index = _forEachIndex;
			[[_x, _index], "USER\heliDrops\mi8_drop.sqf"] remoteExec ["BIS_fnc_execVM", 2];
		} forEach _helis;
	}
] call zen_custom_modules_fnc_register;

[
	"Hostomel Helis Center",
	"1 Heli from Center",
	{ 
		params ["_modulePosition"]; 

		private _helis = [
			"mi8_center_1.sqf",
			"mi8_center_2.sqf",
			"mi8_center_3.sqf",
			"mi8_center_4.sqf"
		];

		[_helis, true] call CBA_fnc_shuffle;
		_helis resize 1;
		
		{
			private _index = _forEachIndex;
			[[_x, _index], "USER\heliDrops\mi8_drop.sqf"] remoteExec ["BIS_fnc_execVM", 2];
		} forEach _helis;
	}
] call zen_custom_modules_fnc_register;


[
	"Hostomel Helis River",
	"3 Helis from River",
	{ 
		params ["_modulePosition"]; 

		private _helis = [
			"mi8_river_1.sqf",
			"mi8_river_2.sqf",
			"mi8_river_3.sqf"
		];
		
		{
			private _index = _forEachIndex;
			[[_x, _index], "USER\heliDrops\mi8_drop.sqf"] remoteExec ["BIS_fnc_execVM", 2];
		} forEach _helis;
	}
] call zen_custom_modules_fnc_register;

[
	"Hostomel Helis River",
	"2 Helis from River",
	{ 
		params ["_modulePosition"]; 

		private _helis = [
			"mi8_river_1.sqf",
			"mi8_river_2.sqf",
			"mi8_river_3.sqf"
		];

		[_helis, true] call CBA_fnc_shuffle;
		_helis resize 2;
		
		{
			private _index = _forEachIndex;
			[[_x, _index], "USER\heliDrops\mi8_drop.sqf"] remoteExec ["BIS_fnc_execVM", 2];
		} forEach _helis;
	}
] call zen_custom_modules_fnc_register;

[
	"Hostomel Helis River",
	"1 Heli from River",
	{ 
		params ["_modulePosition"]; 

		private _helis = [
			"mi8_river_1.sqf",
			"mi8_river_2.sqf",
			"mi8_river_3.sqf"
		];

		[_helis, true] call CBA_fnc_shuffle;
		_helis resize 1;
		
		{
			private _index = _forEachIndex;
			[[_x, _index], "USER\heliDrops\mi8_drop.sqf"] remoteExec ["BIS_fnc_execVM", 2];
		} forEach _helis;
	}
] call zen_custom_modules_fnc_register;


[
	"Hostomel",
	"Fire Flares",
	{ 
		params ["_modulePosition"]; 
		
		private _helis = nearestObjects [(ASLtoAGL _modulePosition), ["Air"], 250];
		private _heli = objNull;
		if (count _helis > 0) then {
			_heli = _helis#0;
		};

		nul = [_heli] spawn 
		{ 
			params ["_heli"];

			for "_i" from 1 to 5 do 
			{ 
				(driver _heli) forceWeaponFire ["rhs_weap_CMDispenser_ASO2", "Burst"];
				_heli setVehicleAmmo 1;
				sleep (random 1 + 1); 
			}; 
		};
	}
] call zen_custom_modules_fnc_register;