
function fm.setupConfig()
    global.config = {};
    global.config.dayOnly = true;
    global.config.altInfo = false;
    global.config.folderName = "TempNameChangeMe!";
    global.config.customSize = false;
    global.config.topLeftX = -1000;
    global.config.topLeftY = -1000;
    global.config.bottomRightX = 1000;
    global.config.bottomRightY = 1000;
    global.config.mapQuality = 3; -- Medium
    global.config.extension = 1; -- jpg

    --Special holders for player data
    global._players = {};

    --Special holders for the radio elements.
    global._radios = {};
end
