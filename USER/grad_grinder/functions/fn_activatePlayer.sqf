player setVariable ["grad_grinder_active", true, true];

private _identifier = format ["grad_grinder_%1_%2", position player, CBA_missionTime];
[_identifier, player] remoteExec ["grad_grinder_fnc_activateClients"];

[player, 150] call TFAR_ai_hearing_fnc_revealInArea;

[{
	params ["_args", "_handle"];
	_args params ["_identifier"];
	
	if (!(player getVariable ["grad_grinder_active", false])) exitWith {
		[_handle] call CBA_fnc_removePerFrameHandler;
		missionNameSpace setVariable [_identifier, [], true]; // remove framehandler from clients
	};
	

	private _eyePos = AGLToASL positionCameraToWorld [0,0,0];
	private _endPos = AGLToASL positionCameraToWorld [0,0,2];
	_ins = lineIntersectsSurfaces [ 
		_eyePos, 
		_endPos, 
		player, 
		objNull, 
		true, 
		1, 
		"VIEW", 
		"NONE" 
	]; 

	if (!isGameFocused) exitWith {};
	if (count _ins == 0) exitWith {}; 
	_ins#0 params ["_posASL", "_surfaceNormal", "_intersectObject"];

	if (typeOf _intersectObject == "land_gm_tanktrap_02") then {

		private _healthPerFrame = 0.005;
		private _health = _intersectObject getVariable ["grad_grinder_tanktrap_health", 1];
		private _newHealth = _health - _healthPerFrame;
		// systemChat str _newHealth;
		_intersectObject setVariable ["grad_grinder_tanktrap_health", _newHealth];

		if (_newHealth < 0.1) exitWith {
			
			[getPos _intersectObject] call grad_grinder_fnc_trapDestroy;
			[player, "grinder_destroy"] remoteExec ["say3d"];

			deleteVehicle _intersectObject;
			[_handle] call CBA_fnc_removePerFrameHandler;

			missionNameSpace setVariable [_identifier, [], true]; 
		};

		private _direction = _eyePos vectorDiff _posASL;
		_normalizedDirection = vectorNormalized _direction;

		private _distance = 0.1; // Adjust this value as needed
		private _finalPoint = _posASL vectorAdd (_normalizedDirection vectorMultiply _distance);

		missionNameSpace setVariable [_identifier, [_posASL, _surfaceNormal, _intersectObject, _finalPoint], true];

		private _soundActive = player getVariable ["grad_grinder_soundActive", objNull];

		if (isNull _soundActive) then {
			deleteVehicle (player getVariable ["grad_grinder_soundIdle", objNull]);
			
			private _activeSound = createSoundSource ["sfxgrinderactive", player, [], 0];
			_activeSound attachTo [player, [0,0,0], "righthand", true];
			player setVariable ["grad_grinder_soundActive", _activeSound];
		};
		
	} else {
		missionNameSpace setVariable [_identifier, [[0,0,0], [0,0,0], objNull, [0,0,0]], true];

		private _soundActive = player getVariable ["grad_grinder_soundActive", objNull];
		if (!isNull _soundActive) then {
			deleteVehicle _soundActive;
		};
	};
}, 0, [_identifier]] call CBA_fnc_addPerFrameHandler;