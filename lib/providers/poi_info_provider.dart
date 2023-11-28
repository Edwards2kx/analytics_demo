import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class PoiInfoProvider with ChangeNotifier {
  Future<Position?> getLocation() async {
    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      debugPrint('error $e');
      return null;
    }
  }
}
