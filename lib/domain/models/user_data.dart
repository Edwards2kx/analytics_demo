// ignore_for_file: public_member_api_docs, sort_constructors_first
//informacion que cambia constantemente
class UserData {
//informacion de ubicacion
  Location? location;
//listado de aplicaciones guardadas
//listado elementos bluetooth

//listado de redes wifi cercanas
}

class Location {
  double latitute;
  double longitude;
  double altitude;
  bool isMocked; //always false on iOS
  Location({
    required this.latitute,
    required this.longitude,
    required this.altitude,
    required this.isMocked,
  });
}

class WifiNetwork {
  String ssid;
  String bssid;
  String timeStamp;
  int levelInDb;
  String capabilities;
  int frequency;
  int channelWidth;
  WifiNetwork({
    required this.ssid,
    required this.bssid,
    required this.timeStamp,
    required this.levelInDb,
    required this.capabilities,
    required this.frequency,
    required this.channelWidth,
  });
}
