/*	XM8 Empty app by -your name here-
	
	-Script description-
*/
/*
	file: XM8_emptyApp\scripts\XM8_emptyApp_emptySlide_onLoad.sqf
	function: XM8_emptyApp_emptySlide_onLoad
	
	This script will be executed once, when XM8 is opened.
	It is best place to create sliders and make controls.
*/

//===FIRST OF ALL LETS SETUP ASSETS FOR OUR SCRIPT===

//Lets private all local variable used here. It is very important to always private all local variables. Trust me, this will save you alot of otherwise pulled hairs.
private ["_getNextIDC","_pW","_pH","_display","_slides","_unloadScript","_error","_thisSlide"];

//Lets define our functions. See functions.txt for details.
_makeButton = {
	params ["_parent","_idc","_position","_action","_text","_tooltip"];
	private ["_ctrl"];
	_ctrl = _display ctrlCreate ["RscButtonMenu",_idc,_parent];
	_ctrl ctrlSetPosition _position;
	_ctrl ctrlSetText _text;
	_ctrl ctrlSetEventHandler ["ButtonClick",_action];
	_ctrl ctrlSetTooltip _tooltip;
	_ctrl ctrlCommit 0;
	_ctrl;
};
_getNextIDC = { //This function must be adjusted according to slide name.
	params ["_key"];
	private ["_slideClassName","_baseIDC","_result","_map"];
	_slideClassName = "emptySlide"; //Classname of your slide. Change it accordinly.
	_map = XM8_emptyApp_emptySlideIDCmap; //Variable name of IDC map of slide. Change it accordinly.
	_baseIDC = getNumber (missionConfigFile >> "CfgXM8" >> _slideClassName >> "controlID");
	_result = _baseIDC + (_map pushBack _key);
	_result;
};

//Lets define few usefull variables that are used here.
_pW = 0.025; //This is our vertical grid multiplyer, usefull for control placement
_pH = 0.04; //This is our horizontal grid multiplyer, usefull for control placement
//We need pointer to XM8 dialog (display), lets get it
_display = uiNameSpace getVariable ["RscExileXM8", displayNull];
if (isNull _display) exitWith {_error = "Error loading XM8 Empty app, display is null"; systemChat _error; diag_log _error;};
//We need pointer to "slides" control group, because we will add our slide in to this group
_slides = _display displayCtrl 4007;
if (isNull _slides) exitWith {_error = "Error loading XM8 Empty app, slides control is null"; systemChat _error; diag_log _error;};

/*	Lets now initialize eventhandlers
	Sometimes we need to react to certain events or user input.
	For that we can use display eventhandlers.
*/
_unloadScript = '
	
';
_display displayAddEventHandler ["unload",_unloadScript];

//Lets clean up this slide`s IDC map.
XM8_emptyApp_emptySlideIDCmap = [];


//===NOW LETS ACTUALLY CREATE GUI ELEMENTS===

//Lets create our slide
_thisSlide = _display ctrlCreate [
	"RscExileXM8Slide", //This is pre-configured exile class for slides.
	("emptySlide" call _getNextIDC), //We need to get next available IDC. We provide key, STRING value. Later we will get control with this key.
	_slides //This is so called "parent" control group. We will add our slide to group where all slides live :)
];

//In order to navigate slides we need "GO BACK" button. Lets make such button.
[
	_thisSlide, //This is pointer to "Parent" group. We making go back button for our slide, so lets place pointer to our slide here.
	("backButton" call _getNextIDC), //All controls need IDC, so lets get next available IDC and associate it with meaningful key.
	[ //Lets place our button in left bottom corner. Slide have size of 34 points in width and 19 point in height so...
		27.6*_pW, // 0*_pW is most left horizontal point of slide, while 34*_pW is most right point of slide. Lets place it close to right side.
		17.7*_pH, // 0*_pH is most upper vertical point of slide, while 19*_pH is most bottom vertical point of slide. Lets place it close to bottom.
		6*_pW, // Lets make our button 6 point width. 34 - 6 = 28. 28 - 27.6 = 0.4. So we have 0.4 points indent from left side.
		1*_pH // Lets make our button 1 point high. 19 - 1 = 18. 18 - 17.7 = 0.3. So we have 0.3 points indent from bottom.
	], 
	'["sideApps", 1] call ExileClient_gui_xm8_slide;', //This STRING will be compiled and executed when our button pressed. In this case we want to slide back to XM8 apps slide.
	"GO BACK", //Our buttons text
	"" //Our buttons tooltip
] call _makeButton;


//YOUR CODE GOES BELOW
