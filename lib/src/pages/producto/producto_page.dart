import 'package:dfruto/src/models/producto_model.dart';
import 'package:dfruto/src/providers/producto_provider.dart';
import 'package:dfruto/src/widgets/producto_card_widget.dart';
import 'package:flutter/material.dart';

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final productoProvider = new ProductoProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/pedido_page');
                },
                child: Icon(Icons.shopping_basket)),
          )
        ],
      ),
      body: FutureBuilder(
        future: productoProvider.cargarProductos(),
        builder: (BuildContext context, AsyncSnapshot<List<Producto>> snapshot) {
          if (snapshot.hasData) {
            final productos = snapshot.data;
            return GridView.builder(
                // physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.83,
                  mainAxisSpacing: 10.0,
                  // crossAxisSpacing: 20.0,
                ),
                shrinkWrap: true,
                itemCount: productos.length,
                itemBuilder: (BuildContext context, int i) {
                  final producto = productos[i];
                  return ProductoCardWidget(producto: producto);
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
