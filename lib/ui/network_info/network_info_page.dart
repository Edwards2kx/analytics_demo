import 'package:analytics_demo/providers/network_info_provider.dart';
import 'package:analytics_demo/ui/widgets/loading_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wifi_hunter/wifi_hunter_result.dart';

class NetworkInfoPage extends StatelessWidget {
  static String route = '/networkInfo';
  const NetworkInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NetworkInfoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información de redes cercanas'),
      ),
      body: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {},
          child: FutureBuilder<WiFiHunterResult?>(
            future: provider.getNearbyNetworks(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const LoadingDataWidget();
              }
              return NearNetworkView(snapshot.data);
            },
          ),
        ),
      ),
    );
  }
}

class NearNetworkView extends StatelessWidget {
  final WiFiHunterResult? wifiResults;
  // final
  const NearNetworkView(this.wifiResults, {super.key});

  @override
  Widget build(BuildContext context) {
    if (wifiResults == null) {
      return const ListTile(
        title: Text('Sin información de redes wifi'),
      );
    } else {
      return ListView.builder(
        itemCount: wifiResults?.results.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text('${wifiResults?.results[index].level} dbm'),
            title: Text(wifiResults!.results[index].ssid),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('BSSID : ${wifiResults!.results[index].bssid}'),
                Text(
                    'Capabilities : ${wifiResults!.results[index].capabilities}'),
                Text('Frequency : ${wifiResults!.results[index].frequency}'),
                Text(
                    'Channel Width : ${wifiResults!.results[index].channelWidth}'),
                Text('Timestamp : ${wifiResults!.results[index].timestamp}')
              ],
            ),
          );
        },
      );
    }
  }
}
