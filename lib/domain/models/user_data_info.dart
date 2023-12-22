import 'dart:convert';
import 'bt_device_info.dart';
import 'device_info.dart';
import 'installed_app_info.dart';
import 'user_location_info.dart';
import 'wifi_network_info.dart';

class UserDataInfo {
  UserLocationInfo? location;
  List<WifiNetworkInfo>? wifiNetworkList;
  List<BTDeviceInfo>? btDeviceInfoList;
  DeviceInfo? deviceData;
  String? networkType;
  List<InstalledAppInfo>? installedAppList;
  UserDataInfo({
    this.location,
    this.wifiNetworkList,
    this.deviceData,
    this.networkType,
    this.btDeviceInfoList,
    this.installedAppList
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location?.toMap(),
      'wifi_network_list': wifiNetworkList?.map((x) => x.toMap()).toList(),
      'device_data': deviceData?.toMap(),
      'network_type': networkType,
      'bt_device_list' : btDeviceInfoList?.map((x) => x.toMap()).toList(),
      'installed_app_list' : installedAppList?.map((x) => x.toMap()).toList()
    };
  }

  String toJson() => json.encode(toMap());


  @override
  String toString() {
    return 'UserData(location: $location, wifiNetworkList: $wifiNetworkList, btDevices: $btDeviceInfoList, deviceData: $deviceData, networkType: $networkType , installedAppList : $installedAppList)';
  }
}





