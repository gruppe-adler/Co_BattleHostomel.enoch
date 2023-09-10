params ["_posASL", "_surfaceNormal", "_intersectObject", "_unit"];

private _duration = 0.01 + random 0.1;
private _amount = 0.001 + random 0.01;
private _lifetime = 1+(random 0.5);
private _spark = "#particlesource" createVehicleLocal ASLtoAGL _posASL;

_spark setParticleCircle [0, [0, 0, 0]];
_spark setParticleRandom [1, [0, 0, 0], [0.4, 0.4, -0.3], 0, 0.0025, [0, 0, 0, 0], 0, 0];
_spark setParticleParams [
	["\A3\data_f\proxies\muzzle_flash\muzzle_flash_silencer.p3d", 1, 0, 1], "", "SpaceObject",
	1, _lifetime, [0, 0, 0], [0, 0, -0.1], 0, 20, 7.9, 0, 
	[0.3,0.3,0.05], [[1, 1, 1, 1], [1, 0.5, 0.5, 1], [0.5, 0, 0, 0]], [0.08], 1, 0, "", "", _spark,0,true,0.2,[[10,5,5,1]]
];
_spark setDropInterval _amount; 

[{
	deleteVehicle _this;
}, _spark, _duration] call CBA_fnc_waitAndExecute;



private _sparkSmall = "#particlesource" createVehicleLocal ASLtoAGL _posASL;

_sparkSmall setParticleCircle [0, [0, 0, 0]];
_sparkSmall setParticleRandom [1, [0, 0, 0], [8, 8, 3], 0, 0.0025, [0, 0, 0, 0], 0, 0];
_sparkSmall setParticleParams [
	["\A3\data_f\proxies\muzzle_flash\muzzle_flash_silencer.p3d", 1, 0, 1], "", "SpaceObject",
	1, _lifetime, [0, 0, 0], [0, 0, -0.1], 0, 20, 7.9, 0, 
	[0.3,0.1,0.05], [[1, 1, 1, 1], [1, 0.5, 0.5, 1], [0.5, 0, 0, 0]], [0.08], 1, 0, "", "", _sparkSmall,0,true,0.2,[[10,5,5,1],[10,5,5,1],[1,.1,.1,0]]
];
_sparkSmall setDropInterval _amount*2; 

[{
	deleteVehicle _this;
}, _sparkSmall, _duration] call CBA_fnc_waitAndExecute;
