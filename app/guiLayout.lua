require "stdlib.gui.gui"
require "guiEventHandlers"

--------------------------------
-- MAIN WINDOW
--------------------------------
function checkMainWindow(player_index_or_name)
    local player = game.players[player_index_or_name];
    if (not player or not player.valid or not player.connected) then
        return false;
    end
    if (player.gui.left.FactorioMaps ~= nil) then
        return true;
    end
    return false;    
end

function getMainWindow(player_index_or_name)
    local player = game.players[player_index_or_name];
    if (not player or not player.valid or not player.connected) then
        return nil;
    end
    if (checkMainWindow(player_index_or_name)) then
        return player.gui.left.FactorioMaps;
    end
    return nil;
end
    
function showMainWindow(player_index_or_name)
    local player = game.players[player_index_or_name];
    if (not player or not player.valid or not player.connected) then
        return;
    end
    if (not checkMainWindow(player_index_or_name)) then
        player.gui.left.add({type="frame", name="FactorioMaps", caption={"label-main-window"}, direction="horizontal"});
        showLeftPane(player_index_or_name);
    end
end

function hideMainWindow(player_index_or_name)
    local mainWindow = getMainWindow(player_index_or_name);
    if (mainWindow) then
        mainWindow.destroy();
    end
end

--------------------------------
-- MAIN WINDOW LEFT PANE
--------------------------------
function checkLeftPane(player_index_or_name)
    if (checkMainWindow(player_index_or_name)) then
        local mainWindow = getMainWindow(player_index_or_name);
        if (mainWindow.Left ~= nil) then
            return true;
        end
    end
    return false;    
end

function getLeftPane(player_index_or_name)
    if (checkLeftPane(player_index_or_name)) then
        return getMainWindow(player_index_or_name).Left;
    end
    return nil;
end
    
function showLeftPane(player_index_or_name)
    if (checkLeftPane(player_index_or_name)) then
        return;
    end
    if (not checkMainWindow(player_index_or_name)) then
        showMainWindow(player_index_or_name);
        return;
    end
    local mainWindow = getMainWindow(player_index_or_name);
    local leftPane = mainWindow.add({type="frame", name="Left", caption={"label-main-settings"}, direction="vertical"});

    local topFlow = leftPane.add({type="flow", name="topFlow", direction = "horizontal"});
    local topLeftFlow = topFlow.add({type="flow", name="topLeftFlow", direction = "vertical"});
    topLeftFlow.add({type="checkbox", name="FactorioMaps_dayOnly", state = true, caption = {"label-day-only"}, tooltip={"tooltip-day-only"}});
    topLeftFlow.add({type="checkbox", name="FactorioMaps_altInfo", state = true, caption = {"label-alt-info"}, tooltip={"tooltip-alt-info"}});
    local topRightFlow = topFlow.add({type="flow", name="topRightFlow", direction = "horizontal"});
    topRightFlow.add({type="label", name="filler", caption="_____________"});
    topRightFlow.filler.style.font_color = {r=48,g=75, b=74};
    topRightFlow.add({type="button", name="FactorioMaps_advancedButton", style="FactorioMaps_button_style", caption={"button-advanced-settings"}, tooltip={"tooltip-advanced-settings"}});

    local folderFlow = leftPane.add({type="flow", name="folderFlow", direction = "horizontal"});
--    folderFlow.style.minimal_width = 250;
--    folderFlow.style.maximal_width = 250;
    folderFlow.add({type="label", name="label_folder-name", caption = {"label-folder-name"}, tooltip={"tooltip-folder-name"}});
    folderFlow.add({type="textfield", name="FactorioMaps_folderName", tooltip={"tooltip-folder-name"}});

    local bottomFlow = leftPane.add({type="flow", name="bottomFlow", direction = "horizontal"});
    bottomFlow.add({type="button", name="FactorioMaps_maxSize", style="FactorioMaps_button_style", caption={"button-max-size"}, tooltip={"tooltip-max-size"}});
    bottomFlow.add({type="button", name="FactorioMaps_baseSize", style="FactorioMaps_button_style", caption={"button-base-size"}, tooltip={"tooltip-base-size"}});
    bottomFlow.add({type="label", name="filler", caption="_____________"});
    bottomFlow.filler.style.font_color = {r=48,g=75, b=74};
    bottomFlow.add({type="button", name="FactorioMaps_generate", style="FactorioMaps_button_style", caption={"button-generate"}, tooltip={"tooltip-generate"}});
end

function hideLeftPane(player_index_or_name)
    local leftPane = getLeftPane(player_index_or_name);
    if (leftPane) then
        leftPane.destroy();
    end
