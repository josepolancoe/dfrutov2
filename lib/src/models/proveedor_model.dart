import 'dart:convert';

Proveedor proveedorFromJson(String str) => Proveedor.fromJson(json.decode(str));

String proveedorToJson(Proveedor data) => json.encode(data.toJson());

String proveedorToJsonWithID(Proveedor data) => json.encode(data.toJsonWithID());

class ProveedorList {
  List<Proveedor> proveedores = new List();

  ProveedorList.toJson(List<dynamic> list) {
    for (var item in list) {
      final proveedor = new Proveedor.fromJson(item);
      proveedores.add(proveedor);
    }
  }
}

class Proveedor {
  int idProveedor;
  String nombres;
  String apellidos;
  String direccion;
  String correo;
  String telefono;

  Proveedor({
    this.idProveedor,
    this.nombres,
    this.apellidos,
    this.direccion,
    this.correo,
    this.telefono,
  });

  factory Proveedor.fromJson(Map<String, dynamic> json) => Proveedor(
        idProveedor: json["id_proveedor"],
        nombres: json["nom_cliente"],
        apellidos: json["ape_cliente"],
        direccion: json["direc_cliente"],
        correo: json["correo_cliente"],
        telefono: json["tel_cliente"],
      );

  Map<String, dynamic> toJson() => {
        // "idProveedor": idProveedor,
        "nombres": nombres,
        "apellidos": apellidos,
        "direccion": direccion,
        "correo": correo,
        "telefono": telefono,
      };

  Map<String, dynamic> toJsonWithID() => {
        "id": idProveedor,
        "nombres": nombres,
        "apellidos": apellidos,
        "direccion": direccion,
        "correo": correo,
        "telefono": telefono,
      };
}
