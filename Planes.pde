class Planes{
  // Presentation of planes
  String id;
  int red;
  int green;
  int blue;
  int alpha;
  int strokeWeight;
  String lat;
  String lng;
  PVector tlCorner,brCorner;   // Corners of map in WebMercator coordinates.
  ArrayList<PVector>coords;
 
  //stroke(150,50,50,127);
  //strokeWeight(6);
  Planes(){
  String raw[] = loadStrings("https://opensky-network.org/api/states/all");
  String raw2 = raw[0];
  int allLength = raw2.length();
  String subraw2 = raw2.substring(0,allLength-3);
  String subraw = subraw2.substring(28,allLength-3);
  String[] planeArray = split(subraw,',');
  int planeLength = planeArray.length;
  //this.planeArray[] = planeArray;
  }
  
  Planes(String id,int red, int green, int blue, int alpha, int strokeWeight){
    String raw[] = loadStrings("https://opensky-network.org/api/states/all?icao24="+id);
    String[] planes = split(raw[0],',');
    try{
    this.lat = planes[6];
    this.lng = planes[7];
    println(lat+" "+ lng+" "+planes[8]);
    }
    catch(Exception e){
    println("Lost Contact or Plane Landed");
    }
    this.red = red;
    this.green = green;
    this.blue = blue;
    this.alpha = alpha;
    this.strokeWeight = strokeWeight;
    stroke(red,green,blue,alpha);
    strokeWeight(strokeWeight);
    
  }
  void readData(String lng2, String lat2)
{
  // Read the GPS data
  String[] geoCoords = {lng2+" " +lat2};
  
  WebMercator proj = new WebMercator();
  
  // Convert the GPS coordinates from lat/long to WebMercator
  coords = new ArrayList<PVector>();  
  for (String line: geoCoords)
  {
    String[] geoCoord = split(line.trim()," ");
    float lng = float(geoCoord[0]);
    float lat = float(geoCoord[1]);
    coords.add(proj.transformCoords(new PVector(lng,lat)));
  } 
  
  // Store the WebMercator coordinates of the corner of the map.
  // The lat/long of the corners
  //MapInfo(String map, float tllat, float tllong, float brlat, float brlong)
  tlCorner = proj.transformCoords(new PVector(usMap.tllat, usMap.tllong));
  brCorner = proj.transformCoords(new PVector(usMap.brlat, usMap.brlong));
}

// Convert from WebMercator coordinates to screen coordinates.
PVector geoToScreen(PVector geo)
{
  return new PVector(map(geo.x,tlCorner.x,brCorner.x,0,width),
                     map(geo.y,tlCorner.y,brCorner.y,0,height));
}

void planeCoord() {
  for (PVector coord : coords)
  {
    PVector scrCoord = geoToScreen(coord);
    ellipse(scrCoord.x,scrCoord.y,10,10);
  }
  delay(15000);
}
}

  