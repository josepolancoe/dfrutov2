import 'package:dfruto/src/models/producto_model.dart';
import 'package:dfruto/src/providers/producto_provider.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  final productoProvider = new ProductoProvider();
  String seleccion = '';
  
  final frutas = [
    'mango',
    'mandarina',
    'platano',
    'naranja',
    'pera',
    'maracuya'
  ];

  @override
  String get searchFieldLabel => 'Buscar fruta';

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro appbar, como "X" para limpiar la caja de busqueda
    // throw UnimplementedError();
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
            print("click en buildAction");
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del appbar, del buscador
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
          print("click en builLeading");
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // crea los resultados que vamos a mostrar
    // return Container(child:Text("BUILD RESULTS"));
    return Container(child:Text(seleccion));
    // return Center(
    //   child: Container(
    //     height: 100,
    //     width: 100,
    //     color: kUltimateColorDfruto,
    //     child: Text(seleccion),
    //   ),
    // );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(child: Text('🍉🍊 Sin Existencias 🍌🍎'),);
    }

    return FutureBuilder(
      future: productoProvider.buscarProductos(query),
      builder: (BuildContext context, AsyncSnapshot<List<Producto>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;
          return ListView(
            children: productos.map((producto) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(producto.fotoUrl),
                  placeholder: AssetImage('assets/images/no-image.jpg'),
                  width: 50,
                  fit: BoxFit.contain,
                ),
                title: Text(producto.nombre),
                subtitle: Text(producto.precio.toStringAsFixed(2)),
                onTap: () {
                  close(context, null);
                  // seleccion = producto.nombre;
                  // showResults(context);
                  // producto.id = '';
                  Navigator.pushNamed(context, '/producto_detail_page', arguments: producto);
                },
              );
            }).toList(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
    // final listaSugerida = (query.isEmpty)
    //     ? frutas
    //     : frutas
    //         .where(
    //             (value) => value.toLowerCase().startsWith(query.toLowerCase()))
    //         .toList();
    // // son sugerencias que aparece cuando la persona escribe
    // return ListView.builder(
    //   itemCount: listaSugerida.length,
    //   itemBuilder: (BuildContext context, int i) {
    //     return ListTile(
    //       leading: Icon(Icons.fastfood),
    //       title: Text(listaSugerida[i]),
    //       onTap: () {
    //         seleccion = listaSugerida[i];
    //         showResults(context);
    //       },
    //     );
    //   },
    // );
  }
}
