params ["_position", "_dir"];

private _debris = "SpaceshipCapsule_01_debris_F" createVehicleLocal [0,0,0];
_debris setDir _dir;
_debris setPos _position;

// debris flying around 
private _source01 = "#particlesource" createVehicleLocal [0, 0, 0];  
_source01 setPos _position;  
_source01 setParticleCircle [0, [0, 0, 0]];  
_source01 setParticleRandom [0, [1, 1, 1], [20, 20, 40], 0, 2, [0, 0, 0, 0.1], 0, 0];  
_source01 setParticleParams [
    ["\A3\Props_F_Exp\Military\OldPlaneWrecks\HistoricalPlaneDebris_01_F.p3d", 1, 0, 1], "", "SpaceObject", 0.5, 120, 
    [0.1, 0.1, 1], [0, 0, 0], 0.5, 200, 20, 3.75, [0.2,0.2,0.2], [[0.3, 0.3, 0.3, 1], [0.3, 0.3, 0.3, 0.3], [0.3, 0.3, 0.3, 0]], 
    [0.08], 1, 0, "", "", _this,0,true,0.1
];  
_source01 setDropInterval 0.01; 
 
[{ 
    params ["_source01"]; 
    deleteVehicle _source01; 
}, [_source01] ,0.25] call CBA_fnc_waitAndExecute; 



private _source02 = "#particlesource" createVehicleLocal [0, 0, 0];  
_source02 setPos _position;  
_source02 setParticleCircle [0, [0, 0, 0]];  
_source02 setParticleRandom [0, [1, 1, 1], [20, 20, 40], 0, 2, [0, 0, 0, 0.1], 0, 0];  
_source02 setParticleParams [
    ["\A3\Props_F_Exp\Military\OldPlaneWrecks\HistoricalPlaneDebris_02_F.p3d", 1, 0, 1], "", "SpaceObject", 0.5, 120, 
    [0.1, 0.1, 1], [0, 0, 0], 0.5, 200, 20, 3.75, [0.2,0.2,0.2], [[0.3, 0.3, 0.3, 1], [0.3, 0.3, 0.3, 0.3], [0.3, 0.3, 0.3, 0]], 
    [0.08], 1, 0, "", "", _this,0,true,0.1
];  
_source02 setDropInterval 0.01; 
 
[{ 
    params ["_source02"]; 
    deleteVehicle _source02; 
}, [_source02] ,0.25] call CBA_fnc_waitAndExecute; 


private _source03 = "#particlesource" createVehicleLocal [0, 0, 0];  
_source03 setPos _position;  
_source03 setParticleCircle [0, [0, 0, 0]];  
_source03 setParticleRandom [0, [1, 1, 1], [20, 20, 40], 0, 2, [0, 0, 0, 0.1], 0, 0];  
_source03 setParticleParams [
    ["\A3\Props_F_Exp\Military\OldPlaneWrecks\HistoricalPlaneDebris_03_F.p3d", 1, 0, 1], "", "SpaceObject", 0.5, 120, 
    [0.1, 0.1, 1], [0, 0, 0], 0.5, 200, 20, 3.75, [0.2,0.2,0.2], [[0.3, 0.3, 0.3, 1], [0.3, 0.3, 0.3, 0.3], [0.3, 0.3, 0.3, 0]], 
    [0.08], 1, 0, "", "", _this,0,true,0.1
];  
_source03 setDropInterval 0.01; 
 
[{ 
    params ["_source03"]; 
    deleteVehicle _source03; 
}, [_source03] ,0.25] call CBA_fnc_waitAndExecute; 


private _source04 = "#particlesource" createVehicleLocal [0, 0, 0];  
_source04 setPos _position;  
_source04 setParticleCircle [0, [0, 0, 0]];  
_source04 setParticleRandom [0, [1, 1, 1], [20, 20, 40], 0, 2, [0, 0, 0, 0.1], 0, 0];  
_source04 setParticleParams [
    ["\A3\Props_F_Exp\Military\OldPlaneWrecks\HistoricalPlaneDebris_04_F.p3d", 1, 0, 1], "", "SpaceObject", 0.5, 120, 
    [0.1, 0.1, 1], [0, 0, 0], 0.5, 200, 20, 3.75, [0.2,0.2,0.2], [[0.3, 0.3, 0.3, 1], [0.3, 0.3, 0.3, 0.3], [0.3, 0.3, 0.3, 0]], 
    [0.08], 1, 0, "", "", _this,0,true,0.1
];  
_source04 setDropInterval 0.01; 
 
[{ 
    params ["_source04"]; 
    deleteVehicle _source04; 
}, [_source04] ,0.25] call CBA_fnc_waitAndExecute; 
