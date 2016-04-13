/*	XM8 Example app by vitaly'mind'chizhikov
	
	This script serves as example, how to make applications for Improved XM8 apps.
	See http://www.exilemod.com/topic/13295-xm8-apps-improved-xm8-repair-mate/
*/
/*
	file: XM8_exampleApp\scripts\ExileClient_gui_xm8_slide_exampleSlide1_onOpen.sqf
	function: ExileClient_gui_xm8_slide_exampleSlide1_onOpen
	
	This script will be executed everytime when related slide opened.
	It is best place to update slide (show players money for example).
*/

systemChat format ["Example app. Main slide shown %1",time];

//Lets private all local variable used here. It is very important to always private all local variables. Trust me, this will save you alot of otherwise pulled hairs.
private ["_pW","_pH","_display","_color","_text","_pos","_infoText","_getControl"];

//Lets define few usefull variables that are used here.
_pW = 0.025; //This is our vertical grid multiplyer, usefull for control placement
_pH = 0.04; //This is our horizontal grid multiplyer, usefull for control placement
//We need pointer to XM8 dialog (display), lets get it
_display = uiNameSpace getVariable ["RscExileXM8", displayNull];
if (isNull _display) exitWith {_error = "Error loading XM8 Example app, display is null"; systemChat _error; diag_log _error;};


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

//Lets define settings
_color = [random 1, random 1, random 1, 1] call BIS_fnc_colorRGBAtoHTML;
_text = "This text like to jump around and change color";
_pos = [(17+(random 6))*_pW,(5+(random 5))*_pH,10*_pW,6*_pH];

//Lets
_infoText = "infoText" call _getControl;

//Lets set position and text and color of our text info
_infoText ctrlSetPosition _pos;
_infoText ctrlSetStructuredText (parseText format ["<t size='1' color='%2'>%1</t>",_text, _color]);
//It is mandatory to execure control commit after setting position
_infoText ctrlCommit 0;
	



