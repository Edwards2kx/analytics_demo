import 'package:flutter/material.dart';
import 'package:wifi_hunter/wifi_hunter.dart';
import 'package:wifi_hunter/wifi_hunter_result.dart';

class NetworkInfoProvider with ChangeNotifier {
  Future<WiFiHunterResult?> getNearbyNetworks() async {
    try {
      final response = await WiFiHunter.huntWiFiNetworks;
      return response;
    } catch (e) {
      debugPrint('error $e');
      return null;
    }
  }

  // Future<void> getConnectionType() async {}

  // Future<void> getInfoCurrentNetwork() async {}
}
