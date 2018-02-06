function fm.generateIndex(data)
    -- generate index.html
    local pathName = "FactorioMaps/" .. data.folderName .. "/index.html"

    local indexText = [[
<!DOCTYPE html>
<html>
<head>
<title>Factorio Maps</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.3.1/leaflet.css" integrity="sha256-iYUgmrapfDGvBrePJPrMWQZDcObdAcStKBpjP3Az+3s=" crossorigin="anonymous" />
<style type="text/css">
    html { height: 100% }
    body { height: 100%; margin: 0px; padding: 0px; overflow: hidden }
    #map_canvas { min-height: 100%; height: 100%; }
    #gmnoprint { width: auto; }
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.3.1/leaflet.js" integrity="sha256-CNm+7c26DTTCGRQkM9vp7aP85kHFMqs9MhPEuytF+fQ=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet-hash/0.2.1/leaflet-hash.min.js" integrity="sha256-xFr923AFMh1B7s9GIWcWodj1t7IPr0QYKEJx40rDcYY=" crossorigin="anonymous"></script>
</head>
<body>
<div id="map_canvas" style="background: #1B2D33;"></div>

<script>
var map = L.map('map_canvas').setView([0, 0], 3);

L.tileLayer('Images/{z}_{x}_{y}.]]
    --debug set isPNG in right place
--    if(data.extension == 2) then
--        indexText = indexText .. [[
--            if (zoom === ]].. data.index.maxZoomLevel..[[) {
--                ext = "png";
--            } else {
--                ext = "jpg";
--            }
--            ]]
    if(data.extension==3) then
        indexText = indexText .. "png"
    else
        indexText = indexText .. "jpg"
    end
    indexText = indexText .. [[', {
    attribution: '<a href="https://mods.factorio.com/mods/credomane/FactorioMaps">FactorioMaps</a>',
    minZoom: ]].. data.index.minZoomLevel .. [[,
    maxZoom: ]].. data.index.maxZoomLevel .. [[,
    noWrap: true,
    tileSize: 1024,
}).addTo(map);
new L.Hash(map);
map.zoomControl.setPosition('topright')
</script>
</body>
</html>
]]

    game.write_file(pathName, indexText, false, data.player_index)

end
