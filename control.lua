
--Include needed stdlib libs.
require "stdlib.core"
require "stdlib.entity.entity"
require "stdlib.game"
require "stdlib.gui.gui"
require "stdlib.log.logger"
require "stdlib.string"

fm = {}
fm.log = Logger.new("fm","debug",true);

require "fm.config"
--require "fm.generateIndex"
--require "fm.generateMap"
require "fm.gui"
require "fm.migrations"
require "fm.remote"
require "fm.viewer"

script.on_init(function()
    global._radios = {};
    fm.gui.showAllMainButton();
end);

script.on_configuration_changed(function (event)
    for modName,modTable in pairs(event.mod_changes) do
        if modName == MOD_FULLNAME then
            fm.migrations.doUpdate(modTable.old_version, modTable.new_version);
        end
    end
end);

script.on_event(defines.events.on_player_created, function(event)
    fm.gui.showMainButton(event.player_index);
end);

script.on_event(defines.events.on_tick, function(event)
    fm.gui.updateCoords();
end);
