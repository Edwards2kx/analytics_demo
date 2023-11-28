import 'package:analytics_demo/providers/third_party_apps_provider.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThirdPartyAppsPage extends StatelessWidget {
  static String route = "/thirdPartyApps";
  const ThirdPartyAppsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<ThirdPartyAppsInfoProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Información de aplicaciones"),
        // actions: [Switch(value: showSystemApps, onChanged: onChanged)],
      ),
      body: FutureBuilder<List<Application>>(
        future: provider.getAppsInstalled(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("Cargando datos"),
            );
          } else {
            return AppsInfoView(snapshot.data);
          }
        },
      ),
    );
  }
}

class AppsInfoView extends StatelessWidget {
  final List<Application>? apps;
  const AppsInfoView(this.apps, {super.key});

  @override
  Widget build(BuildContext context) {
    if (apps == null) {
      return const Center(
        child: Text("No se pudo cargar la información de las aplicaciones"),
      );
    } else {
      return ListView.builder(
        itemCount: apps?.length,
        itemBuilder: (context, index) {
          final appWithIcon = apps![index] as ApplicationWithIcon;
          return ListTile(
            isThreeLine: true,
            title: Text(apps![index].appName),
            subtitle: Text(apps![index].packageName),
            leading: Image.memory(
              appWithIcon.icon,
              // height: 40.0,
              // fit: BoxFit.fitHeight,
            ),
            trailing: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => AppDetailView(apps![index])));
              },
              icon: const Icon(Icons.arrow_forward_ios_outlined),
            ),
          );
        },
      );
    }
  }
}

class AppDetailView extends StatelessWidget {
  const AppDetailView(this.app, {super.key});
  final Application app;

  @override
  Widget build(BuildContext context) {
    final appWithIcon = app as ApplicationWithIcon;
    return Scaffold(
      appBar: AppBar(title: Text(app.appName)),
      body: ListView(
        children: [
          Image.memory(
            appWithIcon.icon,
            height: 180.0,
            fit: BoxFit.fitHeight,
          ),
          ListTile(
            title: Text(app.packageName),
            subtitle: const Text("Package"),
          ),
          ListTile(
            title: Text(app.category.toString()),
            subtitle: const Text("category"),
          ),
          ListTile(
            title: Text(app.versionName.toString()),
            subtitle: const Text("version name"),
          ),
          ListTile(
            title: Text(app.versionCode.toString()),
            subtitle: const Text("version code"),
          ),
        ],
      ),
    );
  }
}
