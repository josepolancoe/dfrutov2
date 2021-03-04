import 'dart:convert';
import 'package:dfruto/src/models/producto_model.dart';
import 'package:http/http.dart' as http;

class ProductoProvider {
  // final String _url = 'http://192.168.31.20:3000/productos';
  final String _url = 'https://dfruto-4c8b0.firebaseio.com/productos.json';
  final String _contentType = 'application/json; charset=UTF-8';

  Future<List<Producto>> getProductos() async {
    final resp = await http.get(_url);
    final decodedData = json.decode(resp.body);
    print(decodedData);
    print(decodedData['res']['msj']);
    final data = ProductoList.toJson(decodedData);
    return data.productos;
  }

  Future<List<Producto>> cargarProductos() async {
    final resp = await http.get(_url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<Producto> productos = new List();

    if (decodedData == null) return [];
    decodedData.forEach((id, prod) {
      final prodTemp = Producto.fromJson(prod);
      prodTemp.id = id;

      productos.add(prodTemp);
    });
    return productos;
  }

  Future<List<Producto>> buscarProductos(String query) async {
    // String url ='https://dfruto-4c8b0.firebaseio.com/productos.json?orderBy="nombre"&limitToFirst=9&startAt="${query}"';
    String url ='https://dfruto-4c8b0.firebaseio.com/productos.json?orderBy="nombre"&startAt="${query}"';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    print(decodedData);
    final List<Producto> productos = new List();

    if (decodedData == null) return [];
    decodedData.forEach((id, prod) {
      final prodTemp = Producto.fromJson(prod);
      prodTemp.id = id;

      productos.add(prodTemp);
    });
    return productos;
  }

  Future<bool> crearProducto(Producto producto) async {
    final resp = await http.post(_url,
        headers: <String, String>{'Content-Type': _contentType},
        body: productoToJson(producto));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<bool> editarProducto(Producto producto) async {
    final url = '$_url/update';
    final resp = await http.post(url,
        headers: <String, String>{'Content-Type': _contentType},
        body: productotoJsonWithID(producto));
    final decodeData = json.decode(resp.body);
    print(decodeData);
    print(decodeData['res']['msj']);
    return true;
  }

  Future<int> borrarProducto(String id) async {
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
