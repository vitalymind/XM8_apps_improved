/*
	Improved XM8 apps by vitaly'mind'chizhikov
	Official forum thread: 
	Original idea by Shix.
*/

/*
Example
XM8_apps_app1 = [
	"Deploy Bike", //Text displayed on app button
	"deployBike\bikeIcon.paa", //Icon displayd on app button
	{execVM "deployBike\deploy_bike.sqf";}, //Script executed when app button pressed
	FALSE, //FALSE if this is legacy app. TRUE if this app is compatible with Improved XM8 apps.
	"" //Empty string ("") for legacy apps. Path to scripts init file for applications, compatible with Improved XM8 apps
];
XM8_apps_app2 = [
	"Example app",
	"XM8_apps\apps\XM8_exampleApp\icons\exampleIcon.paa",
	{["exampleSlide_1", 0] call ExileClient_gui_xm8_slide},
	TRUE,
	"XM8_apps\apps\XM8_exampleApp\scripts\XM8_exampleApp_init.sqf"
];
Comment out apps, that you dont use.
If you dont have icon, use default one "XM8_apps\icons\generic_app.paa"
Always use full path from mission root folder
*/

XM8_apps_app1 = [
	"Example app",
	"XM8_apps\apps\XM8_exampleApp\icons\exampleIcon.paa",
	{["exampleSlide1", 0] call ExileClient_gui_xm8_slide},
	true,
	"XM8_apps\apps\XM8_exampleApp\scripts\XM8_exampleApp_init.sqf"
];
XM8_apps_app2 = [
	"Empty app",
	"XM8_apps\icons\generic_app.paa",
	{["emptySlide", 0] call ExileClient_gui_xm8_slide},
	true,
	"XM8_apps\apps\XM8_emptyApp\scripts\XM8_emptyApp_init.sqf"
];
XM8_apps_app3 = [
	"View Distance",
	(getText (configFile >> "CfgWeapons" >> "Binocular" >> "picture")),
	{execVM "XM8_apps\apps\VeiwDistance.sqf"},
	false,
	""
];
XM8_apps_app4 = [
	"Repair Mate",
	"XM8_apps\apps\XM8_repairMate\icons\repairMate_icon.paa",
	{call XM8_repairMate_checkNearByVehicles},
	true,
	"XM8_apps\apps\XM8_repairMate\scripts\XM8_repairMate_init.sqf"
];
/*
XM8_apps_app5 = [
	"App 5",
	"",
	{},
	false,
	""
];
XM8_apps_app6 = [
	"App 6",
	"",
	{},
	false,
	""
];
XM8_apps_app7 = [
	"App 7",
	"",
	{},
	false,
	""
];
XM8_apps_app8 = [
	"App 8",
	"",
	{},
	false,
	""
];
XM8_apps_app9 = [
	"App 9",
	"",
	{},
	false,
	""
];
XM8_apps_app10 = [
	"App 10",
	"",
	{},
	false,
	""
];
XM8_apps_app11 = [
	"App 11",
	"",
	{},
	false,
	""
];
XM8_apps_app12 = [
	"App 12",
	"",
	{},
	false,
	""
];
XM8_apps_app13 = [
	"App 13",
	"",
	{},
	false,
	""
];
XM8_apps_app14 = [
	"App 14",
	"",
	{},
	false,
	""
];
XM8_apps_app15 = [
	"App 15",
	"",
	{},
	false,
	""
];
*/

//Dont change whats below :)
XM8_apps_folderPath = _this;