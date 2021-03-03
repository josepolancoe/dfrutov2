import 'package:dfruto/constantes.dart';
import 'package:dfruto/src/pages/cliente/cliente_form.dart';
import 'package:dfruto/src/pages/cliente/cliente_pages.dart';
import 'package:dfruto/src/pages/home_page.dart';
import 'package:dfruto/src/pages/pedido/pedido_page.dart';
import 'package:dfruto/src/pages/producto/producto_page.dart';
import 'package:dfruto/src/pages/provedor/proveedor_form.dart';
import 'package:dfruto/src/pages/provedor/proveedor_page.dart';
import 'package:dfruto/src/providers/carrito_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
 
void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(MyApp());
} 
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CarritoProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: kPrimaryColorDfruto,
          fontFamily: 'Croog Pro'
        ),
        debugShowCheckedModeBanner: false,
        title: 'Dfruto Developer',
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
      ),
    );
  }
}