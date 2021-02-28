import 'dart:convert';

Cliente clienteFromJson(String str) => Cliente.fromJson(json.decode(str));

String clienteToJson(Cliente data) => json.encode(data.toJson());

String clienteToJsonWithID(Cliente data) => json.encode(data.toJsonWithID());

class ClienteList {
  List<Cliente> clientes = new List();

  ClienteList.toJson(List<dynamic> list) {
    for (var item in list) {
      final cliente = new Cliente.fromJson(item);
      clientes.add(cliente);
    }
  }
}

class Cliente {
  int idCliente;
  String nombres;
  String apellidos;
  String direccion;
  String correo;
  String telefono;

  Cliente({
    this.idCliente,
    this.nombres,
    this.apellidos,
    this.direccion,
    this.correo,
    this.telefono,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        idCliente: json["id_cliente"],
        nombres: json["nom_cliente"],
        apellidos: json["ape_cliente"],
        direccion: json["direc_cliente"],
        correo: json["correo_cliente"],
        telefono: json["tel_cliente"],
      );

  Map<String, dynamic> toJson() => {
        // "idCliente": idCliente,
        "nombres": nombres,
        "apellidos": apellidos,
        "direccion": direccion,
        "correo": correo,
        "telefono": telefono,
      };

  Map<String, dynamic> toJsonWithID() => {
        "id": idCliente,
        "nombres": nombres,
        "apellidos": apellidos,
        "direccion": direccion,
        "correo": correo,
        "telefono": telefono,
      };
}
