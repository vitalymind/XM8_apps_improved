class CfgXM8 {
	//This slide use IDCs from 104140 to 104156
	class sideApps {
		controlID = 104140;
		title = "XM8 Apps";
		onLoadScript = "";
	};
	//This slide use IDCs from 352500 to 
	class exampleSlide1 {
		controlID = 352500;
		title = "Example app. Main slide.";
		onLoadScript = "XM8_apps\apps\XM8_exampleApp\scripts\XM8_exampleApp_exampleSlide1_onLoad.sqf";
	};
	//This slide use IDCs from 452500 to 
	class exampleSlide2 {
		controlID = 452500;
		title = "Example app. Sub slide.";
		onLoadScript = "XM8_apps\apps\XM8_exampleApp\scripts\XM8_exampleApp_exampleSlide2_onLoad.sqf";
	};
};