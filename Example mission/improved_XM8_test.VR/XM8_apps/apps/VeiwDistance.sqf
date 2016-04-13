/*
View Distance script made by Shix
http://www.exilemod.com/profile/4566-shix/
Made for XM8 Apps http://www.exilemod.com/topic/9040-updated-xm8-apps/
*/
/////////////////
//CONFIG
////////////////
_minVeiwDis = 500; //Minimum Veiw Distance
_maxVeiwDist = 6000; //Maximum Veiw Distance

_minObjViewDist = 500; //Minimum Object Veiw Distance
_maxObjViewDist = 3000; //Maximum Object Veiw Distance
/////////////////
//CONFIG END
////////////////

disableSerialization;
_display = uiNameSpace getVariable ["RscExileXM8", displayNull];

//set XM8 title
(_display displayCtrl 4004) ctrlSetStructuredText (parseText (format ["<t align='center' font='RobotoMedium'>View Distance</t>"]));

_curViewDist = viewDistance;
_curObjViewDist = getObjectViewDistance select 0;

_xm8Controlls = [991,881,992,882,993,883,994,884,995,885,996,886,997,887,998,888,999,889,9910,8810,9911,8811,9912,8812];
{
    _fade = _display displayCtrl _x;
    _fade ctrlSetFade 1;
    _fade ctrlCommit 0.5;
} forEach _xm8Controlls;
{
    ctrlDelete ((findDisplay 24015) displayCtrl _x);
} forEach _xm8Controlls;
uiSleep 0.2;

//Creates View distnce Slider
_VeiwDistSlider = _display ctrlCreate ["RscXSliderH", 1120];
_VeiwDistSlider ctrlSetPosition [(13 - 3) * (0.025), (9 - 2) * (0.04),(0.5),(0.05)];
_VeiwDistSlider ctrlCommit 0;
_VeiwDistSlider ctrlSetEventHandler ["SliderPosChanged","_this call fnc_updateViewDist"];
_VeiwDistSlider sliderSetRange [_minVeiwDis, _maxVeiwDist];
_VeiwDistSlider  sliderSetSpeed [100, 2];
_VeiwDistSlider sliderSetPosition _curViewDist;

//Creates Current view distance text
_curViewDistText = _display ctrlCreate ["RscStructuredText", 1119];
_curViewDistText ctrlSetPosition [(13 - 3) * (0.025), (10.3 - 2) * (0.04),(0.5),(0.04)];
_curViewDistText ctrlCommit 0;

//creates obj View fistnce Slider
_ObjVeiwDistSlider = _display ctrlCreate ["RscXSliderH", 1112];
_ObjVeiwDistSlider ctrlSetPosition [(13 - 3) * (0.025), (13 - 2) * (0.04),(0.5),(0.05)];
_ObjVeiwDistSlider ctrlCommit 0;
_ObjVeiwDistSlider ctrlSetEventHandler ["SliderPosChanged","_this call fnc_updateObjViewDist"];
_ObjVeiwDistSlider sliderSetRange [_minObjViewDist, _maxObjViewDist];
_ObjVeiwDistSlider  sliderSetSpeed [100, 2];
_ObjVeiwDistSlider sliderSetPosition _curObjViewDist;
//_ObjVeiwDistSlider sliderSetPosition [1112, _curObjViewDist];

//Creates Current object view distance text
_curObjViewDistText = _display ctrlCreate ["RscStructuredText", 1114];
_curObjViewDistText ctrlSetPosition [(13 - 3) * (0.025), (14.3- 2) * (0.04),(0.5),(0.04)];
_curObjViewDistText ctrlCommit 0;
(_display displayCtrl 1114) ctrlSetStructuredText (parseText (format ["Current object view distance: %1",_curObjViewDist]));
(_display displayCtrl 1119) ctrlSetStructuredText (parseText (format ["Current view distance: %1",_curViewDist]));

_GoBackBtn = _display ctrlCreate ["RscButtonMenu", 1116];
_GoBackBtn ctrlSetPosition [(32 - 3) * (0.025),(20 - 2) * (0.04),6 * (0.025),1 * (0.04)];
_GoBackBtn ctrlCommit 0;
_GoBackBtn ctrlSetText "Go Back";
_GoBackBtn ctrlSetEventHandler ["ButtonClick", "[]spawn fnc_goBack"];

//function to update view distance
fnc_updateViewDist = {
_display = uiNameSpace getVariable ["RscExileXM8", displayNull];
_VDSliderPos = _this select 1;
setViewDistance _VDSliderPos;
_curViewDist = _VDSliderPos;
(_display displayCtrl 1119) ctrlSetStructuredText (parseText (format ["Current view distance: %1",_curViewDist]));
};

//function to update object view distance
fnc_updateObjViewDist = {
_display = uiNameSpace getVariable ["RscExileXM8", displayNull];
_OVDSliderPos = _this select 1;
setObjectViewDistance  _OVDSliderPos;
_curObjViewDist = _OVDSliderPos;
(_display displayCtrl 1114) ctrlSetStructuredText (parseText (format ["Current object view distance: %1",_OVDSliderPos]));
};

fnc_goBack = {
  _display = uiNameSpace getVariable ["RscExileXM8", displayNull];
  _vdCtrls = [1120,1119,1112,1114,1116];
  {
      _ctrl = (_display displayCtrl _x);
      _ctrl ctrlSetFade 1;
      _ctrl ctrlCommit 0.25;
      ctrlEnable [_x, false];
  } forEach _vdCtrls;
  execVM "xm8Apps\XM8Apps_Init.sqf";
  uiSleep 1;
  {
    ctrlDelete ((findDisplay 24015) displayCtrl _x);
  } forEach _vdCtrls;
};
