import 'dart:io';
import 'package:analytics_demo/domain/models/user_data_info.dart';
import 'package:analytics_demo/domain/services/device_data_service.dart';
import 'package:analytics_demo/providers/device_info_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeviceInfoPage extends StatelessWidget {
  static String route = "/device_info";

  const DeviceInfoPage({super.key});

  void printDeviceDataToConsole() async {
    final userData = UserDataInfo();
    // final DeviceDataService dataService = DeviceDataService(userData: userData);
    final DeviceDataService dataService = DeviceDataService();
    final deviceData = await dataService.getDeviceData();
    debugPrint(deviceData.toString());
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DeviceInfoProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Información del dispositivo"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          printDeviceDataToConsole();
        },
        child: const Icon(Icons.local_printshop_outlined),
      ),
      body: FutureBuilder<BaseDeviceInfo?>(
        future: provider.getDeviceInfo(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("Cargando datos"),
            );
          } else {
            return DeviceInfoView(snapshot.data);
          }
        },
      ),
    );
  }
}

class DeviceInfoView extends StatelessWidget {
  const DeviceInfoView(this.deviceInfo, {super.key});
  final BaseDeviceInfo? deviceInfo;

  @override
  Widget build(BuildContext context) {
    if (deviceInfo == null || !Platform.isAndroid) {
      return const Center(
        child: Text("No se pudo cargar la información del dispositivo"),
      );
    }
    final info = deviceInfo as AndroidDeviceInfo;
    return ListView(
      children: [
        ListTile(
          title: Text(info.device),
          subtitle: const Text("Device"),
        ),
        ListTile(
          title: Text(info.product),
          subtitle: const Text("Product"),
        ),
        ListTile(
          title: Text(info.model),
          subtitle: const Text("Model"),
        ),
        ListTile(
          title: Text(info.id),
          subtitle: const Text("ID"),
        ),
        ListTile(
          title: Text(info.manufacturer),
          subtitle: const Text("Manufacturer"),
        ),
        ListTile(
          title: Text(info.brand),
          subtitle: const Text("Brand"),
        ),
        ListTile(
          title: Text(
              "Code name:${info.version.codename}, Release ${info.version.release}"),
          subtitle: const Text("Version SO"),
        ),
        ListTile(
          title: Text(info.board),
          subtitle: const Text("board"),
        ),
        ListTile(
          title: Text(info.bootloader),
          subtitle: const Text("Booloader"),
        ),
        ListTile(
          title: Text(info.hardware),
          subtitle: const Text("Hardware"),
        ),
        ListTile(
          title: Text(info.host),
          subtitle: const Text("Host"),
        ),
        ListTile(
          title: Text(info.type),
          subtitle: const Text("Type"),
        ),
        ListTile(
          title: Text(info.fingerprint),
          subtitle: const Text("fingerPrint"),
        ),
        ListTile(
          title: Text(info.tags),
          subtitle: const Text("tags"),
        ),
        ListTile(
          title: Text("${info.data}"),
          subtitle: const Text("Raw Data"),
        ),
      ],
    );
  }
}
