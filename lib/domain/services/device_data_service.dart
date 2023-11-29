import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import '../models/user_data.dart';

class DeviceDataService {
  final UserData userData;

  DeviceDataService({required this.userData});
//POI

  Future<void> getUserDataInfo() async {
    //location
    try {
      final poiInfo = await Geolocator.getCurrentPosition();
      final location = Location(
          latitute: poiInfo.latitude,
          longitude: poiInfo.longitude,
          altitude: poiInfo.altitude,
          isMocked: poiInfo.isMocked);
      userData.location = location;
    } catch (e) {
      debugPrint('error $e');
    }

    try {} catch (e) {
      debugPrint('exception: $e');
    }

    try {} catch (e) {
      debugPrint('exception: $e');
    }
  }
}
