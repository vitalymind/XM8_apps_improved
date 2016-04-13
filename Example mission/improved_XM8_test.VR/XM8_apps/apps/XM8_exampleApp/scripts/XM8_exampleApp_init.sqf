/*	XM8 Example app by vitaly'mind'chizhikov
	
	This script serves as example, how to make applications for Improved XM8 apps.
	See http://www.exilemod.com/topic/13295-xm8-apps-improved-xm8-repair-mate/
*/

/*
	file: XM8_exampleApp\scripts\XM8_exampleApp_init.sqf
	function: no function
	
	This script will be executed once, when player login. It is executed straight from initLocalPlayer.sqf.
	This is best place to compile functions, define global variables and read gonfiguration files used in app.
*/
SystemChat "Example app inited";

//Lets private all local variable used here. It is very important to always private all local variables. Trust me, this will save you alot of otherwise pulled hairs.
private ["_code","_unloadScript"];

//Lets get path to script folder. It is passed as argument to this function. It may look like this "custom_scripts\subFolder\here_i_put_files\XM8_apps\apps\XM8_exampleApp\scripts\"
params ["_pathToAppFolder"];

/*	Lets start by initializing global variable used in this script
	It is good practice to initialize all global variables at the start of script,
	this will help keep track on variables, keep naming persistent, allow others understand code faster.
	For XM8 apps i advice to use following naming convention.
	XM8_appName_variableDescriptiveName - This will ensure high readability and avoid name collision.
*/
XM8_exampleApp_exampleSlide1IDCmap = []; //Lets define empty array, it will have IDC map for our Main slide.
XM8_exampleApp_exampleSlide2IDCmap = []; //Lets define empty array, it will have IDC map for our Sub slide.
XM8_exampleApp_selectedRifle = ""; //We will keep selected sniper rifle in this var
XM8_exampleApp_inProgress = false; //We will set this to TRUE if delayed action in progress
XM8_exampleApp_secondsForDelayedAction = 5; //Time to perform delayed action
XM8_exampleApp_selectableWeaponType = "sniper rifle"; //Type of weapon to be selectable

/*	Lets now initializing global functions used in this script
	It is important to have functions compiled once and final,
	so they will not be changeable while in game.
	This will give additional protection from hackers.
*/
{
	if (isNil _x) then {
		_code = compileFinal (preprocessFileLineNumbers (format (["%1scripts\%2.sqf",_pathToAppFolder,_x])));
		if (isNil "_code") then {_code = compileFinal ""};
		missionNamespace setVariable [_x, _code];
	};
} forEach [
	"XM8_exampleApp_delayedProcess",
	"XM8_exampleApp_exampleSlide1_onLoad",
	"XM8_exampleApp_exampleSlide2_onLoad",
	"ExileClient_gui_xm8_slide_exampleSlide1_onOpen",
	"ExileClient_gui_xm8_slide_exampleSlide2_onOpen"
];


/*	Lets now initialize configuration files
	In most cases, you want to give certain level of control over script
	behaviour to server admin. Configuration file is good option to do that.
*/
call compile preProcessFileLineNumbers format ["%1XM8_exampleApp_config.sqf",_pathToAppFolder];











