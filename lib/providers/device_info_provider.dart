import 'dart:io';

import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoProvider with ChangeNotifier {
  final _deviceInfo = DeviceInfoPlugin();
  // BaseDeviceInfo deviceInfo

  Future<BaseDeviceInfo?> getDeviceInfo() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      debugPrint('Running on ${androidInfo.model}');
      debugPrint("toda la info \n $androidInfo"); // e.g. "Moto G (4)"
      return androidInfo;
    } else {
      return null;
    }
  }
}
