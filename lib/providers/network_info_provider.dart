import 'package:flutter/material.dart';
import 'package:wifi_hunter/wifi_hunter.dart';
import 'package:wifi_hunter/wifi_hunter_result.dart';

class NetworkInfoProvider with ChangeNotifier {
  // WiFiHunterResult wiFiHunterResult = WiFiHunterResult();

  Future<WiFiHunterResult?> getNearbyNetworks() async {
    try {
      return await WiFiHunter.huntWiFiNetworks;
    } catch (e) {
      debugPrint('error $e');
      return null;
    }
  }

  Future<void> getConnectionType() async {}

  Future<void> getInfoCurrentNetwork() async {}
}
