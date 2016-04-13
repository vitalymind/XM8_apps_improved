/*	XM8 Example app by vitaly'mind'chizhikov
	
	This script serves as example, how to make applications for Improved XM8 apps.
	See http://www.exilemod.com/topic/13295-xm8-apps-improved-xm8-repair-mate/
*/
/*
	file: XM8_exampleApp\scripts\XM8_exampleApp_exampleSlide1_onLoad.sqf
	function: XM8_exampleApp_exampleSlide1_onLoad
	
	This script will be executed once, when XM8 is opened.
	It is best place to create sliders and make controls.
*/

systemChat format ["Example app. Creating sub slide %1",time];


//Lets private all local variable used here. It is very important to always private all local variables. Trust me, this will save you alot of otherwise pulled hairs.
private ["_makeProgressBar","_makePicture","_makeStructuredText","_makeBackground","_makeFrame","_makeButton","_pW","_pH","_display","_slides",
"_error","_exampleSlide2","_getNextIDC"];

//Lets define our functions. See functions.txt for details.
_makeProgressBar = {
	params ["_parent","_idc","_position","_progress","_enabled","_color","_shown","_tooltip"];
	private ["_ctrl"];
	_ctrl = _display ctrlCreate ["RscProgress", _idc, _parent];
	_ctrl ctrlSetPosition _position;
	_ctrl progressSetPosition _progress;
	_ctrl ctrlSetTextColor _color;
	_ctrl ctrlEnable _enabled;
	_ctrl ctrlShow _shown;
	_ctrl ctrlSetTooltip _tooltip;
	_ctrl ctrlCommit 0;
	_ctrl;
};
_makePicture = {
	params ["_parent","_idc","_position","_picture","_color","_enable","_keepAspect","_tooltip"];
	private ["_ctrl"];
	_ctrl = _display ctrlCreate [(if (_keepAspect) then {"RscPictureKeepAspect"} else {"RscPicture"}), _idc, _parent];
	_ctrl ctrlSetPosition _position;
	_ctrl ctrlSetText _picture;
	_ctrl ctrlSetTextColor _color;
	_ctrl ctrlEnable _enable;
	_ctrl ctrlSetTooltip _tooltip;
	_ctrl ctrlCommit 0;
	_ctrl;
};
_makeStructuredText = {
	params ["_parent","_idc","_position","_text","_font","_size","_color","_align","_shadow"];
	private ["_ctrl"];
	_ctrl = _display ctrlCreate ["RscStructuredText", _idc, _parent];
	_ctrl ctrlSetPosition _position;
	_ctrl ctrlSetStructuredText (parseText format ["<t shadow='%6' font='%5' align='%4' size='%2' color='%3'>%1</t>", _text,_size,_color, _align,_font,_shadow]);
	_ctrl ctrlEnable false;
	_ctrl ctrlCommit 0;
	_ctrl;
};
_makeBackground = {
	params ["_parent","_idc","_position","_color","_tooltip"];
	private ["_ctrl"];
	_ctrl = _display ctrlCreate ["RscBackground", _idc, _parent];
	_ctrl ctrlSetPosition _position;
	_ctrl ctrlSetBackgroundColor _color;
	_ctrl ctrlEnable false;
	_ctrl ctrlSetTooltip _tooltip;
	_ctrl ctrlCommit 0;
	_ctrl;
};
_makeFrame = {
	params ["_parent","_idc","_position"];
	private ["_ctrl"];
	_ctrl = _display ctrlCreate ["RscFrame", _idc, _parent];
	_ctrl ctrlSetPosition _position;
	_ctrl ctrlEnable false;
	_ctrl ctrlCommit 0;
	_ctrl;
};
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
	_slideClassName = "exampleSlide2"; //Classname of your slide. Change it accordinly.
	_map = XM8_exampleApp_exampleSlide2IDCmap; //Variable name of IDC map of slide. Change it accordinly.
	_baseIDC = getNumber (missionConfigFile >> "CfgXM8" >> _slideClassName >> "controlID");
	_result = _baseIDC + (_map pushBack _key);
	_result;
};

//Lets define few usefull variables that are used here.
_pW = 0.025; //This is our vertical grid multiplyer, usefull for control placement
_pH = 0.04; //This is our horizontal grid multiplyer, usefull for control placement
//We need pointer to XM8 dialog (display), lets get it
_display = uiNameSpace getVariable ["RscExileXM8", displayNull];
if (isNull _display) exitWith {_error = "Error loading XM8 Example app, display is null"; systemChat _error; diag_log _error;};
//We need pointer to "slides" control group, becouse we will add our slide in to this group
_slides = _display displayCtrl 4007;
if (isNull _slides) exitWith {_error = "Error loading XM8 Example app, slides control is null"; systemChat _error; diag_log _error;};

// Lets now initialize eventhandlers
_unloadScript = '
	if (ExileClientXM8CurrentSlide == "exampleSlide2") then {
		systemChat "XM8 closed while example sub slide was shown";
		ExileClientXM8CurrentSlide = "apps";
	};
'; //By executing ExileClientXM8CurrentSlide = "apps" we make sure that when XM8 closed and opened again, "apps" slide will be displayed.
_display displayAddEventHandler ["unload",_unloadScript];

//Lets clean up our slide`s IDC map.
XM8_exampleApp_exampleSlide2IDCmap = [];

//Lets create our slide
_exampleSlide2 = _display ctrlCreate ["RscExileXM8Slide",("slide" call _getNextIDC),_slides];

//In order to navigate slides we need "GO BACK" button. Lets make such button.
[_exampleSlide2,("backToMenu" call _getNextIDC), [27.6*_pW,17.7*_pH,6*_pW, 1*_pH], '["sideApps", 1] call ExileClient_gui_xm8_slide;',"GO BACK","Back to main menu"] call _makeButton;

//Lets also create button to navigate back to main slide
[_exampleSlide2,("backToMain" call _getNextIDC), [27.6*_pW,2*_pH,6*_pW, 1*_pH], '["exampleSlide1", 1] call ExileClient_gui_xm8_slide;',"MAIN SLIDE","Go back to main slide"] call _makeButton;

[
	_exampleSlide2,
	("infoText" call _getNextIDC),
	[1*_pW,2*_pH,8*_pW, 8*_pH],
	"More very usefull GUI elements in this slide as well",
	"PuristaMedium",
	1.2,
	"#FFFFFFFF",
	"left",
	0,
	"#FFFFFFFF"
] call _makeStructuredText;


