import 'package:analytics_demo/domain/services/device_data_service.dart';
import 'package:analytics_demo/ui/aoi_info/apps_of_interest_page.dart';
import 'package:analytics_demo/ui/device_info/device_info_page.dart';
import 'package:analytics_demo/ui/network_info/network_info_page.dart';
import 'package:analytics_demo/ui/poi_info/poi_info_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import '../third_party_apps/third_party_apps_page.dart';

class HomePage extends StatelessWidget {
  static String route = "/";
  const HomePage({super.key});

  // void saveJsonToFile(String? jsonData) {
  //   if (jsonData == null) return;
  //   String filePath = 'assets/json_output.json';
  //   // final jsonString = jsonEncode(jsonData);
  //   File file = File(filePath);
  //   file.writeAsStringSync(jsonData);
  //   debugPrint('JSON guardado en: $filePath');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Opciones de Analítica"),
      ),
      body: const HomePageView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //  final dataService =  DeviceDataService();
          //  final userDataInfo = await dataService.getUserDataInfo();
          //  debugPrint(userDataInfo?.toJson());
          final getUserInfoAnalytics =
              await DeviceDataService().getUserInfoAnalytics();

          // debugPrint(getUserInfoAnalytics?.toJson());
          // saveJsonToFile(getUserInfoAnalytics?.toJson());
          final response = getUserInfoAnalytics?.toJson();
          debugPrint(response);

        },
        child: const Icon(Icons.search_outlined),
      ),
    );
  }
}

