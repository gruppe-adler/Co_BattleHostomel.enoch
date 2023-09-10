addUserActionEventHandler ["DefaultAction", "Activate", { 
    if (currentWeapon player == "hgun_esd_01_F" && !(player getVariable ["grad_grinder_active", false])) then {
        call grad_grinder_fnc_activatePlayer;		
    };
}];

// deactivate grinder
addUserActionEventHandler ["DefaultAction", "Deactivate", { 
    if (player getVariable ["grad_grinder_active", false]) then {
        player setVariable ["grad_grinder_active", false, true];

		deleteVehicle (player getVariable ["grad_grinder_soundActive", objNull]);

		if (!isNull (player getVariable ["grad_grinder_grinder", objNull])) then {
			private _idleSound = createSoundSource ["sfxgrinderidle", player, [], 0];
			_idleSound attachTo [player, [0,0,0], "righthand", true];
			player setVariable ["grad_grinder_soundIdle", _idleSound];
		};
    };    
}];

["weapon", {
	params ["_player", "_oldweapon", "_newweapon"];

	if (_oldweapon == "hgun_esd_01_F") then {
		private _grinderType = "Land_Grinder_F";

		private _grinder = _grinderType createVehicle [0,0,0];
		_grinder attachTo [player, [0,.1,0], "lefthand", true]; 
		_grinder setVectorDirAndUp  [[1,0,1], [1,0,0]];

		player setVariable ["grad_grinder_grinder", _grinder, true];

		deleteVehicle (player getVariable ["grad_grinder_soundIdle", objNull]);
		deleteVehicle (player getVariable ["grad_grinder_soundActive", objNull]);

		private _idleSound = createSoundSource ["sfxgrinderidle", player, [], 0];
		_idleSound attachTo [player, [0,0,0], "righthand", true];
		player setVariable ["grad_grinder_soundIdle", _idleSound];

	};

	if (_newweapon == "hgun_esd_01_F") then {
		private _grinder = player getVariable ["grad_grinder_grinder", objNull];
		
		deleteVehicle (player getVariable ["grad_grinder_soundIdle", objNull]);
		deleteVehicle (player getVariable ["grad_grinder_soundActive", objNull]);

		if (!isNull _grinder) then {
			deleteVehicle _grinder;
		};
	};

}] call CBA_fnc_addPlayerEventHandler;
