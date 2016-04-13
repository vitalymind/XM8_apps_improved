/*	XM8 Example app by vitaly'mind'chizhikov
	
	This script serves as example, how to make applications for Improved XM8 apps.
	See http://www.exilemod.com/topic/13295-xm8-apps-improved-xm8-repair-mate/
*/
/*
	file: XM8_exampleApp\scripts\ExileClient_gui_xm8_slide_exampleSlide2_onOpen.sqf
	function: ExileClient_gui_xm8_slide_exampleSlide2_onOpen
	
	This script will be executed everytime when related slide opened.
	It is best place to update slide (show players money for example).
*/

systemChat format ["Example app. Sub slide shown %1",time];