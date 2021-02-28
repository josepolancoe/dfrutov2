import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:dfruto/src/models/cliente_model.dart';

class ClienteProvider {
  final String _url = 'http://192.168.31.20:3000/clientes';
  final String _contentType = 'application/json; charset=UTF-8';

  Future<List<Cliente>> getClientes() async {
    final resp = await http.get(_url);
    final decodedData = json.decode(resp.body);
    print(decodedData);
    final data = ClienteList.toJson(decodedData);
    return data.clientes;
  }

  Future<bool> crearCliente(Cliente cliente) async {
    final resp = await http.post(_url,
        headers: <String, String>{'Content-Type': _contentType},
        body: clienteToJson(cliente));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<bool> editarCliente(Cliente cliente) async {
    final url = '$_url/update';
    final resp = await http.post(url,
        headers: <String, String>{'Content-Type': _contentType},
        body: clienteToJsonWithID(cliente));
    final decodeData = json.decode(resp.body);
    print(decodeData);
    print(decodeData['res']['msj']);
    return true;
  }

  Future<int> borrarCliente(String id) async {
    final url = '$_url/delete';
    final msg = jsonEncode({"id": id});
    final resp = await http.post(url,
        headers: <String, String>{'Content-Type': _contentType}, body: msg);
    final decodeData = json.decode(resp.body);
    print(decodeData);
    print(decodeData['res']['msj']);
    return 1;
  }
}
