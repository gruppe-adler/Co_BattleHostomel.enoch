["RHS_Mi24_base", "killed", {
	params ["_unit"];

	if (local _unit) then {
		[{
			[position _this, random 360] remoteExec ["grad_debris_fnc_debrisClient", 0, false];
			private _ammo = "DemoCharge_Remote_Ammo_Scripted" createVehicle position _this;
			_ammo setDamage 1;
			
			deleteVehicle _this;			
		}, _unit, (300 + random 60)] call CBA_fnc_waitAndExecute;
	};

}, true, [], true] call CBA_fnc_addClassEventHandler;

["RHS_Mi8_base", "killed", {
	params ["_unit"];

	if (local _unit) then {
		[{
			[position _this, random 360] remoteExec ["grad_debris_fnc_debrisClient", 0, false];
			private _ammo = "DemoCharge_Remote_Ammo_Scripted" createVehicle position _this;
			_ammo setDamage 1;

			deleteVehicle _this;			
		}, _unit, (300 + random 60)] call CBA_fnc_waitAndExecute;
	};

}, true, [], true] call CBA_fnc_addClassEventHandler;
