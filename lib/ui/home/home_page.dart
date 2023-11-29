import 'package:analytics_demo/ui/aoi_info/apps_of_interest_page.dart';
import 'package:analytics_demo/ui/bluetooth_info/bluetooth_info_page.dart';
import 'package:analytics_demo/ui/device_info/device_info_page.dart';
import 'package:analytics_demo/ui/network_info/network_info_page.dart';
import 'package:analytics_demo/ui/poi_info/poi_info_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import '../third_party_apps/third_party_apps_page.dart';

class HomePage extends StatelessWidget {
  static String route = "/";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Opciones de Analítica"),
      ),
      body: const HomePageView(),
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
          onTap: () =>
              Permission.bluetooth.request().isGranted.then((value) => {
                    if (value)
                      context.push(BluetoothInfoPage.route)
                    else
                      _showSnackBar(context, 'Bluetooth'),
                  }),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
        ),
        ListTile(
          title: const Text("Información de lugares cercanos"),
          subtitle: const Text("Negocios cerca de la ubicación actual"),
          onTap: () => Permission.location.request().isGranted.then(
                (response) => {
                  if (response)
                    context.push(PoiInfoPage.route)
                  else
                    _showSnackBar(context, 'Ubicación'),
                },
              ),
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
