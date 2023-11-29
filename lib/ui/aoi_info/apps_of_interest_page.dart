import 'package:analytics_demo/providers/aoi_info_provider.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AOIInfoPage extends StatelessWidget {
  static String routeName = '/aoiInfoPage';
  const AOIInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AOIInfoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aplicaciones de interés"),
      ),
      body: AppsOfInteresInfoView(provider: provider),
    );
  }
}

class AppsOfInteresInfoView extends StatelessWidget {
  const AppsOfInteresInfoView({
    super.key,
    required this.provider,
  });

  final AOIInfoProvider provider;

  @override
  Widget build(BuildContext context) {
    final apps = provider.appList;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: apps.length,
            itemBuilder: (context, index) {
              final app = apps[index];
              final appName = app.keys.first;
              final appPackage = app[appName] ?? '';
              return ListTile(
                title: Text(appName),
                subtitle: Text(appPackage),
                trailing: FutureBuilder<dynamic>(
                  future: LaunchApp.isAppInstalled(
                      androidPackageName: appPackage,
                      iosUrlScheme: '$appPackage://'),
                  builder: (context, snapshot) {
                    debugPrint('data ${snapshot.data}');
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    } else {
                      if (snapshot.data == true) {
                        return const Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
                        );
                      } else {
                        return const Icon(
                          Icons.close_rounded,
                          color: Colors.red,
                        );
                      }
                    }
                  },
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
