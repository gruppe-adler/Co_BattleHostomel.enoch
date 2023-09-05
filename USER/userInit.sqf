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
