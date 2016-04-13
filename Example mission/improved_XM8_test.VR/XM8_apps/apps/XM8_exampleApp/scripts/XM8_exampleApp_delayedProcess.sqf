/*	XM8 Example app by vitaly'mind'chizhikov
	
	This script serves as example, how to make applications for Improved XM8 apps.
	See http://www.exilemod.com/topic/13295-xm8-apps-improved-xm8-repair-mate/
*/

/*
	file: XM8_exampleApp\scripts\XM8_exampleApp_delayedProcess.sqf
	function: XM8_exampleApp_delayedProcess
	
	This is one of custom scripts made for example app.
	You can make any number of such scripts, remember to compile them all in app`s init script.
	Separate functions usefull when script is complicated. 
	With small simple scripts attached to, lets say, a button, it is better to fit them to directly
	in ***_onLoad function as text.
*/

//Lets pretentend that this is complicated function, that needs to be compiled and stored for whole time.

/*	This function is executed when "START" button pressed on Main slide.
	What it does is basically waiting N seconds and constantly updating progress bar on main slide to show progress.
	If "channeling" is not interrupted it will write "success" to systemchat, or "canceled" otherwise
*/

//Lets private all local variables
private ["_pW","_pH","_display","_slides","_progressBar","_cancel"];

//This script is 'spawned', thus we have to disable serialization, to properly save control pointers to variables
disableSerialization;

//Lets get important assets.
_pW = 0.025;
_pH = 0.04;
_display = uiNameSpace getVariable ["RscExileXM8", displayNull];
if (isNull _display) exitWith {_error = "Error loading XM8 Example app, display is null"; systemChat _error; diag_log _error;};
_slides = _display displayCtrl 4007;
if (isNull _slides) exitWith {_error = "Error loading XM8 Example app, slides control is null"; systemChat _error; diag_log _error;};

_getControl = { //This function must be adjusted according to slide
	params ["_key"]; 
	private ["_ctrl","_idc","_index","_slideClassName"]; 
	_ctrl = controlNull;
	_slideClassName = "exampleSlide1"; //Classname of your slide
	_map = XM8_exampleApp_exampleSlide1IDCmap; //Variable name of IDC map of slide
	_index = _map find _key;
	if (_index != -1) then {
		_idc = ((getNumber (missionConfigFile >> "CfgXM8" >> _slideClassName >> "controlID")) + _index);
		_ctrl = _display displayCtrl _idc;
	};
	_ctrl;
};

//Lets chack if our delayed action already started and cancel execution if it is true
if (XM8_exampleApp_inProgress) exitWith {};

//Lets mark that we are now in progress.
XM8_exampleApp_inProgress = true;

//Lets animate progress bar and wait for given time
_progressBar = "progressBar" call _getControl; // Let get control with given key
_progressBar progressSetPosition 0; //Lets reset progress amount
_cancel = false; //pre-define conditional variable

//Lets execute sleep command certain number of times
for "_i" from 1 to (XM8_exampleApp_secondsForDelayedAction * 50) do {
	sleep 0.02;
	//Lets update progress bar
	_progressBar progressSetPosition (_i / (XM8_exampleApp_secondsForDelayedAction * 50));
	//If XM8 is closed or slide changed lets exit loop
	if (isNull _display) exitWith {_cancel = true};
	if (ExileClientXM8CurrentSlide != "exampleSlide1") exitWith {_cancel = true};
};
//Lets set progress to default position
_progressBar progressSetPosition 0;

//Action is over, so lets set inProgress variable to false
XM8_exampleApp_inProgress = false;

//Now we check if preocess was interupted or not, and execute accordinly
if (!_cancel) then {
	systemChat "success";
} else {
	systemChat "canceled";
};












