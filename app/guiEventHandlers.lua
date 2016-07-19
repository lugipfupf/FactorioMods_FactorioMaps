
if not gui then
    gui = {};
end

function gui.registerAllHandlers()
    Gui.on_click("FactorioMaps_advancedButton", gui.advancedButton)
end

function gui.advancedButton(event)
    if (checkRightPane(event.player_index)) then
        hideRightPane(event.player_index);
    else
        showRightPane(event.player_index);
    end
end
