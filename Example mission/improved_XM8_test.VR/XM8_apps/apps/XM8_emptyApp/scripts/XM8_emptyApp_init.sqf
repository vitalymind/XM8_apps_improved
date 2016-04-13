/*	XM8 Empty app by -your name here-
	
	-Script description-
*/

/*
	file: XM8_emptyApp\scripts\XM8_emptyApp_init.sqf
	function: no function
	
	This script will be executed once, when player login. It is executed straight from initLocalPlayer.sqf.
	This is best place to compile functions, define global variables and read gonfiguration files used in app.
*/

//Lets private all local variable used here. It is very important to always private all local variables. Trust me, this will save you alot of otherwise pulled hairs.
private ["_code"];

//Lets get path to script folder. It is passed as argument to this function. It may look like this "custom_scripts\subFolder\here_i_put_files\XM8_apps\apps\XM8_exampleApp\scripts\"
params ["_pathToAppFolder"];

/*	Lets start by initializing global variable used in this script
	It is good practice to initialize all global variables at the start of script,
	this will help keep track on variables, keep naming persistent, allow others understand code faster.
	For XM8 apps i advice to use following naming convention.
	XM8_appName_variableDescriptiveName - This will ensure high readability and avoid name collision.
*/
XM8_emptyApp_emptySlideIDCmap = []; //Lets define empty array, it will have IDC map for our Main slide.


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
	"XM8_emptyApp_emptySlide_onLoad"
];


/*	Lets now initialize configuration files
	In most cases, you want to give certain level of control over script
	behaviour to server admin. Configuration file is good option to do that.
*/
call compile preProcessFileLineNumbers format ["%1XM8_emptyApp_config.sqf",_pathToAppFolder];


//YOUR CODE GOES BELOW









