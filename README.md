# analytics_demo

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

revisar package_info_plus 5.0.1

para ver si tiene jailbreak o root
https://pub.dev/packages/device_safety_info

para obtener el country code y lenguaje
https://pub.dev/packages/easy_device_info

obtener el IMEI del dispositivo


en android el usageStatsManager obtiene informacion acerca del uso del paquete propio
sirve para saber que tanto usa esa aplicacion propia

https://www.businessofapps.com/marketplace/app-engagement/research/app-user-segmentation/

cuando se obtiene una forma de identificacion precisa de la persona se debe anonimizar la info
ejemplo con el imei del dispositivo se puede identificar al usuario
para usar el imei como ID dentro la base de datos, se debe hashear antes de guardar


modulo de gestion de permisos
cuando ya disponga de permisos habilitar un servicio en segundo plano dento de la app
que cada cirto tiempo este revisando informacion variante como redes wifi ubicacion 
las aplicaciones instaladas o informacion del dispositivo solo cuando se inicie la aplicacion
talves pensar en almacernar eso en una base de datos local para evitar estar tomando esa informacion de forma repetida sin necesidad
