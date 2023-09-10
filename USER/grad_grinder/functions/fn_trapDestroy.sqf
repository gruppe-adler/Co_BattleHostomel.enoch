params ["_position"];

private _dummy = "#lightpoint" createVehicleLocal _position;

private _yaw = getDir cursorObject + 100; private _pitch = 300; private _roll = 330;  
private _vector = [  
	[sin _yaw * cos _pitch, cos _yaw * cos _pitch, sin _pitch],  
	[[sin _roll, -sin _pitch, cos _roll * cos _pitch], -_yaw] call BIS_fnc_rotateVector2D  
]; drop [[getMissionPath "USER\grad_grinder\data\tanktrap_bar.p3d", 1, 0, 1], "", "SpaceObject", 1, 60,  
	[-.3, -.2, 1],  
	[0, 0, 1],  
	0.1, 20, 7.9, 0, [1,1],  
	[[0.5,0.5,0.5,0], [0.7,0.7,0.7,0.5], [0.9,0.9,0.9,0]],  
	[0,1,0,1,0,1],  
	0.2, 0.2, "", "", _dummy, 0, true, 0.2, [], _vector];

private _yaw = getDir cursorObject + 220; private _pitch = -10; private _roll = 45;  
private _vector = [  
	[sin _yaw * cos _pitch, cos _yaw * cos _pitch, sin _pitch],  
	[[sin _roll, -sin _pitch, cos _roll * cos _pitch], -_yaw] call BIS_fnc_rotateVector2D  
]; drop [[getMissionPath "USER\grad_grinder\data\tanktrap_bar.p3d", 1, 0, 1], "", "SpaceObject", 1, 60,  
	[-.4, .5, .4],  
	[0, 0, 1],  
	0.1, 20, 7.9, 0, [1,1],  
	[[0.5,0.5,0.5,0], [0.7,0.7,0.7,0.5], [0.9,0.9,0.9,0]],  
	[0,1,0,1,0,1],  
	0.2, 0.2, "", "", _dummy, 0, true, 0.2, [], _vector];

private _yaw = getDir cursorObject + 350; private _pitch = -10; private _roll = 45;  
private _vector = [  
	[sin _yaw * cos _pitch, cos _yaw * cos _pitch, sin _pitch],  
	[[sin _roll, -sin _pitch, cos _roll * cos _pitch], -_yaw] call BIS_fnc_rotateVector2D  
]; drop [[getMissionPath "USER\grad_grinder\data\tanktrap_bar.p3d", 1, 0, 1], "", "SpaceObject", 1, 60,  
	[.3, -.20, .25],  
	[0, 0, 1],  
	0.1, 20, 7.9, 0, [1,1],  
	[[0.5,0.5,0.5,0], [0.7,0.7,0.7,0.5], [0.9,0.9,0.9,0]],  
	[0,1,0,1,0,1],  
	0.2, 0.2, "", "", _dummy, 0, true, 0.2, [], _vector];


deleteVehicle _dummy;