end

--------------------------------
-- MAIN WINDOW RIGHT PANE (ADVANCED SETTINGS)
--------------------------------
function checkRightPane(player_index_or_name)
    if (checkMainWindow(player_index_or_name)) then
        local mainWindow = getMainWindow(player_index_or_name);
        if (mainWindow.Right ~= nil) then
            return true;
        end
    end
    return false;    
end

function getRightPane(player_index_or_name)
    if (checkRightPane(player_index_or_name)) then
        return getMainWindow(player_index_or_name).Right;
    end
    return nil;
end
    
function showRightPane(player_index_or_name)
    if (checkRightPane(player_index_or_name)) then
        return;
    end
    if (not checkMainWindow(player_index_or_name)) then
        showMainWindow(player_index_or_name);
    end
    local mainWindow = getMainWindow(player_index_or_name);

    local rightPane = mainWindow.add({type="frame", name="Right", caption={"label-advanced-settings"}, direction="vertical"});
    rightPane.add({type="checkbox", name="FactorioMaps_customSize", state = false, caption = {"label-custom-size"}, tooltip={"tooltip-custom-size"}});

    local tbl = rightPane.add({type="table", name="topFlow", colspan = 6});
    tbl.add({type="label", name="label_top-left-xy", caption = {"label-top-left-xy"}, tooltip={"tooltip-top-left-xy"}});
    local topLeftX = tbl.add({type="textfield", name="FactorioMaps_topLeftX", tooltip={"tooltip-top-left-x"}});
    topLeftX.style.minimal_width = 50;
    topLeftX.style.maximal_width = 50;
    local topLeftY = tbl.add({type="textfield", name="FactorioMaps_topLeftY", tooltip={"tooltip-top-left-y"}});
    topLeftY.style.minimal_width = 50;
    topLeftY.style.maximal_width = 50;
    tbl.add({type="sprite-button", name="FactorioMaps_topLeftView", sprite="FactorioMaps_view_sprite", style="FactorioMaps_sprite_button", tooltip={"tooltip-top-left-view"}});
    tbl.add({type="sprite-button", name="FactorioMaps_topLeftReturn", sprite="FactorioMaps_return_sprite", style="FactorioMaps_sprite_button", tooltip={"tooltip-top-left-return"}});
    tbl.add({type="sprite-button", name="FactorioMaps_topLeftPlayer", sprite="FactorioMaps_player_sprite", style="FactorioMaps_sprite_button", tooltip={"tooltip-top-left-player"}});

    tbl.add({type="label", name="label_bottom-right-xy", caption = {"label-bottom-right-xy"}, tooltip={"tooltip-bottom-right-xy"}});
    local bottomRightX = tbl.add({type="textfield", name="FactorioMaps_bottomRightX", tooltip={"tooltip-bottom-right-x"}});
    bottomRightX.style.minimal_width = 50;
    bottomRightX.style.maximal_width = 50;
    local bottomRightY = tbl.add({type="textfield", name="FactorioMaps_bottomRightY", tooltip={"tooltip-bottom-right-y"}});
    bottomRightY.style.minimal_width = 50;
    bottomRightY.style.maximal_width = 50;
    tbl.add({type="sprite-button", name="FactorioMaps_bottomRightView", sprite="FactorioMaps_view_sprite", style="FactorioMaps_sprite_button", tooltip={"tooltip-bottom-right-view"}});
    tbl.add({type="sprite-button", name="FactorioMaps_bottomRightReturn", sprite="FactorioMaps_return_sprite", style="FactorioMaps_sprite_button", tooltip={"tooltip-bottom-right-return"}});
    tbl.add({type="sprite-button", name="FactorioMaps_bottomRightPlayer", sprite="FactorioMaps_player_sprite", style="FactorioMaps_sprite_button", tooltip={"tooltip-bottom-right-player"}});

    local middleFlow2 = rightPane.add({type="flow", name="middleFlow2", direction = "horizontal"});
    local middleFlow3 = rightPane.add({type="flow", name="middleFlow3", direction = "horizontal"});
    local bottomFlow = rightPane.add({type="flow", name="bottomFlow", direction = "horizontal"});
end

function hideRightPane(player_index_or_name)
    local rightPane = getRightPane(player_index_or_name);
    if (rightPane) then
        rightPane.destroy();
    end
end

--------------------------------
-- THE OLD CODE
--------------------------------



function drawgui(player_index)

	if (ui ~= nil) then
		savevalues(player_index)
	end


	if (game.players[player_index].gui.left.factoriomaps ~= nil) then
		game.players[player_index].gui.left.factoriomaps.destroy()
	end
		game.players[player_index].gui.left.add({type="frame", name="factoriomaps", caption="Factorio Maps", direction="horizontal"})

