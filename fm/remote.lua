
fm.remote = {};

function fm.remote.reset_player(player_name_or_index)
    local player = game.players[player_name_or_index]
    local player_data = global.player_data[player.index]

    player.character = player.selected
    player_data.viewing_site = nil
    player_data.real_character = nil
    player_data.remote_viewer = nil
end

--Testing migrations.
--TODO: DELETE ME
function fm.remote.migrate()
    fm.migrations.to_0_7_0();
end

remote.add_interface("fm", fm.remote)
