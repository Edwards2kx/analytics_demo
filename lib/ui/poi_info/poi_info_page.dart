import 'package:analytics_demo/providers/poi_info_provider.dart';
import 'package:analytics_demo/ui/widgets/loading_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class PoiInfoPage extends StatelessWidget {
  static String route = '/poiInfo';
  const PoiInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PoiInfoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('POI cercanos'),
      ),
      body: FutureBuilder<Position?>(
        future: provider.getLocation(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LoadingDataWidget();
            // return const Center(
            //   child: Text("Cargando datos"),
            // );
          } else {
            return PoiInfoView(snapshot.data);
          }
        },
      ),
    );
  }
}

class PoiInfoView extends StatelessWidget {
  final Position? position;
  const PoiInfoView(this.position, {super.key});

  @override
  Widget build(BuildContext context) {
    if (position == null) {
      return const Center(
        child: Text("No se pudo cargar la información"),
      );
    } else {
      return ListView(
        children: [
          ListTile(title: Text('Latitud actual: ${position?.latitude}')),
          ListTile(title: Text('Longitud actual: ${position?.longitude}')),
          ListTile(title: Text('Altitud actual: ${position?.altitude}')),
          ListTile(title: Text('Precisión actual: ${position?.accuracy}'))
        ],
      );
    }
  }
}
