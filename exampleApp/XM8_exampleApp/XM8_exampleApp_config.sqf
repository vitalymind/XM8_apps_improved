/*	XM8 Example app by vitaly'mind'chizhikov
	
	This script serves as example, how to make applications for Improved XM8 apps.
	See http://www.exilemod.com/topic/13295-xm8-apps-improved-xm8-repair-mate/
*/

/*
	file: XM8_exampleApp\XM8_exampleApp_config.sqf
	function: no function
	
	This is configuration file for example app.
	Allow users to configure certain aspects of your app behaviour in here.
	Remember to properly comment each variable or function, also it is good 
	idea to give some examples.
*/

//This value represent how long it take to finish "process" in seconds. 
XM8_exampleApp_secondsForDelayedAction = 3;

//Type of weapon to be selectable. 
//Possible values "sniper rifle", "machine guns", "assault rifles"
XM8_exampleApp_selectableWeaponType = "machine guns";