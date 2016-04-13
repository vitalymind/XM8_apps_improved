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

/*	In this script we will create all controls (GUI elements) for our main slide (exampleSlide1).
	Note that this script will be executed only once when XM8 opened (6 pressed). It will not
	be executed again even if you slide back and forth. This will ensure that elements will not
	be creted on top of each other.
	You will notice hovewer that not all elements positioned properly in this script, some
	controls will be re-positioned/re-sized when app button actually pressed, and when it happen
	ExileClient_gui_xm8_slide_exampleSlide1_onOpen.sqf will be excuted and controls will be placed correctly.
*/

systemChat format ["Example app. Creating main slide. %1",time];



//===FIRST OF ALL LETS SETUP ASSETS FOR OUR SCRIPT===

//Lets private all local variable used here. It is very important to always private all local variables. Trust me, this will save you alot of otherwise pulled hairs.
private ["_makeProgressBar","_makePicture","_makeStructuredText","_makeBackground","_makeFrame","_makeButton","_pW","_pH","_display","_slides",
"_error","_exampleSlide1","_getNextIDC","_ctrl","_rifleSelectedAction","_sniperRiflesConfigs","_index","_value","_somePictures","_rifleType"];

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
	params ["_parent","_idc","_position","_text","_font","_size","_color","_align","_shadow","_shadowColor"];
	private ["_ctrl"];
	_ctrl = _display ctrlCreate ["RscStructuredText", _idc, _parent];
	_ctrl ctrlSetPosition _position;
	_ctrl ctrlSetStructuredText (parseText format ["<t shadow='%6' shadowColor='%7' font='%5' align='%4' size='%2' color='%3'>%1</t>", _text,_size,_color, _align,_font,_shadow,_shadowColor]);
	_ctrl ctrlEnable false;
	_ctrl ctrlCommit 0;
	_ctrl;
};
_makeBackground = {
	params ["_parent","_idc","_position","_color","_enable","_tooltip"];
	private ["_ctrl"];
	_ctrl = _display ctrlCreate ["RscBackground", _idc, _parent];
	_ctrl ctrlSetPosition _position;
	_ctrl ctrlSetBackgroundColor _color;
	_ctrl ctrlEnable _enable;
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
_makeList = {
	params ["_parent","_idc","_position","_actionOnSelChanged","_tooltip"];
	private ["_ctrl"];
	_ctrl = _display ctrlCreate ["RscListBox",_idc,_parent];
	_ctrl ctrlSetPosition _position;
	_ctrl ctrlSetEventHandler ["LBSelChanged",_actionOnSelChanged];
	_ctrl ctrlSetTooltip _tooltip;
	_ctrl ctrlCommit 0;
	_ctrl;
};
_getNextIDC = { //This function must be adjusted according to slide name.
	params ["_key"];
	private ["_slideClassName","_baseIDC","_result","_map"];
	_slideClassName = "exampleSlide1"; //Classname of your slide. Change it accordinly.
	_map = XM8_exampleApp_exampleSlide1IDCmap; //Variable name of IDC map of slide. Change it accordinly.
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

/*	Lets now initialize eventhandlers
	Sometimes we need to react to certain events or user input.
	For that we can use display eventhandlers.
*/
_unloadScript = '
	if (ExileClientXM8CurrentSlide == "exampleSlide1") then {systemChat "XM8 closed while example main slide was shown"};
';
_display displayAddEventHandler ["unload",_unloadScript];

//Lets clean up this slide`s IDC map.
XM8_exampleApp_exampleSlide1IDCmap = [];



//===NOW LETS ACTUALLY CREATE GUI ELEMENTS===

//Lets create our slide
_exampleSlide1 = _display ctrlCreate [
	"RscExileXM8Slide", //This is pre-configured exile class for slides.
	("slide" call _getNextIDC), //We need to get next available IDC. We provide key, STRING value. Later we will get control with this key.
	_slides //This is so called "parent" control group. We will add our slide to group where all slides live :)
];

//In order to navigate slides we need "GO BACK" button. Lets make such button.
[
	_exampleSlide1, //This is pointer to "Parent" group. We making go back button for our slide, so lets place pointer to our slide here.
	("backButton" call _getNextIDC), //All controls need IDC, so lets get next available IDC and associate it with meaningful key.
	[ //Lets place our button in left bottom corner. Slide have size of 34 points in width and 19 point in height so...
		27.6*_pW, // 0*_pW is most left horizontal point of slide, while 34*_pW is most right point of slide. Lets place it close to right side.
		17.7*_pH, // 0*_pH is most upper vertical point of slide, while 19*_pH is most bottom vertical point of slide. Lets place it close to bottom.
		6*_pW, // Lets make our button 6 point width. 34 - 6 = 28. 28 - 27.6 = 0.4. So we have 0.4 points indent from left side.
		1*_pH // Lets make our button 1 point high. 19 - 1 = 18. 18 - 17.7 = 0.3. So we have 0.3 points indent from bottom.
	], 
	'["sideApps", 1] call ExileClient_gui_xm8_slide;', //This STRING will be compiled and executed when our button pressed. In this case we want to slide back to XM8 apps slide.
	"GO BACK", //Our buttons text
	"This button have tooltip" //Our buttons tooltip
] call _makeButton;

//Lets create button to access our sub slide.
[_exampleSlide1,("subSlideOpen" call _getNextIDC),[27.6*_pW,2*_pH,6*_pW,1*_pH],'["exampleSlide2", 0] call ExileClient_gui_xm8_slide;',"SUB SLIDE","Open sub slide of our example app"] call _makeButton;

//Lets create list with all weapons available for select and a button to give selected weapon to player.
_rifleSelectedAction = //First lets define action when item selected in our list box
'
	_ctrl = _this select 0;
	_index = _this select 1;
	XM8_exampleApp_selectedRifle = _ctrl lbData _index;
';

//Lets see what kind of weapon type should be selectable
_rifleType = switch (XM8_exampleApp_selectableWeaponType) do {
	case "sniper rifle": {"srifle"};
	case "machine guns": {"mg"};
	case "assault rifles": {"arifle"};
	default {""};
};

//Lets create list box. Every _make* function will return pointer to control. We save it to _ctrl variable, because we need to make additional actions with listbox.
_ctrl = [_exampleSlide1,("riflesList" call _getNextIDC),[0.4*_pW,3*_pH,15*_pW,5*_pH],_rifleSelectedAction,""] call _makeList;
//Lets get all sniper rifle configs
_sniperRiflesConfigs = (format ["(getText (_x >> 'cursor') == '%1') AND (getNumber (_x >> 'scope') == 2)", _rifleType] configClasses (configfile >> "CfgWeapons"));
//Lets fill our list with sniper rifles
{
	_index = _ctrl lbAdd getText (_x >> "displayName"); // Lets set rifle`s display name as items name
	_ctrl lbSetData [_index, configName _x]; // Lets set rifle`s classname as items hidden text data.
} forEach _sniperRiflesConfigs;
//Lets create "GIVE" action
_giveRifleButtonAction = //First lets define action when item selected in our list box
'
	if (XM8_exampleApp_selectedRifle == "") exitWith {systemChat "no rifle selected"};
	player removeWeapon (primaryWeapon player);
	player addWeapon XM8_exampleApp_selectedRifle;
	player selectWeapon XM8_exampleApp_selectedRifle;
	_magazine = (getArray (configfile >> "CfgWeapons" >> XM8_exampleApp_selectedRifle >> "magazines")) select 0;
	_displayName = getText (configfile >> "CfgWeapons" >> XM8_exampleApp_selectedRifle >> "displayName");
	player addWeaponItem [currentWeapon player, _magazine];
	systemChat format ["%1 sniper rifle given", _displayName];
';
//Lets create "GIVE" button
[_exampleSlide1,("giveRifleButton" call _getNextIDC),[11.4*_pW,2*_pH,4*_pW,1*_pH],_giveRifleButtonAction,"GIVE","Press this button to get selected rifle"] call _makeButton;
//Lets create text above list box
[
	_exampleSlide1,
	("" call _getNextIDC),//Sometimes we dont actually need access to elements, so we use empty string as key. IDC is still given, but we will not be able to access control later.
	[0.4*_pW,2*_pH,10*_pW,1*_pH],
	"Sniper rifles", //This text will be displayed
	"PuristaMedium", //Used fonts. See article https://community.bistudio.com/wiki/FXY_File_Format for all available fonts. Exile have own scripts as well.
	1, //Text size. Play around with it, to get best result. Default is 1.
	"#FFFFFFFF", //Text color in HTML format. Use BIS_fnc_colorRGBAtoHTML to convert [1,1,1,1] color format to "#FFFFFFFF"
	"left", //Text align. Can be "left", "right", "center"
	0, //Shadow. 0 = no shadow 1 = classic shadow (can be colored) 2 = outline (always black)
	"#FFFFFFFF" //Shadow color
] call _makeStructuredText;

//Finally lets clean currently selected rifle.
XM8_exampleApp_selectedRifle = "";

//Lets create several controls, in such a way that they will change color/picture to random when mouse cursor gets on them.

//Lets set text 
[
	_exampleSlide1,
	("" call _getNextIDC),
	[0.4*_pW,9*_pH,10*_pW,1*_pH],
	"Wonky colors","PuristaMedium",
	1,
	([random 1, random 1, random 1, 1] call BIS_fnc_colorRGBAtoHTML), //Lets randomise color
	"left",
	1,
	([random 1,random 1,random 1,1] call BIS_fnc_colorRGBAtoHTML) //Lets randomise color
] call _makeStructuredText;

//Lets make wonky picture
_somePictures = []; //First make empty array for our pictures
{ //Now lets scan config for some pictures
	_value = getText (_x >> "picture");
	if (!isNil "_value") then { //if class have picture lets add it to array
		_somePictures pushBack _value;
	};
} forEach ("getText (_x >> 'picture') != ''" configClasses (configfile >> "CfgWeapons"));
//Lets make control now
_ctrl = [
	_exampleSlide1,
	("randomColorPic1" call _getNextIDC),
	[0.4*_pW,10.5*_pH,4.6*_pW,4*_pH], //in order to make almost perfectly squared control, it`s width should be 1.15 times bigger then it`s height.
	//Lets set randomized procedural texture as "picture". See https://community.bistudio.com/wiki/Procedural_Textures for more info.
	(_somePictures call BIS_fnc_selectRandom), //We can execute code here as well, but make sure correct results returned.
	[random 1, random 1, random 1,1], //[1,1,1,1] will set picture`s color to fully visiable and not tinted.
	true, //TRUE if this picture should be enabled. Use FALSE for background pictures with no interections. We use TRUE in this case as we need to capture cursor enter event.
	true, //TRUE if you want to keep picture`s aspect ratio. FALSE if you want to stratch it to control`s size.
	"" //Tooltip
] call _makePicture;
//Lets set action for this wonky picture
_ctrl ctrlSetEventHandler ["MouseEnter", 
	('
		_ctrl = _this select 0;
		_somePictures = '+ (str _somePictures) +'; 
		_ctrl ctrlSetText (_somePictures call BIS_fnc_selectRandom);
		_ctrl ctrlSetTextColor [random 1, random 1, random 1,1];
	') // Lets "insert" array of pictures to action, so we dont scan configs twice.
];

//Lets make wonky procedural colored picture
_ctrl = [
	_exampleSlide1,
	("randomColorPic2" call _getNextIDC),
	[5.1*_pW,10.5*_pH,4.6*_pW,4*_pH], //in order to make almost perfectly squared control, it`s width should be 1.15 times bigger then it`s height.
	//Lets set randomized procedural texture as "picture". See https://community.bistudio.com/wiki/Procedural_Textures for more info.
	(format ["#(rgb,8,8,3)color(%1,%2,%3,1)", random 1, random 1, random 1]), //We can execute code here as well, but make sure correct results returned.
	[1,1,1,1], //[1,1,1,1] will set picture`s color to fully visiable and not tinted.
	true, 
	true,
	""
] call _makePicture;
//Lets set action for this wonky picture
_ctrl ctrlSetEventHandler ["MouseEnter", 
	'
		_ctrl = _this select 0;
		_ctrl ctrlSetText (format ["#(rgb,8,8,3)color(%1,%2,%3,1)", random 1, random 1, random 1]);
	'
];

//Lets make wonky colored background
_ctrl = [
	_exampleSlide1,
	("randomColorPic3" call _getNextIDC),
	[9.8*_pW,10.5*_pH,4.6*_pW,4*_pH],
	[random 1, random 1, random 1, random 1], //Lets set randomized background color
	TRUE, //We need this background enabled, as we going to set mouse enter eventhandler on it.
	""
] call _makeBackground;
//Lets set action for this wonky background
_ctrl ctrlSetEventHandler ["MouseEnter", 
	'
		_ctrl = _this select 0;
		_ctrl ctrlSetBackgroundColor [random 1, random 1, random 1, random 1];
	'
];

//Lets make button to start delayed process and progressbar to show its status

//Lets create text above list box
[_exampleSlide1,("" call _getNextIDC),[16.4*_pW,2*_pH,5*_pW,1*_pH],"Process","PuristaMedium",1,"#FFFFFFFF","left",0,"#FFFFFFFF"] call _makeStructuredText;

//Lets create "START" button
[
	_exampleSlide1,
	("startProcessButton" call _getNextIDC),
	[22.4*_pW,2*_pH,4*_pW,1*_pH],
	'[] spawn XM8_exampleApp_delayedProcess', //In this case we want to spawn external funtion.
	"START",
	"Press this button to start delayed process"
] call _makeButton;

//Lets create progress bar
[
	_exampleSlide1,
	("progressBar" call _getNextIDC),
	[16.4*_pW,3*_pH,10*_pW,1*_pH],
	0, //Initial amount of progress
	true, //TRUE to enable control , FALSE to disable
	[1,1,1,1], //Progress bar color
	true, //TRUE to show control, FALSE to hide
	""
] call _makeProgressBar;

//Lets make frame around progress bar
[_exampleSlide1,("" call _getNextIDC),[16.4*_pW,3*_pH,10*_pW,1*_pH]] call _makeFrame;

//Lets make control that will update each time slide is opened.
[
	_exampleSlide1,
	("infoText" call _getNextIDC),
	[0,0,0,0], //We dont need to set initial position. We will set it each time slide opened
	"", //We dont need text initially. We will fill it in each time slide opened
	"PuristaMedium",
	1,
	"#FFFFFFFF",
	"left",
	0,
	"#FFFFFFFF"
] call _makeStructuredText;









