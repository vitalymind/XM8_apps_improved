// XM8 apps Imporeved by vitaly'mind'chizhikov
// Based on idea XM8 apps by Shix. see http://www.exilemod.com/topic/9040-xm8-apps/?page=1

/*
Example
XM8_apps_app1 = [
	"DeployBike",
	"XM8_apps\bikeLog.paa",
	{execVM"custom\deploy_bike.sqf";}
];
Comment out apps, that you dont use.
*/

XM8_apps_app1 = [
	"Repair mate",
	"custom\XM8_repairMate\icons\repairMate_icon.paa",
	{0 execVM "custom\XM8_repairMate\scripts\XM8_repairMate_init.sqf"}
];
/*
XM8_apps_app2 = [
	"App 2",
	"",
	{}
];
XM8_apps_app3 = [
	"App 3",
	"",
	{}
];
XM8_apps_app4 = [
	"App 4",
	"",
	{}
];
XM8_apps_app5 = [
	"App 5",
	"",
	{}
];
XM8_apps_app6 = [
	"App 6",
	"",
	{}
];
XM8_apps_app7 = [
	"App 7",
	"",
	{}
];
XM8_apps_app8 = [
	"App 8",
	"",
	{}
];
XM8_apps_app9 = [
	"App 9",
	"",
	{}
];
XM8_apps_app10 = [
	"App 10",
	"",
	{}
];
XM8_apps_app11 = [
	"App 11",
	"",
	{}
];
XM8_apps_app12 = [
	"App 12",
	"",
	{}
];
XM8_apps_app13 = [
	"App 13",
	"",
	{}
];
*/

//Dont change whats below :)
XM8_apps_folderPath = _this;