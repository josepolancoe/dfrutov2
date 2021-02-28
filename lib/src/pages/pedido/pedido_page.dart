import 'package:flutter/material.dart';

class PedidoPage extends StatelessWidget {
  // final _productoList = new ProductoList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CARRITO'),
      ),
       body: Container(child: Center(child: Text('PRODUCTOS DEL CARRITO'))),
    );
  }
}
