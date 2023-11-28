// import 'package:analytics_demo/providers/network_info_provider.dart';
// import 'package:analytics_demo/ui/widgets/loading_data_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'dart:async';

// import 'package:wifi_hunter/wifi_hunter.dart';
// import 'package:wifi_hunter/wifi_hunter_result.dart';

// class NetworkInfoPage extends StatelessWidget {
//   static String route = '/networkInfo';
//   const NetworkInfoPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<NetworkInfoProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Informacion de red'),
//       ),
//       body: Scaffold(
//         body: RefreshIndicator(
//           onRefresh: () async {},
//           child: FutureBuilder<WiFiHunterResult?>(
//             future: provider.getNearbyNetworks(),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) {
//                 return const LoadingDataWidget();
//               }
//               return NearNetworkView(snapshot.data);
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class NearNetworkView extends StatelessWidget {
//   final WiFiHunterResult? wifiResults;
//   // final
//   const NearNetworkView(this.wifiResults, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     if (wifiResults == null) {
//       return const ListTile(
//         title: Text('Sin información de redes wifi'),
//       );
//     } else {
//       return ListView.builder(
//         itemCount: wifiResults?.results.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             leading: Text('${wifiResults?.results[index].level} dbm'),
//             title: Text(wifiResults!.results[index].ssid),
//             subtitle: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text('BSSID : ${wifiResults!.results[index].bssid}'),
//                 Text(
//                     'Capabilities : ${wifiResults!.results[index].capabilities}'),
//                 Text('Frequency : ${wifiResults!.results[index].frequency}'),
//                 Text(
//                     'Channel Width : ${wifiResults!.results[index].channelWidth}'),
//                 Text('Timestamp : ${wifiResults!.results[index].timestamp}')
//               ],
//             ),
//           );
//         },
//       );
//     }
//   }
// }

// // class NetworkInfoPage extends StatefulWidget {
// //   static String route = '/networkInfo';
// //   const NetworkInfoPage({Key? key}) : super(key: key);

// //   @override
// //   State<NetworkInfoPage> createState() => _NetworkInfoPageState();
// // }

// // class _NetworkInfoPageState extends State<NetworkInfoPage> {
// //   WiFiHunterResult wiFiHunterResult = WiFiHunterResult();
// //   Color huntButtonColor = Colors.lightBlue;

// //   Future<void> huntWiFis() async {
// //     setState(() => huntButtonColor = Colors.red);

// //     try {
// //       wiFiHunterResult = (await WiFiHunter.huntWiFiNetworks)!;
// //     } on PlatformException catch (exception) {
// //       print(exception.toString());
// //     }

// //     if (!mounted) return;

// //     setState(() => huntButtonColor = Colors.lightBlue);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('WiFiHunter example app'),
// //       ),
// //       body: SingleChildScrollView(
// //         scrollDirection: Axis.vertical,
// //         physics: const BouncingScrollPhysics(),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           crossAxisAlignment: CrossAxisAlignment.center,
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             Container(
// //               margin: const EdgeInsets.symmetric(vertical: 20.0),
// //               child: ElevatedButton(
// //                   style: ButtonStyle(
// //                       backgroundColor:
// //                           MaterialStateProperty.all<Color>(huntButtonColor)),
// //                   onPressed: () => huntWiFis(),
// //                   child: const Text('Hunt Networks')),
// //             ),
// //             wiFiHunterResult.results.isNotEmpty
// //                 ? Container(
// //                     margin: const EdgeInsets.only(
// //                         bottom: 20.0, left: 30.0, right: 30.0),
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       crossAxisAlignment: CrossAxisAlignment.center,
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: List.generate(
// //                         wiFiHunterResult.results.length,
// //                         (index) => Container(
// //                           margin: const EdgeInsets.symmetric(vertical: 10.0),
// //                           child: ListTile(
// //                             leading: Text(wiFiHunterResult.results[index].level
// //                                     .toString() +
// //                                 ' dbm'),
// //                             title: Text(wiFiHunterResult.results[index].ssid),
// //                             subtitle: Column(
// //                               mainAxisAlignment: MainAxisAlignment.start,
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               mainAxisSize: MainAxisSize.min,
// //                               children: [
// //                                 Text('BSSID : ' +
// //                                     wiFiHunterResult.results[index].bssid),
// //                                 Text('Capabilities : ' +
// //                                     wiFiHunterResult
// //                                         .results[index].capabilities),
// //                                 Text('Frequency : ' +
// //                                     wiFiHunterResult.results[index].frequency
// //                                         .toString()),
// //                                 Text('Channel Width : ' +
// //                                     wiFiHunterResult.results[index].channelWidth
// //                                         .toString()),
// //                                 Text('Timestamp : ' +
// //                                     wiFiHunterResult.results[index].timestamp
// //                                         .toString())
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   )
// //                 : Container()
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
