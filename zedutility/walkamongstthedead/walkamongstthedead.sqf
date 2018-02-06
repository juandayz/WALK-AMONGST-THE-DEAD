//FUNCTIONS



sand_shieldON = {
systemChat ("Zombies think you are one of them");
player_zombieCheck = {};
player_zombieAttack = {};
DZE_hasZombieCamo = true;
};

sand_endScript = {
player_zombieCheck = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\player_zombieCheck.sqf';
player_zombieAttack = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\player_zombieAttack.sqf';
DZE_hasZombieCamo = false;
hasGutsOnHim = false; 
sand_washed  = true;	
sand_USEDGUTS = nil;
player removeAction s_player_cleanguts;
s_player_cleanguts = -1;
_control ctrlShow false;
//playSound "heartbeat_1";
};





sand_zIcon = {
	private ["_control","_displayZ"];
	disableSerialization;
	
	 5 cutRsc ["zCamoStatusGUI","PLAIN"];
	_displayZ = uiNamespace getVariable 'zCamo_GUI_display';
	_control = 	_displayZ displayCtrl 1;
	_control ctrlShow true;
	while {true} do {
		
		if (player getVariable["combattimeout",0] >= diag_tickTime) then {
			if !(DZ_IGNORESHOTSFIRED) then {
				_control call player_guiControlFlash;
			};
		};
		sleep 0.5;
		if(sand_washed) exitWith {
			_control ctrlShow false;
			call sand_endScript;
		};
	};
};

sand_cleanCheck = {
private["_playerPos","_canshower","_isPond","_isWell","_pondPos","_objectsWell","_objectsPond"];
	while {true} do {

				 
if(hasGutsOnHim and (!sand_washed)) then {

   
		//SHOWER//
_playerPos = getPosATL player;
_canshower = count nearestObjects [_playerPos, ["Land_pumpa","Land_water_tank"], 4] > 0;
_isPond = false;
_isWell = false;
_pondPos = [];
_objectsWell = [];

if (!_canshower) then {
    _objectsWell = nearestObjects [_playerPos, [], 4];
    {
        //Check for Well
        _isWell = ["_well",str(_x),false] call fnc_inString;
        if (_isWell) then {_canshower = true};
    } forEach _objectsWell;
};
if (!_canshower) then {
    _objectsPond = nearestObjects [_playerPos, [], 50];
    {
        //Check for pond
        _isPond = ["pond",str(_x),false] call fnc_inString;
        if (_isPond) then {
            _pondPos = (_x worldToModel _playerPos) select 2;
            if (_pondPos < 0) then {
                _canshower = true;
                if (s_player_cleanguts < 0) then {
                s_player_cleanguts = player addAction [("<t color=""#3399cc"">" + ("CleanGuts") + "</t>"), "scripts\zedutility\walkamongstthedead\usewatersupply.sqf"];};
} else {
player removeAction s_player_cleanguts;
s_player_cleanguts = -1;

            };
        };
    } forEach _objectsPond;
}; 		




			
				
	
	
		sleep 1;
} else {
player removeAction s_player_cleanguts;
s_player_cleanguts = -1;
};
};
};





player_guiControlFlash = 	{
	private["_control"];
	_control = _this;
	if (ctrlShown _control) then {
		_control ctrlShow false;
	} else {
		_control ctrlShow true;
	};
};


////////////////DEFINE HOW MANY TIME THE SCRIPT LONGER BE USED
time_check = {
private ["_maxSeconds","_seconds"];
_maxSeconds = DZ_ZCAMO_USE_TIME;//time in seconds to use the zed cammo
_seconds = 0;
while {true} do {
if (_seconds >= _maxSeconds) exitWith { 
    call sand_endScript;
	systemChat ("Time out Zeds can aware of you now");
	    };
_seconds = _seconds + 1;
sleep 1;
};
};



////////////////////////////////////SCRIP START TO WORK
[] spawn {
	private ["_txt","_EH_Fired","_zedCheck"];
	waitUntil {
	(!isNil "sand_USEDGUTS")
	};
	if (isNil "sand_washed") then {
	sand_washed = false;
	};
	if (isNil "s_player_cleanguts") then {
	s_player_cleanguts = -1;
	};

	while {true} do {
	  
		waitUntil {sleep 0.5;(hasGutsOnHim)};
		//DZ_ZCAMO_STARTTIME = time;		
		sand_SkinType = typeOf player;		
		[] spawn sand_shieldON;
		[] spawn sand_zIcon;
		[] spawn sand_cleanCheck;
		[] spawn time_check;
        
		
		if !(DZ_IGNORESHOTSFIRED) then {
		_EH_Fired = player addEventHandler ["Fired", {
		systemChat ("You fired your weapon");
		hasGutsOnHim = false;
			
			}];
		};
		
		waitUntil {sleep 0.5;((!hasGutsOnHim)||(typeOf player != sand_SkinType))};
		// Lose camo if player changes clothes
		if (typeOf player != sand_SkinType) then {
			[] spawn {
				
				systemChat ("Skin change detected! You just lost your camo");
				sleep 0.1;
				call sand_endScript;
				
			};
		};
		call sand_endScript;
		if !(DZ_IGNORESHOTSFIRED) then {
			player removeEventHandler ["Fired", _EH_Fired];
		};
		
	};
};