class HomePageView extends StatelessWidget {
  void _showSnackBar(BuildContext context, String permission) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text("No has habilitado el permiso de: $permission"),
      action: SnackBarAction(
          label: 'Configurar',
          onPressed: () {
            openAppSettings();
          }),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  const HomePageView({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // ListTile(
        //   title: const Text("Obtener IMEIs del dispositivo"),
        //   subtitle: const Text("Identificador único"),
        //   trailing: const Icon(Icons.arrow_forward_ios_outlined),
        //   onTap: () => showDialog<String>(
        //     context: context,
        //     builder: (BuildContext context) => AlertDialog(
        //       title: const Text('Información de IMEI'),
        //       content: FutureBuilder<String?>(
        //           future: DeviceImei().getDeviceImei(),
        //           builder: (context, snapshot) {
        //             if (!snapshot.hasData) {
        //               return const Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 mainAxisSize: MainAxisSize.min,
        //                 children: [
        //                   CircularProgressIndicator(),
        //                   SizedBox(height: 32),
        //                   Text('Cargando información...')
        //                 ],
        //               );
        //             } else {
        //               return Text('IMEI ${snapshot.data ?? "no disponible"}');
        //             }
        //           }),
        //       actions: [
        //         TextButton(
        //           onPressed: () => Navigator.pop(context),
        //           child: const Text('Cerrar'),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        ListTile(
          title: const Text("Información del dispositivo"),
          subtitle:
              const Text("Sistema operatativo, modelo, procesador, etc..."),
          onTap: () => context.push(DeviceInfoPage.route),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
        ),
        ListTile(
          title: const Text("Información de aplicaciones instaladas"),
          subtitle: const Text("Nombre de paquete y categoria (Android)"),
          onTap: () => context.push(ThirdPartyAppsPage.route),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
        ),
        ListTile(
          title: const Text("Información de BT"),
          subtitle: const Text(
              "Listado de dispositivos emparejados\nRequiere permiso de BT"),
          onTap: () async {
            // if(await FlutterBluePlus.

            if (await FlutterBluePlus.isSupported == false) {
              // debugPrint("Bluetooth not supported by this device");
              return;
            }
            if (await FlutterBluePlus.isSupported) {
              // final btResults = FlutterBluePlus.lastScanResults;
              try {
                await FlutterBluePlus.startScan();
                debugPrint((await FlutterBluePlus.adapterName));
                final adapterState = FlutterBluePlus.adapterState;
                final first = await adapterState.first;
                debugPrint('estado first : ${first.toString()}');
                final systemDevices = await FlutterBluePlus.systemDevices;
                final btResults = FlutterBluePlus.lastScanResults;
                final btResults2 =
                    await FlutterBluePlus.bondedDevices; //este es el bueno
                debugPrint('results $btResults');
                debugPrint('results2 $btResults2');
                debugPrint('systemDevices $systemDevices');
                // FlutterBluePlus.
              } catch (e) {
                debugPrint('error $e');
              }
            }

            // final btPermisionStatus = await Permission.bluetooth.serviceStatus;
            // if (btPermisionStatus != ServiceStatus.enabled) {
            //   final response = await Permission.bluetooth.request();
            //   debugPrint('response $response');
            // }
            // debugPrint('bt permision status $btPermisionStatus');
          },
          // onTap: () => {},
          // Permission.bluetooth.request().isGranted.then((value) => {
          //       if (value)
          //         context.push(BluetoothInfoPage.route)
          //       else
          //         _showSnackBar(context, 'Bluetooth'),
          //     }),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
        ),
        ListTile(
          title: const Text("Información de lugares cercanos"),
          subtitle: const Text("Negocios cerca de la ubicación actual"),
          onTap: () async {
            // Geolocator.checkPermission().then((permision) => if(permission == LocationPermission.denied ) { })
            final permision = await geo.Geolocator.checkPermission();
            if (permision == geo.LocationPermission.whileInUse ||
                permision == geo.LocationPermission.always) {
              // ignore: use_build_context_synchronously
              context.push(PoiInfoPage.route);
            } else if (permision == geo.LocationPermission.deniedForever) {
              // ignore: use_build_context_synchronously
              _showSnackBar(context, 'Ubicación');
            } else if (permision == geo.LocationPermission.denied) {
              final requestResponse = await geo.Geolocator.requestPermission();
              if (requestResponse == geo.LocationPermission.denied ||
                  requestResponse == geo.LocationPermission.deniedForever) {
                // ignore: use_build_context_synchronously
                _showSnackBar(context, 'Ubicación');
              } else {
                // ignore: use_build_context_synchronously
                context.push(PoiInfoPage.route);
              }
            }
          },
          // onTap: () => Permission.location.request().isGranted.then(
          //       (response) => {
          // if (response)
          //   context.push(PoiInfoPage.route)
          // else
          //   _showSnackBar(context, 'Ubicación'),
          //     context.push(PoiInfoPage.route)
          //   },
          // ),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
        ),
        ListTile(
          title: const Text("Información de conectividad"),
          subtitle: const Text("Redes wifi cercas"),
          onTap: () => Permission.location.request().isGranted.then(
                (response) => {
                  if (response)
                    context.push(NetworkInfoPage.route)
                  else
                    _showSnackBar(context, 'Ubicación'),
                },
              ),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
        ),
        ListTile(
            title: const Text("Verificar aplicaciones instaladas"),
            subtitle: const Text("Confirma si existe apps de interés o no"),
            onTap: () => context.push(AOIInfoPage.routeName),
            trailing: const Icon(Icons.arrow_forward_ios_outlined)),
        const NetworkStatusWidget(),
      ],
    );
  }
}

class NetworkStatusWidget extends StatefulWidget {
  const NetworkStatusWidget({
    super.key,
  });

  @override
  State<NetworkStatusWidget> createState() => _NetworkStatusWidgetState();
}

class _NetworkStatusWidgetState extends State<NetworkStatusWidget> {
  ConnectivityResult networkResultState =
      ConnectivityResult.none; //valor inicial
  @override
  void initState() {
    final connectivity = Connectivity();
    connectivity
        .checkConnectivity()
        .then((result) => networkResultState = result);
    connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      networkResultState = result;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Conexion actual: ${networkResultState.name}"),
      subtitle: const Text("conectado a Wifi o red movíl"),
    );
  }
}
