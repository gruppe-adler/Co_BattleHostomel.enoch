params ["_posASL", "_surfaceNormal", "_intersectObject", "_finalPoint"]; 
     
private _lightSource = "#lightpoint" createVehicleLocal ASLtoAGL (_finalPoint); 

_lightSource setLightColor [1, .5, .8];  
_lightSource setLightAmbient [1, .8, .9];  
_lightSource setLightUseFlare true; 
_lightSource setLightFlareSize (random 1 max 0.5); // in meter 
_lightSource setLightFlareMaxDistance 100; // in meter 
_lightSource setLightIntensity (random 200 max 100); 
_lightSource setLightDayLight true; // only for the light itself, not the flare 

[{ deleteVehicle _this}, _lightSource, .1] call CBA_fnc_waitAndExecute; 
