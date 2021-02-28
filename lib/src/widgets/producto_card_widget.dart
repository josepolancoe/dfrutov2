import 'package:dfruto/constantes.dart';
import 'package:dfruto/src/models/producto_model.dart';
import 'package:dfruto/src/providers/carrito_provider.dart';
// import 'package:dfruto/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductoCardWidget extends StatelessWidget {
  const ProductoCardWidget({
    // Key key,
    @required this.producto,
  });

  final double width = 160, aspectRetio = 1.02;
  final Producto producto;

  @override
  Widget build(BuildContext context) {
    final carrito = Provider.of<CarritoProvider>(context);
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: SizedBox(
        width: width,
        child: GestureDetector(
          // onTap: () => Navigator.pushNamed(
          //   context,
          //   DetailsScreen2.routeName,
          //   arguments: ProductDetailsArguments2(producto: producto),
          // ),
          onTap: () {
            carrito.add(producto);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    // tag: Text("hero1"),
                    tag: producto.id.toString(),
                    child: (producto.fotoUrl == null)
                        ? Image(image: AssetImage('assets/images/no-image.jpg'))
                        : FadeInImage(
                            image: NetworkImage(producto.fotoUrl),
                            placeholder:
                                AssetImage('assets/images/loading.gif'),
                            height: 100.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              const SizedBox(height: 5),
              Text(
                producto.nombre,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "S/.${producto.precio.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
