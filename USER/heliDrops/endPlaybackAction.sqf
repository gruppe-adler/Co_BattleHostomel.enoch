params ["_vehicle"];

_vehicle addAction
	[
		"<t color='#FF6600'>End Unit Capture Playback</t>",	// title
		{
			params ["_target", "_caller", "_actionId", "_arguments"]; // script
			
			_target setvariable ["BIS_fnc_unitPlay_terminate", true, true];

			hint "you are in control now";
			
		},
		nil,		// arguments
		99,		// priority
		true,		// showWindow
		true,		// hideOnUse
		"",			// shortcut
		"!(_this getvariable ['BIS_fnc_unitPlay_terminate', false]) && player == (_this getVariable ['BIS_fnc_moduleRemoteControl_owner', objNull])", 	// condition
		0,			// radius
		false,		// unconscious
		"",			// selection
		""			// memoryPoint
	];
