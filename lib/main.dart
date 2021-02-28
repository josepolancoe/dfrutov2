import 'package:dfruto/src/pages/cliente/cliente_form.dart';
import 'package:dfruto/src/pages/cliente/cliente_pages.dart';
import 'package:dfruto/src/pages/home_page.dart';
import 'package:dfruto/src/pages/pedido/pedido_page.dart';
import 'package:dfruto/src/pages/producto/producto_page.dart';
import 'package:dfruto/src/pages/provedor/proveedor_form.dart';
import 'package:dfruto/src/pages/provedor/proveedor_page.dart';
import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),

        '/cliente_page': (context) => ClientePage(),
        '/cliente_form' : (context) => FormClientePage(),
        
        '/proveedor_page': (context) => ProveedorPage(),
        '/proveedor_form': (context) => FormProveedorPage(),


        // '/proveedor_form': (context) => FormProveedorPage(),
        '/producto_page': (context) => ProductoPage(),
        '/pedido_page': (context) => PedidoPage(),


      },
    );
  }
}