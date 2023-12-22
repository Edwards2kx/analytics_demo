import 'package:analytics_demo/ui/aoi_info/apps_of_interest_page.dart';
// import 'package:analytics_demo/ui/bluetooth_info/bluetooth_info_page.dart';
import 'package:analytics_demo/ui/device_info/device_info_page.dart';
import 'package:analytics_demo/ui/home/home_page.dart';
import 'package:analytics_demo/ui/network_info/network_info_page.dart';
import 'package:analytics_demo/ui/poi_info/poi_info_page.dart';
import 'package:analytics_demo/ui/third_party_apps/third_party_apps_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: HomePage.route,
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: DeviceInfoPage.route,
      builder: (BuildContext context, GoRouterState state) {
        return const DeviceInfoPage();
      },
    ),
    GoRoute(
      path: ThirdPartyAppsPage.route,
      builder: (BuildContext context, GoRouterState state) {
        return const ThirdPartyAppsPage();
      },
    ),
    // GoRoute(
    //   path: BluetoothInfoPage.route,
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const BluetoothInfoPage();
    //   },
    // ),
    GoRoute(
      path: PoiInfoPage.route,
      builder: (BuildContext context, GoRouterState state) {
        return const PoiInfoPage();
      },
    ),
    GoRoute(
      path: NetworkInfoPage.route,
      builder: (BuildContext context, GoRouterState state) {
        return const NetworkInfoPage();
      },
    ),
    GoRoute(
      path: AOIInfoPage.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return const AOIInfoPage();
      },
    ),
  ],
);
