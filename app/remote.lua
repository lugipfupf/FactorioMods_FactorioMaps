
local interface = {}

function interface.reset_player(player_name_or_index)
    local player = game.players[player_name_or_index]
    local player_data = global.player_data[player.index]

    player.character = player.selected
    player_data.viewing_site = nil
    player_data.real_character = nil
    player_data.remote_viewer = nil
end

function interface.regen()
    hideMainWindow(game.player.index);
    showMainWindow(game.player.index);
end

function interface.right()
    if(checkRightPane(game.player.index)) then
        hideRightPane(game.player.index);
    else
        showRightPane(game.player.index);
    end
end

function interface.dereg()
    Gui.on_checked_state_changed("FactorioMaps_", nil);
    Gui.on_click("FactorioMaps_", nil);
    Gui.on_text_changed("FactorioMaps_", nil);
    Gui.Event.register(defines.events.on_gui_text_changed, "FactorioMaps_folderName", nil);
end

function interface.old()
    local ui = game.player.gui.left.factoriomaps;
    if(ui == nil) then
        drawgui(1)
    else
        ui.destroy();
    end
end

function interface.reset()
    interface.regen()
    interface.right()
end
remote.add_interface("fm", interface)
