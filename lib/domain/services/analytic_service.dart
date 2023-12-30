import 'dart:convert';
import 'package:analytics_demo/domain/models/info_analytics.dart';
import 'package:flutter/foundation.dart';
import '../../infrastructure/shared/http_server.dart';
import '../models/user_data_info.dart';
import 'device_data_service.dart';

const String kPathForAppList = '/config';

/// "/info"
// const String kPathToSendData = '/info';
const String kPathToSendData = '/post';

class AnalyticService {
  //TODO: debe ser un singleton
  final String key;
  final String endpoint;
  final InfoAnalytics infoAnalytics = InfoAnalytics(userData: UserDataInfo());
  final DeviceDataService infoService = DeviceDataService();

  List<String> _thirdPartyAppsToLookUp = [];
  AnalyticService({required this.key, required this.endpoint});

//TODO: cambiar a una clase abstracta
  final _httpServer = CustomHttpServer();

//TODO:esto deberia ejecutarse solo al iniciar la app android o invocar el metodo de obtener apps
  Future<List<String>> getThirdPartyAppsFromServer() async {
    try {
      final response = await _httpServer.getRequest(kPathForAppList);
      if (response == null) return [];
      // final Map<String, List<String>> jsonResponse = jsonDecode(response);
      // _thirdPartyAppsToLookUp = jsonResponse.values.first;
      // debugPrint(jsonResponse.toString());
      // return _thirdPartyAppsToLookUp;
      final jsonResponse = jsonDecode(response);
      debugPrint(jsonResponse.toString());
      return [];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<bool> sendAnalyticInfoToServer() async {
    final userDataInfo = await infoService.getUserInfoAnalytics();
    // final requestBody = userDataInfo?.toJson();
    final requestBody = jsonEncode(<String, String>{
      'unique_id': '013e69c7c47efa6527bf8132b6146d85b1d7a3d5'
    });
    //  final requestBody = userDataInfo?.toMap();

    debugPrint('deviceInfo json:\n $requestBody');
    try {
      final response =
          await _httpServer.postRequest(kPathToSendData, requestBody);
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
