/**
 * ExileClient_gui_xm8_slide_apps_onOpen
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_display","_killDeathRatio","_killDeathRatioControl","_popTabsValue","_popTabs","_respectValue","_respect"];
disableSerialization;
_display = uiNameSpace getVariable ["RscExileXM8", displayNull];
if (ExileClientPlayerDeaths < 1) then {
	_killDeathRatio = ExileClientPlayerKills;
} else {
	_killDeathRatio = [ExileClientPlayerKills / ExileClientPlayerDeaths, 2] call ExileClient_util_math_round;
};
_killDeathRatioControl = _display displayCtrl 4057;
_killDeathRatioControl ctrlSetTooltip format ["%1 Kills / %2 Deaths", ExileClientPlayerKills, ExileClientPlayerDeaths];
_killDeathRatioControl ctrlSetStructuredText parseText (format ["<t color='#00b2cd' font='OrbitronLight' size='1.6' valign='middle' align='center' shadow='0'><br/><br/><br/><t font='OrbitronMedium' size='3.5' color='#ffffff'>%1</t><br/>K/D</t>", _killDeathRatio]);

_popTabsValue = (player getVariable ["ExileLocker", 0]);
if (_popTabsValue > 999) then {
	_popTabsValue = format ["%1k", floor (_popTabsValue / 1000)];
};
_popTabs = _display displayCtrl 4058;
_popTabs ctrlSetTooltip format["You have %1 Pop Tabs in your locker", (player getVariable ["ExileLocker", 0])];
_popTabs ctrlSetStructuredText parseText (format ["<t color='#00b2cd' font='OrbitronLight' size='1.6' valign='middle' align='center' shadow='0'><br/><br/><br/><t font='OrbitronMedium' size='3.5' color='#ffffff'>%1</t><br/>POP TABS</t>", _popTabsValue]);

_respectValue = ExileClientPlayerScore;
if (_respectValue > 999) then {
	_respectValue = format ["%1k", floor (_respectValue / 1000)];
};
_respect = _display displayCtrl 4059;
_respect ctrlSetTooltip format["%1", ExileClientPlayerScore];
_respect ctrlSetStructuredText parseText (format ["<t color='#00b2cd' font='OrbitronLight' size='1.6' valign='middle' align='center' shadow='0'><br/><br/><br/><t font='OrbitronMedium' size='3.5' color='#ffffff'>%1</t><br/>RESPECT</t>", _respectValue]);

//Lets hide old territory button, as we already made new one early on in ExileClient_gui_xm8_show.
//Why we make new? Because if button is re-possition it will render picture (textureNoShortcut) incorrectly.
private ["_sliders","_appSlide","_oldTerritoryBut"];
_sliders = _display displayCtrl 4007;
_appSlide = _sliders controlsGroupCtrl 4040;
_oldTerritoryBut = _appSlide controlsGroupCtrl 1113;
_oldTerritoryBut ctrlShow false;
_oldTerritoryBut ctrlSetFade 0;
_oldTerritoryBut ctrlCommit 0;
