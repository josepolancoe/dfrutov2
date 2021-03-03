import 'package:dfruto/src/models/producto_model.dart';
import 'package:dfruto/src/providers/producto_provider.dart';
import 'package:dfruto/src/search/search_delegate.dart';
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
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Navigator.pushNamed(context, '/pedido_page');
                showSearch(context: context, delegate: DataSearch());
              }),
          SizedBox(width: 20),
          IconButton(
              icon: Icon(Icons.shopping_cart_outlined),
              onPressed: () => Navigator.pushNamed(context, '/pedido_page')),
          SizedBox(width: 15),
        ],
      ),
      body: FutureBuilder(
        future: productoProvider.cargarProductos(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Producto>> snapshot) {
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
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    height: 600,
                    width: double.infinity,
                    child: Center(
                        child:
                            Image.asset('assets/images/loading-sandia2.gif'))),
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                      height: 150,
                      width: double.infinity,
                      child: Center(child: CircularProgressIndicator())),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
