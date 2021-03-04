import 'dart:ui';

import 'package:dfruto/constantes.dart';
import 'package:dfruto/src/models/producto_model.dart';
import 'package:dfruto/src/providers/carrito_provider.dart';
import 'package:dfruto/src/search/search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductoDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Producto _producto = ModalRoute.of(context).settings.arguments;
    final carrito = Provider.of<CarritoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${_producto.nombre}'),
        centerTitle: true,
        actions: _getAppBar(carrito, context),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            SizedBox(
              width: 280,
              child: AspectRatio(
                aspectRatio: 1,
                child: Hero(
                    tag: _producto.id.toString(),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(_producto.fotoUrl))),
              ),
            ),
            SizedBox(height: 35),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    _producto.nombre,
                    style: TextStyle(
                        fontSize: 26,
                        color: kSecondaryColorDfruto,
                        fontWeight: FontWeight
                            .bold), //Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, top: 10),
                  child: Text(
                    _producto.descripcion,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
                    maxLines: 5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          "Calidad garantizada",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: kSplashColorDfruto),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.check_circle,
                          size: 14,
                          color: kSplashColorDfruto,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 35),
            RaisedButton(
              onPressed: () {
                carrito.add(_producto);
              },
              padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
              color: kUltimateColorDfruto,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                "Añadir al carrito",
                style: TextStyle(
                    color: kSecondaryColorDfruto,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
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
                      onPressed: () =>
                          Navigator.pushNamed(context, '/pedido_page')),
                  new Positioned(
                    top: 7.0,
                    right: 7.0,
                    child: new Text(
                      carrito.productosDelCarrito.length.toString(),
                      style: new TextStyle(
                          color: kUltimateColorDfruto,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            )
          : new Container(
              child: new Stack(
              children: <Widget>[
                new IconButton(
                    icon: Icon(Icons.shopping_cart_outlined),
                    onPressed: () =>
                        Navigator.pushNamed(context, '/pedido_page')),
                new Positioned(
                  top: 7.0,
                  right: 7.0,
                  child: new Text(
                    carrito.productosDelCarrito.length.toString(),
                    style: new TextStyle(
                        color: kUltimateColorDfruto,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            )),
      SizedBox(width: 20),
    ];
  }
}
