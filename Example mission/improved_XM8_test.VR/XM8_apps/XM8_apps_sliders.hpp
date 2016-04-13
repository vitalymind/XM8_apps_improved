class CfgXM8 {
	//This slide use IDCs from 104140 to 104156
	class sideApps {
		controlID = 104140;
		title = "XM8 Apps";
		onLoadScript = "";
	};
	//This slide use IDCs from 960050 to 960140
	class repairMate {
		controlID = 960050;
		title = "Repair Mate";
		onLoadScript = "XM8_apps\apps\XM8_repairMate\scripts\XM8_repairMate_repairMate_onLoad.sqf";
	};
	//This slide use IDCs from 352500 to 352513
	class exampleSlide1 {
		controlID = 352500;
		title = "Example app. Main slide.";
		onLoadScript = "XM8_apps\apps\XM8_exampleApp\scripts\XM8_exampleApp_exampleSlide1_onLoad.sqf";
	};
	//This slide use IDCs from 362500 to 362502
	class exampleSlide2 {
		controlID = 362500;
		title = "Example app. Sub slide.";
		onLoadScript = "XM8_apps\apps\XM8_exampleApp\scripts\XM8_exampleApp_exampleSlide2_onLoad.sqf";
	};
	//This slide use IDCs from 666000 to 666001
	class emptySlide {
		controlID = 666000;
		title = "Empty app`s, empty slide";
		onLoadScript = "XM8_apps\apps\XM8_emptyApp\scripts\XM8_emptyApp_emptySlide_onLoad.sqf";
	};
};