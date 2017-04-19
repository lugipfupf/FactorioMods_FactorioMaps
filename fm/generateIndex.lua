function fm.generateIndex(data)
    -- generate index.html
    local pathName = "FactorioMaps/" .. data.folderName .. "/index.html"

    local indexText = [[
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<style type="text/css">
    html { height: 100% }
    body { height: 100%; margin: 0px; padding: 0px }
    #map_canvas { height: 100%; z-index: 0;}
    #gmnoprint {width: auto;}
</style>
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
<title>Factorio Maps</title>
<!-- For local use, don't change anything. For server (making it available on a website) use, get a Google Maps API key (get one here: https://developers.google.com/maps/documentation/javascript/get-api-key), paste your key in the line below this one where it says "INSERTAPIKEY", uncomment the line below and two lines down delete the second <!-- and the first --> 
 <!-- <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=INSERTAPIKEY"></script> -->
 <!-- --> <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js"></script> <!-- -->
<script>
function CustomMapType() {}

CustomMapType.prototype.tileSize = new google.maps.Size(]] .. data.index.gridSize .. "," .. data.index.gridSize .. [[);
CustomMapType.prototype.minZoom = ]].. data.index.minZoomLevel .. [[;
CustomMapType.prototype.maxZoom = ]].. data.index.maxZoomLevel .. [[;
CustomMapType.prototype.getTile = function(coord, zoom, ownerDocument) {
    var div = ownerDocument.createElement('DIV');
    var baseURL = 'Images/';
    ]]
    --debug set isPNG in right place
    if(data.extension == 2) then
        indexText = indexText .. [[
            if (zoom === ]].. data.index.maxZoomLevel..[[) {
                ext = "png";
            } else {
                ext = "jpg";
            }
            ]]
    elseif(data.extension==3) then
        indexText = indexText .. [[ext = "png";
]]
    else
        indexText = indexText .. [[ext = "jpg";
]]
    end
    indexText = indexText .. [[
    baseURL += zoom + '_' + coord.x + '_' + coord.y + '.' + ext;
    div.style.width = this.tileSize.width + 'px';
    div.style.height = this.tileSize.height + 'px';
    div.style.backgroundImage = 'url(' + baseURL + ')';
    return div;
};

//(-180 + math.ceil(-1*tonumber(txtTopLeftX.text) + tonumber(txtBottomRightX.text))/2)
CustomMapType.prototype.name = "Custom";
CustomMapType.prototype.alt = "Tile Coordinate Map Type";
var map;
var CustomMapType = new CustomMapType();

function update_url() {
    var center = map.getCenter();
    var zoom = map.getZoom();
    var href = location.href;

    href = href.split("#")[0] || href;
    window.location.replace(href + '#' + center.lat().toFixed(2) + ',' + center.lng().toFixed(2) + ',' + zoom);
}

function hash_changed() {
    var urlbits = window.location.hash.split('#');
    if(urlbits[1])
    {
        locationbits = urlbits[1].split(',');
        map.setCenter({lat: parseFloat(locationbits[0]), lng: parseFloat(locationbits[1])});
        map.setZoom(parseInt(locationbits[2]));
    }
}

if ("onhashchange" in window) {
    window.onhashchange = hash_changed
}

function initialize() {
    var mapOptions = {
        zoom: ]].. (data.index.minZoomLevel) ..[[,
        // minZoom: ]]..(data.index.minZoomLevel) ..[[,
        // maxZoom: ]].. (data.index.maxZoomLevel == 1 and (data.index.maxZoomLevel - 1) or data.index.maxZoomLevel) ..[[,
        isPng: false,
        mapTypeControl: false,
        streetViewControl: false,
        center: new google.maps.LatLng(]].. 0 ..",".. 0 ..[[ ),
        mapTypeControlOptions: {
            mapTypeIds: ['custom', google.maps.MapTypeId.ROADMAP],
            style: google.maps.MapTypeControlStyle.DROPDOWN_MENU
        }
    };
    map = new google.maps.Map(document.getElementById("map_canvas"),mapOptions);
    map.mapTypes.set('custom',CustomMapType);
    map.setMapTypeId('custom');

    hash_changed()

    map.addListener('center_changed', update_url);
    map.addListener('zoom_changed', update_url);


//  addmarker();
//  addoutline();
}

function addmarker(){
    var marker = new google.maps.Marker({
        position: new google.maps.LatLng(85,-180),
        map: map,
    // optimized: false,
        title:"Hello World!"
    });
    var marker = new google.maps.Marker({
        position: new google.maps.LatLng(-85,-180),
        map: map,
    // optimized: false,
        title:"Hello World!"
    });
}

function addoutline()
{
    var flightPlanCoordinates = [
    ]]

--    for k,v in pairs(data.index.linesArray) do
--        indexText = indexText .. "new google.maps.LatLng(".. v.lat ..",".. v.lng .."),\r\n"
--    end

        indexText = indexText .. [[
    ];
    var flightPath = new google.maps.Polyline({
      path: flightPlanCoordinates,
      strokeColor: '#FF0000',
    //  strokeOpacity: 1.0,
      strokeWeight: 2
    });

    flightPath.setMap(map);
}
</script>
</head>
<body onload="initialize()">
<div id="map_canvas" style="background: #1B2D33;"></div>
</body>
</html>]]

    game.write_file(pathName, indexText)

end
