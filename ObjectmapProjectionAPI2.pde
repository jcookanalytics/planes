import org.gicentre.utils.spatial.*;    // For map projections.

//classes
MapInfo usMap;
Planes plane;

void setup()
{ 
  size(1570,868);
  //MapInfo(String map, float tllat, float tllong, float brlat, float brlong)
  //tllat = top left corner latitude
  //tllong = top left corner longitude
  //brlat = bottom right corner latitude
  //brlong = bottom right corner longitude
  //Provide info on the map to be used
  usMap = new MapInfo("Capture.PNG",-126.035, 51.727,-57.041, 21.861);
}

// ------------------------ Processing draw -------------------------

void draw()
{
  // Planes(String id, int red, int green, int blue, int alpha, int strokeWeight)
  // Find flight using https://opensky-network.org/api/states/all copy id into where icao24="id"
  // Planes("a086d8",150,50,50,127,6);
  plane = new Planes("a8aac8",150,50,50,127,6);
  //plane = new Planes();
  
  //read the plane location data
  //for(int i=5;i<planeArray.length;i= i+17){
  plane.readData(plane.lat, plane.lng);
  //loop running plane coordinates. This has a delay set in it
  plane.planeCoord();
  //}
}