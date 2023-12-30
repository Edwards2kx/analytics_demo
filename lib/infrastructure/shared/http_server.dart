import 'dart:convert';

import 'package:http/http.dart';

class CustomHttpServer {
  final _clienteHttp = Client();
  // final _authority = '6e58-186-169-64-22.ngrok-free.app';
  final _authority = 'jsonplaceholder.typicode.com';
//en los query Params enviar alguna key necesaria para evitar el spam
  Future<String?> getRequest(String path,
      [Map<String, dynamic>? queryParams]) async {
    final Uri uri = Uri.https(_authority, path, queryParams);
    final response = await _clienteHttp.get(uri);
    if (response.statusCode != 200) return null;
    return response.body;
  }

  Future<bool> postRequest(String path, [dynamic body]) async {
    final Uri uri = Uri.https(_authority, path);
    // final response = await _clienteHttp.post(uri, body: body);

    final response = await _clienteHttp.post(uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
            {"unique_id": "013e69c7c47efa6527bf8132b6146d85b1d7a3d5"}));
    print('uri: $uri \nbody: $body');
    print('respuesta body ${response.body}');
    if (response.statusCode != 200 && response.statusCode != 201) return false;
    print(response.body);
    return true;
  }
}
