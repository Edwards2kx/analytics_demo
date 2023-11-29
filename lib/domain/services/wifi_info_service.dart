import 'package:flutter/foundation.dart';
import 'package:wifi_hunter/wifi_hunter.dart';
import 'package:wifi_hunter/wifi_hunter_result.dart';

class WifiInfoService {
  Future<WiFiHunterResult?> getNearbyNetworks() async {
    try {
      final response = await WiFiHunter.huntWiFiNetworks;
      // response.results.first.
      return response;
    } catch (e) {
      debugPrint('error $e');
      return null;
    }
  }
}