help = false
advanced = true
		ui = game.players[player_index].gui.left.factoriomaps

		if (ui.menu_ver1 == nil) then
			ui.add({type="frame", name="menu_ver1",direction="vertical"})

			ui.menu_ver1.add({type="flow", name="menu2", direction = "horizontal"})

			ui.menu_ver1.menu2.add({type="label", caption = "Time:"})
			ui.menu_ver1.menu2.add({type="button", name="setdaytime", caption="Midday"})
			ui.menu_ver1.menu2.add({type="button", name="resetdaytime", caption="Reset"})
			ui.menu_ver1.menu2.add({type="label", name="filler", caption="_____________"})
			ui.menu_ver1.menu2.filler.style.font_color = {r=48,g=75, b=74}
			ui.menu_ver1.menu2.add({type="button", name="advancedbutton", caption="Advanced"})

			if (help) then
				ui.menu_ver1.add({type="label", name="help1", caption = "Use Midday to make brightly lit screenshots,"})
				ui.menu_ver1.add({type="label", name="help2", caption = "then set the time to what it was before with Reset."})
				ui.menu_ver1.help1.style.font_color = {r=1}
				ui.menu_ver1.help2.style.font_color = {r=1}
			end

			ui.menu_ver1.add({type="flow", name="menu3", direction = "horizontal"})
			ui.menu_ver1.menu3.add({type="checkbox", name="maxzoomcheckbox1", state = false, caption = "Maximum zoom in"})
			ui.menu_ver1.menu3.add({type="checkbox", name="maxzoomcheckbox2", state = false, caption = "Maximum zoom out (experimental)"})
			checkboxmaxzoom1 = game.players[player_index].gui.left.factoriomaps.menu_ver1.menu3.maxzoomcheckbox1
			checkboxmaxzoom2 = ui.menu_ver1.menu3.maxzoomcheckbox2

			if (help) then
				ui.menu_ver1.add({type="label", name="help3", caption = "Max zoom in makes you zoom in one extra level."})
				ui.menu_ver1.add({type="label", name="help4", caption = "Max zoom out makes you zoom out one extra level."})
				ui.menu_ver1.add({type="label", name="help5", caption = "Extra zoom out may cause weird screen shots."})
				ui.menu_ver1.help3.style.font_color = {r=1}
				ui.menu_ver1.help4.style.font_color = {r=1}
				ui.menu_ver1.help5.style.font_color = {r=1}
			end
			ui.menu_ver1.add({type="flow", name="menu3a", direction = "horizontal"})
			ui.menu_ver1.menu3a.add({type="checkbox", name="showalt",state=false, caption = "Show entity (Alt) info"})
			if (help) then
				ui.menu_ver1.add({type="label", name="help3a", caption = "Alt info shows the function of an assembly building."})
				ui.menu_ver1.help3a.style.font_color = {r=1}
			end
			ui.menu_ver1.add({type="flow", name="menu4", direction = "horizontal"})
			ui.menu_ver1.menu4.add({type="label", name="foldernamelabel", caption = "Folder Name:"})
			ui.menu_ver1.menu4.add({type="textfield", name="foldername"})
			txtFolderName = ui.menu_ver1.menu4.foldername
			ui.menu_ver1.menu4.add({type="button", name="generate", caption="Generate images"})

			if (help) then
				ui.menu_ver1.add({type="label", name="help6", caption = "Press the Generate button to start making the map."})
				ui.menu_ver1.add({type="label", name="help7", caption = "The program will generate a folder name for you"})
				ui.menu_ver1.help6.style.font_color = {r=1}
				ui.menu_ver1.help7.style.font_color = {r=1}
			end


			ui.menu_ver1.add({type="label", name="generatewarning"})
			ui.menu_ver1.add({type="label", name="generatewarning2"})


			if warning then
				ui.menu_ver1.generatewarning.style.font_color = {r=1,b=0, g=0}
				ui.menu_ver1.generatewarning.caption="Warning: On bigger maps, Factorio Maps can take up to 10 minutes and 5 GB of disk space!"
				ui.menu_ver1.generatewarning2.caption="The game will freeze until everything is generated."
			end

			if help then


			end
		end


	--if (ui.menu_ver2 == nil and advanced) then

		ui.add({type="frame", name="menu_ver2", direction="vertical"})

		ui.menu_ver2.add({type="flow", name="menu1", direction = "horizontal"})

		ui.menu_ver2.menu1.add({type="label", name="topleftlabel", caption = "Top left x/y:"})
		ui.menu_ver2.menu1.add({type="textfield", name="toplefttextX", caption=""})
		ui.menu_ver2.menu1.add({type="textfield", name="toplefttextY", caption=""})
		txtTopLeftX = ui.menu_ver2.menu1.toplefttextX
		txtTopLeftY = ui.menu_ver2.menu1.toplefttextY
		ui.menu_ver2.menu1.add({type="button", name="teleport1", caption="tp"})
		ui.menu_ver2.menu1.add({type="button", name="useplayerposition1", caption="pp"})

		ui.menu_ver2.add({type="flow", name="menu2", direction = "horizontal"})
		ui.menu_ver2.menu2.add({type="label", name="bottomrightlabel", caption = "Bottom right x/y:"})
		ui.menu_ver2.menu2.add({type="textfield", name="bottomrighttextX", caption=""})
		ui.menu_ver2.menu2.add({type="textfield", name="bottomrighttextY", caption=""})
		txtBottomRightX = ui.menu_ver2.menu2.bottomrighttextX
		txtBottomRightY = ui.menu_ver2.menu2.bottomrighttextY
		ui.menu_ver2.menu2.add({type="button", name="teleport2", caption="tp"})
		ui.menu_ver2.menu2.add({type="button", name="useplayerposition2", caption="pp"})

		ui.menu_ver2.add({type="flow", name="menu3", direction = "horizontal"})
		ui.menu_ver2.menu3.add({type="button", name="maxdiscovered", caption="Max Size"})
		ui.menu_ver2.menu3.add({type="button", name="cropbase", caption="Crop to Base"})

		ui.menu_ver2.add({type="flow", name="menu3a", direction = "horizontal"})
		ui.menu_ver2.menu3a.add({type="label", caption = "Grid size:"})
		ui.menu_ver2.menu3a.add({type="checkbox", name="gridsizecheckbox1",state = (gridsizeindex==1 and "true" or "false"), caption = "256x256"})
		ui.menu_ver2.menu3a.add({type="checkbox", name="gridsizecheckbox2",state = (gridsizeindex==2 and "true" or "false"), caption = "1024x1024"})
		ui.menu_ver2.menu3a.add({type="checkbox", name="gridsizecheckbox3",state = (gridsizeindex==3 and "true" or "false"), caption = "2048x2048"})
		radiogridsize1 = game.players[player_index].gui.left.factoriomaps.menu_ver2.menu3a.gridsizecheckbox1
		radiogridsize2 = game.players[player_index].gui.left.factoriomaps.menu_ver2.menu3a.gridsizecheckbox2
		radiogridsize3 = game.players[player_index].gui.left.factoriomaps.menu_ver2.menu3a.gridsizecheckbox3
		if (help) then
			ui.menu_ver2.add({type="label", name="help8", caption = "For some people 1024 was lagging, try 256. Use 2048 at own risk."})
			ui.menu_ver2.help8.style.font_color = {r=1}
		end
		ui.menu_ver2.add({type="flow", name="menu4", direction = "horizontal"})
		ui.menu_ver2.menu4.add({type="label", caption = "Ext:"})
		ui.menu_ver2.menu4.add({type="checkbox", name="extensioncheckbox1",state = (extensionindex==1 and "true" or "false"), caption = ".jpg"})
		ui.menu_ver2.menu4.add({type="checkbox", name="extensioncheckbox2",state = (extensionindex==2 and "true" or "false"), caption = ".png (only max zoom in)"})
		ui.menu_ver2.menu4.add({type="checkbox", name="extensioncheckbox3",state = (extensionindex==3 and "true" or "false"), caption = ".png (all)"})
		if (help) then
			ui.menu_ver2.add({type="label", name="help9", caption = "Png gives better quality screenshots, but is (much) bigger in filesize."})
			ui.menu_ver2.help9.style.font_color = {r=1}
		end

		radioextension1 = game.players[player_index].gui.left.factoriomaps.menu_ver2.menu4.extensioncheckbox1
		radioextension2 = game.players[player_index].gui.left.factoriomaps.menu_ver2.menu4.extensioncheckbox2
		radioextension3 = game.players[player_index].gui.left.factoriomaps.menu_ver2.menu4.extensioncheckbox3

		ui.menu_ver2.add({type="flow", name="menuplayerxy", direction = "horizontal"})
		ui.menu_ver2.menuplayerxy.add({type="button", name="helpbutton", caption = "Help"})
		ui.menu_ver2.menuplayerxy.add({type="label", name="playerxylabel", caption = "Player x/y:"})
		ui.menu_ver2.menuplayerxy.add({type="label", name="playerxy", caption = "0,0"})
	--end
end
