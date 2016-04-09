Improved XM8 apps for Exile mod
This script adds "apps" button to XM8.
This allow use of custom scripts and slides in Exile

Authors
code - vitaly'mind'chizhikov
art - DaCoon

This script was inspired by XM8apps by Shix.
See http://www.exilemod.com/topic/9040-xm8-apps/

This script doing preatty much same thing, hovewer,
there are following deferences:
 - Sliding functionality of Exile is used in natural way.
 - Go back button is there.
 - Script allow creating custom slides and use them 
   naturally via exile`s functions.
 - Script does not take away any buttons, "Territory"
   button is shrinked to half size instead.

XM8 RepairMate, vehicle repair script, that is
released along, can be used as example, how to make,
own slides and navigate slides back and forth.

INSTALLATION
1) Paste XM8_apps folder into root mission folder.
2) Add following line to initPlayerLocal.sqf.
	"" execVM "XM8_apps\XM8_apps_config.sqf";
		Adjust path to folder according to where you put it.
		if you dont place XM8_apps folder into root mission folder. Then adjust code accordinly. 
		For example, if you put XM8_apps to folder "custom\" code will be as follows.
		"custom\" execVM "custom\XM8_apps\XM8_apps_config.sqf";
3) Add following line to description.ext at the very bottom.
	#include "XM8_apps\XM8_apps_sliders.hpp"
		Adjust path to folder according to where you put it.
		For example, if you put XM8_apps to folder "custom\" code will be as follows.
		#include "custom\XM8_apps\XM8_apps_sliders.hpp"
4) Add following lines to CfgExileCustomCode class inside config.cpp
	class CfgExileCustomCode 
	{
		ExileClient_gui_xm8_show = "custom\XM8_apps\scripts\ExileClient_gui_xm8_show.sqf";
		ExileClient_gui_xm8_slide_apps_onOpen = "custom\XM8_apps\scripts\ExileClient_gui_xm8_slide_apps_onOpen.sqf";
		ExileClient_gui_xm8_slide = "custom\XM8_apps\scripts\ExileClient_gui_xm8_slide.sqf";
	};
		Adjust path to files according to where you put them.
5) Edit XM8_apps_config.sqf according to instructions provided with apps you want to have.
6) Edit XM8_apps_sliders.hpp according to instructions provided with apps you want to have. 
7) Enjoy!