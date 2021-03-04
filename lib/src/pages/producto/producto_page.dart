import 'package:dfruto/constantes.dart';
import 'package:dfruto/src/models/producto_model.dart';
import 'package:dfruto/src/providers/carrito_provider.dart';
import 'package:dfruto/src/providers/producto_provider.dart';
import 'package:dfruto/src/search/search_delegate.dart';
import 'package:dfruto/src/widgets/producto_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final productoProvider = new ProductoProvider();

  @override
  Widget build(BuildContext context) {
    final carrito = Provider.of<CarritoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        centerTitle: true,
        actions: _getAppBar(carrito, context),
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

  List<Widget> _getAppBar(CarritoProvider carrito, BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          showSearch(context: context, delegate: DataSearch());
        }),

      carrito.productosDelCarrito.length == 0
        ? Container(
          child: Stack(
            children: [
              new IconButton(
                  icon: Icon(Icons.shopping_cart_outlined),
                  onPressed: () => Navigator.pushNamed(context, '/pedido_page')),
              new Positioned(
                    top: 7.0,
                    right: 7.0,
                    child: new Text(
                      carrito.productosDelCarrito.length.toString(),
                      style: new TextStyle(
                          color: kUltimateColorDfruto,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w500),
                    ),),
            ],
          ),
        )
        : new Container(
          child: new Stack(
            children: <Widget>[
              new IconButton(
                  icon: Icon(Icons.shopping_cart_outlined),
                  onPressed: () =>Navigator.pushNamed(context, '/pedido_page')
                ),
              new Positioned(
                top: 7.0,
                right: 7.0,
                child: new Center(
                  child: new Text(
                    carrito.productosDelCarrito.length.toString(),
                    style: new TextStyle(
                        color: kUltimateColorDfruto,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ),
            ],
          )),
    SizedBox(width: 20),
    ];
  }
}
