import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

class ThirdPartyAppsInfoProvider with ChangeNotifier {
  Future<List<Application>> getAppsInstalled() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(
        includeSystemApps: false, includeAppIcons: true);
    // List<Application> apps = await DeviceApps.getInstalledApplications();
    return apps;
  }
}
