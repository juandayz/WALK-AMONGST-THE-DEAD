//by juandayz

private ["_txt","_zbody","_nearestplayers","_hastools","_wasguted","_setinfectRand","_SetchanceInf"];

_zbody = _this select 3;
_wasguted = _zbody getVariable["wasguted",false];
_setinfectRand= round(random 10);
_SetchanceInf = 7;
_hastools = ["ItemKnife"] call player_hasTools;




if (hasGutsOnHim) exitWith {systemChat ("already covered in zombie guts");};

if (vehicle player != player) exitWith {systemChat ("You cannot made it in a vehicle");};

if !(_hastools) exitWith {systemChat "You need a knife";};

if (!_wasguted) then {

if (_setinfectRand < _SetchanceInf) then {
r_player_infected = true;
player setVariable["USEC_infected",true,true];
systemChat ("You was infected by the blood");
};

player playActionNow "Medic"; 
[player,"gut",0,false,10] call dayz_zombieSpeak;

	
	sand_USEDGUTS = true; 
	sand_washed =  false;
	hasGutsOnHim = true;
_zbody setVariable["wasguted",true,true];
player setVariable ["USEC_inPain", true, true];
};