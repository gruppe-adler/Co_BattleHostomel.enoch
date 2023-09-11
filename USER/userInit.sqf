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


grad_hostomel_smoke = {
  [_this select 0,[0.45,0.67,0.5,0]] spawn {
      _sh=_this select 0;
      _col=_this select 1;
      _c1=_col select 0;
      _c2=_col select 1;
      _c3=_col select 2;
      
      sleep (20+random 1);
      _source = "#particlesource" createVehicleLocal getpos _sh;
      _source setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 7, 48], "", "Billboard", 1, 20, [0, 0, 0],
                      [0.2, 0.1, 0.1], 0, 1.277, 1, 0.025, [0.1, 2, 6], [[_c1, _c2, _c3, 0.2], [_c1, _c2, _c3, 0.05], [_c1, _c2, _c3, 0]],
                       [1.5,0.5], 1, 0.04, "", "", _sh];
      _source setParticleRandom [2, [0, 0, 0], [0.25, 0.25, 0.25], 0, 0.5, [0, 0, 0, 0.1], 0, 0, 10];
      _source setDropInterval 0.50;
      
      _source2 = "#particlesource" createVehicleLocal getpos _sh;
      _source2 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 8, 0], "", "Billboard", 1, 20, [0, 0, 0],
                      [0.2, 0.1, 0.1], 0, 1.277, 1, 0.025, [0.1, 2, 6], [[_c1, _c2, _c3, 1], [_c1, _c2, _c3, 0.5], [_c1, _c2, _c3, 0]],
                       [0.2], 1, 0.04, "", "", _sh];
      _source2 setParticleRandom [2, [0, 0, 0], [0.25, 0.25, 0.25], 0, 0.5, [0, 0, 0, 0.2], 0, 0, 360];
      _source2 setDropInterval 0.50;
      
      sleep (50+random 5);
      deletevehicle _source;
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

// Mi24 Flyby 
[
	"Hostomel Heli Flyby",
	"3 Mi24",
	{ 
		params ["_modulePosition"]; 
		
		{
			private _index = _forEachIndex;
			[[_x, _index], "USER\heliDrops\mi24_flyby.sqf"] remoteExec ["BIS_fnc_execVM", 2];
		} forEach [
			"mi24_flyby_1.sqf",
			"mi24_flyby_2.sqf",
			"mi24_flyby_3.sqf"
		];
	}
] call zen_custom_modules_fnc_register;

[
	"Hostomel Heli Flyby",
	"2 Mi24",
	{ 
		params ["_modulePosition"]; 
		
		private _helis = [
			"mi24_flyby_1.sqf",
			"mi24_flyby_2.sqf",
			"mi24_flyby_3.sqf"
		];
		
		[_helis, true] call CBA_fnc_shuffle;
		_helis resize 2;

		{
			private _index = _forEachIndex;
			[[_x, _index], "USER\heliDrops\mi24_flyby.sqf"] remoteExec ["BIS_fnc_execVM", 2];
		} forEach _helis;
	}
] call zen_custom_modules_fnc_register;

[
	"Hostomel Heli Flyby",
	"1 Mi24",
	{ 
		params ["_modulePosition"]; 

		private _helis = [
			"mi24_flyby_1.sqf",
			"mi24_flyby_2.sqf",
			"mi24_flyby_3.sqf"
		];
		
		[_helis, true] call CBA_fnc_shuffle;
		_helis resize 1;
		
		{
			private _index = _forEachIndex;
			[[_x, _index], "USER\heliDrops\mi24_flyby.sqf"] remoteExec ["BIS_fnc_execVM", 2];
		} forEach _helis;
	}
] call zen_custom_modules_fnc_register;


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
	"Hostomel Planes",
	"1 SU25 from River",
	{ 
		params ["_modulePosition"]; 

		private _su25 = [
			"su25_left.sqf"
		];

		[_su25, true] call CBA_fnc_shuffle;
		_su25 resize 1;
		
		{
			private _index = _forEachIndex;
			[[_x, _index], "USER\heliDrops\su25_flyby.sqf"] remoteExec ["BIS_fnc_execVM", 2];
		} forEach _su25;
	}
] call zen_custom_modules_fnc_register;


[
	"Hostomel Planes",
	"1 SU25 over landing stripe",
	{ 
		params ["_modulePosition"]; 

		private _su25 = [
			"su25_center.sqf"
		];

		[_su25, true] call CBA_fnc_shuffle;
		_su25 resize 1;
		
		{
			private _index = _forEachIndex;
			[[_x, _index], "USER\heliDrops\su25_flyby.sqf"] remoteExec ["BIS_fnc_execVM", 2];
		} forEach _su25;
	}
] call zen_custom_modules_fnc_register;

[
	"Hostomel Planes",
	"1 SU25 right",
	{ 
		params ["_modulePosition"]; 

		private _su25 = [
			"su25_right.sqf"
		];

		[_su25, true] call CBA_fnc_shuffle;
		_su25 resize 1;
		
		{
			private _index = _forEachIndex;
			[[_x, _index], "USER\heliDrops\su25_flyby.sqf"] remoteExec ["BIS_fnc_execVM", 2];
		} forEach _su25;
	}
] call zen_custom_modules_fnc_register;


[
	"Hostomel Helicopter",
	"1 KA52 right",
	{ 
		params ["_modulePosition"]; 

		private _ka52 = [
			"ka52_flyby_1.sqf"
		];

		[_ka52, true] call CBA_fnc_shuffle;
		_ka52 resize 1;
		
		{
			private _index = _forEachIndex;
			[[_x, _index], "USER\heliDrops\su25_flyby.sqf"] remoteExec ["BIS_fnc_execVM", 2];
		} forEach _ka52;
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


[
	"Hostomel",
	"Supply Drop BMD",
	{ 
		params ["_modulePosition"]; 
		
		[["rhs_bmd4m_vdv", ASLtoAGL _modulePosition], "USER\heliDrops\supplyDrop.sqf"] remoteExec ["BIS_fnc_execVM", 2];
	}
] call zen_custom_modules_fnc_register;

[
	"Hostomel",
	"Supply Drop BMD 2K",
	{ 
		params ["_modulePosition"]; 
		
		[["rhs_bmd2k", ASLtoAGL _modulePosition], "USER\heliDrops\supplyDrop.sqf"] remoteExec ["BIS_fnc_execVM", 2];
	}
] call zen_custom_modules_fnc_register;

[
	"Hostomel",
	"Supply Drop BMP2K",
	{ 
		params ["_modulePosition"]; 
		
		[["rhs_bmp2k_vdv", ASLtoAGL _modulePosition], "USER\heliDrops\supplyDrop.sqf"] remoteExec ["BIS_fnc_execVM", 2];
	}
] call zen_custom_modules_fnc_register;

[
	"Hostomel",
	"Supply Drop PRP3",
	{ 
		params ["_modulePosition"]; 
		
		[["rhs_prp3_vdv", ASLtoAGL _modulePosition], "USER\heliDrops\supplyDrop.sqf"] remoteExec ["BIS_fnc_execVM", 2];
	}
] call zen_custom_modules_fnc_register;