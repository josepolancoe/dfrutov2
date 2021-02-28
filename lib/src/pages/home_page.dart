import 'package:dfruto/constantes.dart';
import 'package:flutter/material.dart';

// import 'package:dfruto/screens/admin/productos/admin_productos_screen.dart';
// import 'package:dfruto/screens/admin/stock/admin_stock_screen.dart';

import 'dart:math';
import 'dart:ui';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _fondoApp2(),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[_titulos(), _botonesRedondeados(context)],
            ),
          )
        ],
      ),
      // bottomNavigationBar: _bottomNavigationBar(context)
    );
  }

  Widget _fondoApp2() {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.6),
              end: FractionalOffset(0.0, 1.0),
              colors: [
            kPrimaryLightColor,
            Color.fromRGBO(236, 252, 232, 1.0)
          ])),
    );

    final cajaRosa = Transform.rotate(
        angle: -pi / 5.0,
        child: Container(
          height: 360.0,
          width: 360.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80.0),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(241, 245, 208, 1.0),
                Color.fromRGBO(209, 245, 191, 1.0),
                Color.fromRGBO(194, 227, 186, 1.0),
                Color.fromRGBO(164, 201, 155, 1.0)
              ])),
        ));

    return Stack(
      children: <Widget>[gradiente, Positioned(top: -100.0, child: cajaRosa)],
    );
  }

  Widget _titulos() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Image.asset("assets/images/dfruto-logo2.png", height: 60.0, filterQuality: FilterQuality.medium),
            // Image.network('https://dfruto.ga/dfruto-logo2.png',height: 60.0, filterQuality: FilterQuality.medium),
            // Text('Classify transaction',
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 30.0,
            //         fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            Text('Fruta fresca de calidad y al mejor precio en tus manos.',
                style: TextStyle(color: Colors.black, fontSize: 19.0)),
          ],
        ),
      ),
    );
  }

  // Widget _bottomNavigationBar(BuildContext context) {
  //   return Theme(
  //     data: Theme.of(context).copyWith(
  //         canvasColor: Color.fromRGBO(55, 57, 84, 1.0),
  //         primaryColor: kSplashColorDfruto,
  //         textTheme: Theme.of(context).textTheme.copyWith(
  //             caption: TextStyle(color: Color.fromRGBO(116, 117, 152, 1.0)))),
  //     child: BottomNavigationBar(
  //       items: [
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.home, size: 30.0), title: Container()),
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.add_shopping_cart, size: 30.0),
  //             title: Container()),
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.supervised_user_circle, size: 30.0),
  //             title: Container()),
  //       ],
  //     ),
  //   );
  // }

  Widget _botonesRedondeados(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          _crearBotonRedondeado(
              kSplashColorDfruto, Icons.person, 'Clientes', 1, context),
          _crearBotonRedondeado(
              kSplashColorDfruto, Icons.person, 'Proveedores', 2, context),
        ]),
        TableRow(children: [
          _crearBotonRedondeado(kPrimaryColorDfruto, Icons.shopping_cart,
              'Productos', 3, context),
          _crearBotonRedondeado(
              kPrimaryColorDfruto, Icons.insert_chart, 'Stock', 4, context),
        ]),
      ],
    );
  }

  Widget _crearBotonRedondeado(
      Color color, IconData icono, String texto, int i, BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (i) {
          case 1:
            Navigator.pushNamed(context, '/cliente_page');
            break;
          case 2:
            // Navigator.pushNamed(context, '/proveedor_page');
            break;
          case 3:
            // Navigator.pushNamed(context, AdminProductosScreen.routeName);
            break;
          default:
          // Navigator.pushNamed(context, AdminStockScreen.routeName);
        }
      },
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
          // filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            height: 180.0,
            margin: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                // color: kSecondaryColorDfruto ,
                color: Color.fromRGBO(62, 66, 107, 0.8),
                borderRadius: BorderRadius.circular(20.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(height: 5.0),
                CircleAvatar(
                  backgroundColor: color,
                  radius: 35.0,
                  child: Icon(icono, color: Colors.white, size: 30.0),
                ),
                Text(texto,
                    style: TextStyle(color: Colors.white, fontSize: 17)),
                SizedBox(height: 5.0)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
