class MapInfo{
  //properties
  // image for map, and floats for latitude and longitude of map 
  String map;
  float tllat;
  float tllong;
  float brlat;
  float brlong;
  PImage backgroundMap;        // OpenStreetMap.
MapInfo(String map, float tllat, float tllong, float brlat, float brlong){
  this.map = map;
  this.tllat = tllat;
  this.tllong = tllong;
  this.brlat = brlat;
  this.brlong = brlong;
  backgroundMap = loadImage(map);
    // Background map.
  image(backgroundMap,0,0,width,height);
}
}