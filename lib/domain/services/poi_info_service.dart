import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class PoiInfoService {
  static Future<Position?> getLocation() async {
    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      debugPrint('error $e');
      return null;
    }
  }
}
