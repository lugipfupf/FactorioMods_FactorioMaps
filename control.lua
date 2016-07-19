

-- Parts of FactorioMaps
--require "app.generateIndex"
require "app.guiLayout"
require "app.remote"
require "app.viewer"

script.on_init(function()
    gui.registerAllHandlers()
end);

script.on_load(function()
    gui.registerAllHandlers()
end);
