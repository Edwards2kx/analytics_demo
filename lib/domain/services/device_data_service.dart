import 'dart:io';
import 'package:analytics_demo/domain/models/bt_device_info.dart';
import 'package:device_apps/device_apps.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_uuid/device_uuid.dart';
import 'package:disk_space_plus/disk_space_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:system_info_plus/system_info_plus.dart';
import 'package:wifi_hunter/wifi_hunter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/device_info.dart';
import '../models/info_analytics.dart';
import '../models/installed_app_info.dart';
import '../models/user_data_info.dart';
import '../models/user_location_info.dart';
import '../models/wifi_network_info.dart';

class DeviceDataService {
// el constructor lleva los assert que verifica los permisos en los archivos de configuracion de las plataformas
//android manifest y info.plist

  Future<UserDataInfo?> getUserDataInfo() async {
    final userData = UserDataInfo();
    try {
      userData.deviceData = await getDeviceData();
      userData.location = await getUserLocation();
      userData.networkType = await getNetworkType();
      userData.wifiNetworkList = await getWifiNetworkInfo();

      return userData;
    } catch (e) {
      debugPrint('Excepción $e');
      return null;
    }
  }

//TODO: extraer a otra clase que será la visible y llamar a los metodos dentro de este servicio
//al final se debe terminar con una llamada http a un servicio REST
  Future<InfoAnalytics?> getUserInfoAnalytics() async {
    final userData = UserDataInfo();
    try {
      userData.deviceData = await getDeviceData();
      userData.location = await getUserLocation();
      userData.networkType = await getNetworkType();
      userData.wifiNetworkList = await getWifiNetworkInfo();
      userData.btDeviceInfoList = await getBTDevicesInfo();
      userData.installedAppList = await getInstalledAppsInfo();
      final infoAnalytics = InfoAnalytics(userData: userData);
      return infoAnalytics;
    } catch (e) {
      debugPrint('Excepción $e');
      return null;
    }
  }

  //el hace todo para info de dispositivo
  Future<DeviceInfo?> getDeviceData() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final uuid = await DeviceUuid().getUUID();
      final diskSpace = await DiskSpacePlus.getTotalDiskSpace;
      final freeSpace = await DiskSpacePlus.getFreeDiskSpace;
      final ramSize = await SystemInfoPlus.physicalMemory;
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return DeviceInfo(
        identifier: uuid,
        cpu: androidInfo.board,
        manufacturer: androidInfo.manufacturer,
        model: androidInfo.model,
        operativeSystem: 'ANDROID',
        soVersion: androidInfo.version.release,
        isPhysicalDevice: androidInfo.isPhysicalDevice,
        totalStorage: diskSpace,
        freeStorage: freeSpace,
        ramSize: ramSize,
      );
    } else if (Platform.isIOS) {
      final diskSpace = await DiskSpacePlus.getTotalDiskSpace;
      final freeSpace = await DiskSpacePlus.getFreeDiskSpace;
      final ramSize = await SystemInfoPlus.physicalMemory;
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      final deviceData = DeviceInfo(
        identifier: iosInfo.identifierForVendor,
        cpu: '',
        manufacturer: 'Apple',
        model: iosInfo.model,
        operativeSystem: 'IOS',
        soVersion: iosInfo.systemVersion,
        isPhysicalDevice: iosInfo.isPhysicalDevice,
        totalStorage: diskSpace,
        freeStorage: freeSpace,
        ramSize: ramSize,
      );
      return deviceData;
    }
    return null;
  }

  Future<UserLocationInfo?> getUserLocation() async {
    //check for permission, if denied just report null dont try to get permission
    final locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.always ||
        locationPermission == LocationPermission.whileInUse) {
      try {
        final poiInfo = await Geolocator.getCurrentPosition();
        UserLocationInfo location = UserLocationInfo(
            latitute: poiInfo.latitude,
            longitude: poiInfo.longitude,
            altitude: poiInfo.altitude,
            timeStamp: poiInfo.timestamp,
            isMocked: poiInfo.isMocked);
        try {
          List<Placemark> placemarks = await placemarkFromCoordinates(
              poiInfo.latitude, poiInfo.longitude);
          if (placemarks.isNotEmpty) {
            location.administrativeArea = placemarks[0].administrativeArea;
            location.country = placemarks[0].country;
            location.locality = placemarks[0].locality;
          }
        } catch (e) {
          debugPrint('error $e');
        }
        return location;
      } catch (e) {
        debugPrint('error $e');
      }
    } else {
      debugPrint('Location permission may denied $locationPermission');
    }
    return null;
  }

  Future<String> getNetworkType() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return 'mobile';
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return 'wifi';
    }
    return 'unknown';
  }

  Future<List<WifiNetworkInfo>?> getWifiNetworkInfo() async {
    List<WifiNetworkInfo> wifiNetworks = [];
    if (!Platform.isAndroid) return null;
    try {
      final wifiHunterResults = await WiFiHunter.huntWiFiNetworks;
      if (wifiHunterResults != null) {
        for (var wifiResult in wifiHunterResults.results) {
          final wifiNetwork = WifiNetworkInfo(
              ssid: wifiResult.ssid,
              bssid: wifiResult.bssid,
              timeStamp: DateTime.now().toIso8601String(),
              levelInDb: wifiResult.level,
              capabilities: wifiResult.capabilities,
              frequency: wifiResult.frequency,
              channelWidth: wifiResult.channelWidth);
          wifiNetworks.add(wifiNetwork);
        }
        return wifiNetworks;
      }
    } catch (e) {
      debugPrint('error $e');
    }
    return null;
  }

  Future<List<BTDeviceInfo>> getBTDevicesInfo() async {
    //TODO: terminar el metodo
    // final BTDeviceInfo btDeviceInfo = BTDeviceInfo(mac: mac, services: services)
    return [];
  }

  ///usa el package Device_apps
  ///requiere el permiso android.permission.QUERY_ALL_PACKAGES;
  Future<List<InstalledAppInfo>> getInstalledAppsInfo() async {
    if (Platform.isAndroid) {
      List<Application> apps = await DeviceApps.getInstalledApplications();
      return apps
          .map(
            (app) => InstalledAppInfo(
                appName: app.appName,
                packageName: app.packageName,
                versionName: app.versionName),
          )
          .toList();
    } else if (Platform.isIOS) {
      //TODO: terminar el metodo
      return [];
    }
    return [];
  }
}
