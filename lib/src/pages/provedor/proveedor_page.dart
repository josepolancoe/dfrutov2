import 'package:flutter/material.dart';

import 'package:dfruto/src/models/proveedor_model.dart';
import 'package:dfruto/src/providers/proveedor_provider.dart';

class ProveedorPage extends StatefulWidget {
  @override
  _ProveedorPageState createState() => _ProveedorPageState();
}

class _ProveedorPageState extends State<ProveedorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Proveedores'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: _myFuture(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/proveedor_form')
            .then((value) => setState(() {})),
        child: Icon(Icons.add),
      ),
    );
  }
}

Widget _myFuture() {
  final proveedorProvider = new ProveedorProvider();
  return FutureBuilder(
      future: proveedorProvider.getProveedores(),
      builder: (BuildContext context, AsyncSnapshot<List<Proveedor>> snapshot) {
        if (snapshot.hasData) {
          final proveedores = snapshot.data;
          return Container(
            child: ListView.builder(
              itemCount: proveedores.length,
              itemBuilder: (context, i) => _listaProveedores(context, proveedores[i]),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      });
}

Widget _listaProveedores(BuildContext context, Proveedor proveedor) {
  return Column(
    children: [
      Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          final proveedorProvider = new ProveedorProvider();
          proveedorProvider.borrarProveedor(proveedor.idProveedor.toString());
        },
        background: Container(
          color: Colors.red,
        ),
        child: ListTile(
          // leading: Icon(Icons.person),
          leading: Text('${proveedor.idProveedor}'),
          title: Text(
            "${proveedor.nombres} ${proveedor.apellidos}",
          ),
          subtitle: Text('${proveedor.telefono} - ${proveedor.correo}'),
          trailing: Icon(Icons.edit),
          onTap: () {
            Navigator.pushNamed(context, '/proveedor_form', arguments: proveedor);
          },
        ),
      ),
      Divider()
    ],
  );
}
