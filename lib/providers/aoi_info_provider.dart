import 'package:flutter/material.dart';

const Map<String, String> financeApps = {
  'Nequi': 'com.nequi.MobileApp',
  'Daviplata': 'com.daviplata',
  'Paypal': 'com.paypal.android.p2pmobile',
  'Bancolombia': 'com.todo1.mobile',
  'Banco de occidente': 'com.grupoavaloc1.bancamovil'
};

//estudios
const Map<String, String> educationalApps = {
  'Coursera': 'org.coursera.android',
};

//online shopper
const Map<String, String> shoppingApps = {
  'Amazon': 'com.amazon.mShop.android.shopping',
  'Mercado libre': 'com.mercadolibre',
  'Ebay': 'com.ebay.mobile'
};

class AOIInfoProvider with ChangeNotifier {
  final Map<String, Map<String, String>> apps = {
    'Aplicaciones Financieras': financeApps,
    'Aplicaciones de compras': shoppingApps,
    'Aplicaciones educacionales': educationalApps
  };

  final List<Map<String, String>> appList = [
    {'Nequi': 'com.nequi.MobileApp'},
    {'Daviplata': 'com.daviplata'},
    {'Paypal': 'com.paypal.android.p2pmobile'},
    {'Bancolombia': 'com.todo1.mobile'},
    {'Banco de occidente': 'com.grupoavaloc1.bancamovil'},
    {'Coursera': 'com.coursera.android'},
    {'Amazon': 'com.amazon.mShop.android.shopping'},
    {'Mercado libre': 'com.mercadolibre'},
    {'Ebay': 'com.ebay.mobile'}
  ];

  // Future<

  int get aoiLength =>
      financeApps.length + shoppingApps.length + educationalApps.length;
}
