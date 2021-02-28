// To parse this JSON data, do
//
//     final Producto = productoModelFromJson(jsonString);

import 'dart:convert';

Producto productoFromJson(String str) =>
    Producto.fromJson(json.decode(str));

String productoToJson(Producto data) => json.encode(data.toJson());

String productotoJsonWithID(Producto data) => json.encode(data.toJsonWithID());

class ProductoList {
  List<Producto> productos = new List();

  ProductoList.toJson(List<dynamic> list) {
    for (var item in list) {
      final producto = new Producto.fromJson(item);
      productos.add(producto);
    }
  }
}

class Producto {
  String id;
  String nombre;
  String descripcion;
  double precio;
  bool disponible;
  String fotoUrl;
  String unidadDeMedida;
  String clasificacion;
  double stock;

  Producto({
    this.id,
    this.nombre = '',
    this.descripcion ='',
    this.precio = 0.0,
    this.disponible = true,
    this.fotoUrl,
    this.unidadDeMedida='kilos',
    this.clasificacion='premium',
    this.stock=0.0,
  });

  factory Producto.fromJson(Map<String, dynamic> json) =>
      new Producto(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        precio: json["precio"].toDouble(),
        disponible: json["disponible"],
        fotoUrl: json["fotoUrl"],
        unidadDeMedida: json["unidadDeMedida"],
        clasificacion: json["clasificacion"],
        stock: json["stock"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "nombre": nombre,
        "descripcion":descripcion,
        "precio": precio,
        "disponible": disponible,
        "fotoUrl": fotoUrl,
        "unidadDeMedida": unidadDeMedida,
        "clasificacion": clasificacion,
        "stock": stock,
      };

  Map<String, dynamic> toJsonWithID() => {
        "id": id,
        "nombre": nombre,
        "descripcion":descripcion,
        "precio": precio,
        "disponible": disponible,
        "fotoUrl": fotoUrl,
        "unidadDeMedida": unidadDeMedida,
        "clasificacion": clasificacion,
        "stock": stock,
      };
}