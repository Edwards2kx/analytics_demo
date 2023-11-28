import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothInfoProvider with ChangeNotifier {
  FlutterBlue flutterBlue = FlutterBlue.instance;

  Future<List<BluetoothDevice>> getBtDevices() => flutterBlue.connectedDevices;
  // Future<List<BluetoothDevice>> getBtDevices() => flutterBlue.;
}
