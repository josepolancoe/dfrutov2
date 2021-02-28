import 'package:dfruto/src/models/cliente_model.dart';
import 'package:dfruto/src/providers/cliente_provider.dart';
import 'package:flutter/material.dart';

class ClientePage extends StatefulWidget {
  @override
  _ClientePageState createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {
  final clienteProvider = new ClienteProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Clientes'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: _myFuture(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/cliente_form')
            .then((value) => setState(() {})),
        child: Icon(Icons.add),
      ),
    );
  }
  
}


Widget _myFuture() {
  final clienteProvider = new ClienteProvider();
  return FutureBuilder(
      future: clienteProvider.getClientes(),
      builder: (BuildContext context, AsyncSnapshot<List<Cliente>> snapshot) {
        if (snapshot.hasData) {
          final clientes = snapshot.data;
          return Container(
            child: ListView.builder(
              itemCount: clientes.length,
              itemBuilder: (context, i) =>
                  _listaClientes(context, clientes[i]),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      });
}


Widget _listaClientes(BuildContext context, Cliente cliente) {
  return Column(
    children: [
      Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          final clinteProvider = new ClienteProvider();
          clinteProvider.borrarCliente(cliente.idCliente.toString());
        },
        background: Container(
          color: Colors.red,
        ),
        child: ListTile(
          // leading: Icon(Icons.person),
          leading: Text('${cliente.idCliente}'),
          title: Text(
            "${cliente.nombres} ${cliente.apellidos}",
          ),
          subtitle: Text('${cliente.telefono} - ${cliente.correo}'),
          trailing: Icon(Icons.edit),
          onTap: () {
            Navigator.pushNamed(context, '/cliente_form', arguments: cliente);
          },
        ),
      ),
      Divider()
    ],
  );
}
