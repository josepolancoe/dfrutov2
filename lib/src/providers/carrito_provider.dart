import 'package:dfruto/src/models/producto_model.dart';
import 'package:flutter/material.dart';

class CarritoProvider extends ChangeNotifier {
  List<Producto> _productos = [];

  double _precioTotal = 0.00;

  void add(Producto producto) {
    _productos.add(producto);
    _precioTotal = _precioTotal + producto.precio;
    notifyListeners();
  }

  void remove(Producto producto) {
    _precioTotal = _precioTotal - producto.precio;
    _productos.remove(producto);
    notifyListeners();
  }

  int get cantidadProductos {
    return _productos.length;
  }

  double get precioTotal {
    return _precioTotal;
  }

  List<Producto> get productosDelCarrito {
    return _productos;
  }
}
