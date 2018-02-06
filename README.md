# WALK-AMONGST-THE-DEAD 1.6.2

***ALL CREDITS FOR SANDBIRD.***

Allow players to smear guts over his body using scroll menu over a dead zombie.

1.Open your init.sqf and at very bottom paste:

```ruby
call compile preprocessFileLineNumbers "scripts\zedutility\walkamongstthedead\config.sqf";
```

2.Open your description.ext and into class RscTitles { };
paste:

```ruby
		class zCamoStatusGUI {
	idd = -1;
	fadeout=0;
	fadein=0;
		onLoad = "uiNamespace setVariable ['zCamo_GUI_display', _this select 0]";
		duration = 10e10;
		name= "zCamoGui";
		controlsBackground[] = {};
		objects[] = {};
		class controls {
			class zCamoIcon:RscPictureGUI {
			idc = 1;
			text="scripts\zedutility\walkamongstthedead\zombie.paa";
			x="0.958313 * safezoneW + safezoneX";
			y="0.43 * safezoneH + safezoneY";
			w=0.059999999;
			h=0.079999998;
			colorText[]={1,1,1,1};
			};
		};
 };
 ```
 3. Open your fn_selfactions.sqf and find this line:
 
 ```
 if (_isMan && {!(isPlayer _cursorTarget)} && {_typeOfCursorTarget in serverTraders} && {!_isPZombie}) then {
 ```
 Above paste:
 ```ruby
 private ["_wasguted"];
if (!_isAlive && {(_cursorTarget isKindOf "zZombie_base")}) then {
_wasguted = _cursorTarget getVariable["wasguted",false];
if (!_wasguted) then {
if (s_player_zhide2 < 0) then {
s_player_zhide2 = player addAction ["Smear Guts on You", "scripts\zedutility\walkamongstthedead\smear_guts.sqf",_cursorTarget,0, false,true];
};
} else {
player removeAction s_player_zhide2;
s_player_zhide2 = -1;	
};
};
```
Find:
```
	player removeAction s_player_fuelauto2;
	s_player_fuelauto2 = -1;
	player removeAction s_player_manageDoor;
	s_player_manageDoor = -1;
```
Below Paste:
```ruby
player removeAction s_player_zhide2;
s_player_zhide2 = -1;	
```

4.Open your custom variables.sqf and with the rest of the actions paste:
```s_player_zhide2 = -1;```

5.Place the folder provided here into your scripts\ folder.

6.Open the config.sqf located in \zedutility\walkamongstthedead\   and edit whatever you want.

7.For infistar users add "s_player_zhide2" with the rest of your allowed actions.

