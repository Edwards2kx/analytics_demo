import 'package:analytics_demo/config/app_router.dart';
import 'package:analytics_demo/providers/bluetooth_info_provider.dart';
import 'package:analytics_demo/providers/device_info_provider.dart';
import 'package:analytics_demo/providers/network_info_provider.dart';
import 'package:analytics_demo/providers/poi_info_provider.dart';
import 'package:analytics_demo/providers/third_party_apps_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DeviceInfoProvider()),
        ChangeNotifierProvider(create: (_) => ThirdPartyAppsInfoProvider()),
        ChangeNotifierProvider(create: (_) => NetworkInfoProvider()),
        ChangeNotifierProvider(create: (_) => BluetoothInfoProvider()),
        ChangeNotifierProvider(create: (_) => PoiInfoProvider()),
      ],
      child: MaterialApp.router(
        title: 'Demo Análitica',
        routerConfig: appRouter,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
      ),
    );
  }
}
