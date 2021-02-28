import 'package:dfruto/src/providers/carrito_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PedidoPage extends StatelessWidget {
  // final _productoList = new ProductoList();
  @override
  Widget build(BuildContext context) {
    final carrito = Provider.of<CarritoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Valor del carrito: S/. ${carrito.precioTotal.toStringAsFixed(2)} '),
      ),
      body: carrito.productosDelCarrito.length == 0
          ? Center(child: Text('No tiene productos en su carrito.'))
          : ListView.builder(
              itemCount: carrito.cantidadProductos,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    leading: Image.network(
                        carrito.productosDelCarrito[index].fotoUrl),
                    title: Text(carrito.productosDelCarrito[index].nombre),
                    subtitle: Text('S/. '+carrito.productosDelCarrito[index].precio
                        .toStringAsFixed(2)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        carrito.remove(carrito.productosDelCarrito[index]);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
