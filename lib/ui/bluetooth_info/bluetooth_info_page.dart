// import 'package:analytics_demo/providers/bluetooth_info_provider.dart';
// import 'package:analytics_demo/ui/widgets/loading_data_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_blue/flutter_blue.dart';
// import 'package:provider/provider.dart';

// class BluetoothInfoPage extends StatelessWidget {
//   static String route = '/bluetoothDevices';

//   const BluetoothInfoPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<BluetoothInfoProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Info. Dispositivos BT"),
//       ),
//       body: FutureBuilder<List<BluetoothDevice>>(
//         future: provider.getBtDevices(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const LoadingDataWidget();
//           } else if (snapshot.hasError) {
//             return const Center(
//               child: Text('Se presento un error'),
//             );
//           } else {
//             return BluetoothInfoView(snapshot.data);
//           }
//         },
//       ),
//     );
//   }
// }

// class BluetoothInfoView extends StatelessWidget {
//   final List<BluetoothDevice>? devices;
//   const BluetoothInfoView(this.devices, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     if (devices == null) {
//       return const Center(
//         child: Text(
//           "No se pudo cargar la información del dispositivo",
//         ),
//       );
//     } else if (devices!.isEmpty) {
//       return const Center(
//         child: Text(
//           "No se pudo cargar la información del dispositivo",
//         ),
//       );
//     }
//     return ListView.builder(
//       itemCount: devices!.length,
//       itemBuilder: (BuildContext context, int index) {
//         return ListTile(
//           title: Text('${devices![index].name} | id:${devices![index].id}'),
//           subtitle: Text('${devices![index].type}'),
//         );
//       },
//     );
//   }
// }
