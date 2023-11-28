import 'package:analytics_demo/ui/bluetooth_info/bluetooth_info_page.dart';
import 'package:analytics_demo/ui/device_info/device_info_page.dart';
import 'package:analytics_demo/ui/network_info/network_info_page.dart';
import 'package:analytics_demo/ui/poi_info/poi_info_page.dart';
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
        ListTile(
          title: const Text("Información del dispositivo"),
          subtitle:
              const Text("Sistema operatativo, modelo, procesador, etc..."),
          trailing: IconButton(
            icon: const Icon(Icons.arrow_forward_ios_outlined),
            onPressed: () {
              context.push(DeviceInfoPage.route);
            },
          ),
        ),
        ListTile(
          title: const Text("Información de aplicaciones instaladas"),
          subtitle: const Text("Nombre de paquete y categoria"),
          trailing: IconButton(
            icon: const Icon(Icons.arrow_forward_ios_outlined),
            onPressed: () {
              context.push(ThirdPartyAppsPage.route);
            },
          ),
        ),
        ListTile(
          title: const Text("Información de BT"),
          subtitle: const Text(
              "Listado de dispositivos emparejados\nRequiere permiso de BT"),
          trailing: IconButton(
            icon: const Icon(Icons.arrow_forward_ios_outlined),
            onPressed: () async {
              Permission.bluetooth.request().isGranted.then((value) => {
                    if (value)
                      {context.push(BluetoothInfoPage.route)}
                    else
                      {
                        _showSnackBar(context, 'Bluetooth'),
                        debugPrint("sin permiso para bluetooth")
                      }
                  });
            },
          ),
        ),
        ListTile(
          title: const Text("Información de lugares cercanos"),
          subtitle: const Text("Negocios cerca de la ubicación actual"),
          trailing: IconButton(
            icon: const Icon(Icons.arrow_forward_ios_outlined),
            onPressed: () {
              Permission.location.request().isGranted.then(
                    (response) => {
                      if (response)
                        {context.push(PoiInfoPage.route)}
                      else
                        {
                          _showSnackBar(context, 'Ubicación'),
                          debugPrint("sin permiso para ubicación")
                        }
                    },
                  );
            },
          ),
        ),
        ListTile(
          title: const Text("Información de conectividad"),
          subtitle: const Text("Redes wifi cercas"),
          trailing: IconButton(
            icon: const Icon(Icons.arrow_forward_ios_outlined),
            onPressed: () {
              Permission.location.request().isGranted.then(
                    (response) => {
                      if (response)
                        {context.push(NetworkInfoPage.route)}
                      else
                        {
                          _showSnackBar(context, 'Ubicación'),
                          debugPrint("sin permiso para ubicación")
                        }
                    },
                  );
            },
          ),
        ),
      ],
    );
  }
}
