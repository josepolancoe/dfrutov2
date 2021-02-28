import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:dfruto/src/models/proveedor_model.dart';

class ProveedorProvider {
  final String _url = 'http://192.168.31.20:3000/proveedores';
  final String _contentType = 'application/json; charset=UTF-8';

  Future<List<Proveedor>> getProveedores() async {
    final resp = await http.get(_url);
    final decodedData = json.decode(resp.body);
    final data = ProveedorList.toJson(decodedData);
    return data.proveedores;
  }

  Future<bool> crearProovedor(Proveedor proveedor) async {
    final resp = await http.post(_url,
        headers: <String, String>{'Content-Type': _contentType},
        body: proveedorToJson(proveedor));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<bool> editarProveedor(Proveedor proveedor) async {
    final url = '$_url/update';
    final resp = await http.post(url,
        headers: <String, String>{'Content-Type': _contentType},
        body: proveedorToJsonWithID(proveedor));
    final decodeData = json.decode(resp.body);
    print(decodeData);
    print(decodeData['res']['msj']);
    return true;
  }

  Future<int> borrarProveedor(String id) async {
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
