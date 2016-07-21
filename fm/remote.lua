
fm.remote = {};

function fm.remote.reset_player(player_name_or_index)
    local player = game.players[player_name_or_index]
    local player_data = global.player_data[player.index]

    player.character = player.selected
    player_data.viewing_site = nil
    player_data.real_character = nil
    player_data.remote_viewer = nil
end

function fm.remote.regen()
    fm.gui.hideMainButton(game.player.index);
    fm.gui.showMainButton(game.player.index);
    fm.gui.hideMainWindow(game.player.index);
end

function fm.remote.right()
    if(fm.gui.checkRightPane(game.player.index)) then
        fm.gui.hideRightPane(game.player.index);
    else
        fm.gui.showRightPane(game.player.index);
    end
end

function fm.remote.reset()
    fm.remote.regen()
    fm.remote.right()
end

function fm.remote.migrate()
    fm.migrations.to_0_7_0();
end

remote.add_interface("fm", fm.remote)
