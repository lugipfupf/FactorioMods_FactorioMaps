
--Include needed stdlib libs.
require "stdlib/config/config"
require "stdlib/entity/entity"
require "stdlib/event/gui"
require "stdlib/game"
require "stdlib/log/logger"
require 'stdlib/utils/string'

fm = {}
fm.log = Logger.new("FactorioMaps", "debug", true)

require "fm.config"
require "fm.generateIndex"
require "fm.generateMap"
require "fm.gui"
require "fm.helpers"
require "fm.migrations"
require "fm.remote"
require "fm.viewer"

require "autorun"

script.on_init(function()
    global.config = {}
    global.player_data = {}
    global._radios = {}

    fm.cfg = Config.new( global.config )
    fm.config.applyDefaults()
    fm.gui.showAllMainButton()
end)

script.on_load(function()
    --[[
        The damn global table is plain annoying to work with.
        modification to the global table from the global scope works but will NOT
          saved to the game save file.
        Any modifications here causes Factorio to blow up as of 0.13.5

        So in conclusion never touch this line.
        Gotta catch the migrations properly.
    ]]--
    if global.config then
        fm.cfg = Config.new( global.config )
    end
end)


script.on_event(defines.events.on_tick, function(event)
    game.player.print(game.tick)
 end)

script.on_configuration_changed(function (event)
    for modName,modTable in pairs(event.mod_changes) do
        if modName == "FactorioMaps" and modTable.old_version ~= nil then
            fm.migrations.doUpdate(modTable.old_version, modTable.new_version)
        end
    end
end)

script.on_event(defines.events.on_player_created, function(event)
    fm.gui.showMainButton(event.player_index)
end)

script.on_event(defines.events.on_tick, function(event)

    if fm.autorun then

        event.player_index = 1
        if fm._ticks == nil then
            game.players[event.player_index].surface.daytime = 0
            fm._topfolder = fm.autorun.path
            
            -- freeze all entities. Eventually, stuff will run out of power, but for just 2 ticks, it should be fine.
            -- for key, entity in pairs(game.players[event.player_index].surface.find_entities_filtered({})) do
            --     entity.active = false
            -- end
            
            
            -- Remove ghosts
            for _,entity in pairs(game.surfaces[1].find_entities_filtered{type= "entity-ghost"}) do
                entity.destroy()
            end
            for _,entity in pairs(game.surfaces[1].find_entities_filtered{type= "tile-ghost"}) do
                entity.destroy()
            end
            fm.gui.actions.baseSize(event)
            fm._ticks = 1
        elseif fm._ticks < 2 then
            fm._ticks = 2
        elseif fm._ticks < 3 then
            fm._ticks = 3
        elseif fm._ticks < 4 then
            fm._ticks = 4
        elseif fm._ticks < 5 then
            fm._ticks = 5
        elseif fm._ticks < 6 then
            fm._ticks = 6
        elseif fm._ticks < 7 then
            -- remove no path sign
            for key, entity in pairs(game.players[event.player_index].surface.find_entities_filtered({type="flying-text"})) do
                entity.destroy()
            end
            if fm.autorun.day then
                fm._subfolder = "Day"
                fm.gui.actions.generate(event)
            end
            fm._ticks = 7
        elseif fm._ticks < 8 then
            game.players[event.player_index].surface.daytime = 0.5
            fm._ticks = 8
        elseif fm._ticks < 9 then
            fm._ticks = 9
        elseif fm._ticks < 10 then
            fm._ticks = 10
        elseif fm._ticks < 11 then
            fm._ticks = 11
        elseif fm._ticks < 12 then
            fm._ticks = 12
        elseif fm._ticks < 13 then
            fm._ticks = 13
        elseif fm._ticks < 14 then
            fm._ticks = 14
        elseif fm._ticks < 15  then
            
            -- remove no path sign
            for key, entity in pairs(game.players[event.player_index].surface.find_entities_filtered({type="flying-text"})) do
                entity.destroy()
            end
    
            
            if fm.autorun.night then
                fm._subfolder = "Night"
                fm.gui.actions.generate(event)
            end
    
            fm._ticks = 15
            
        elseif fm._ticks < 16  then
    
            -- for key, entity in pairs(game.players[event.player_index].surface.find_entities_filtered({})) do
            --     entity.active = true
            -- end

            fm._subfolder = nil
            fm._topfolder = nil
    
            fm._ticks = 16
            game.write_file("FactorioMaps/done.txt", "done", false, event.player_index)
        end

    else

        fm.gui.updateCoords()
        if fm.cfg.get("resetDay") then
            if game.tick > fm.cfg.get("resetDayTick") + 3 then
                fm.helpers.makeDay(fm.cfg.get("resetDayFor"), true)
            end
        end
    end
end)
