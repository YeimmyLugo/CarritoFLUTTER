import 'package:flutter/material.dart';

import 'lista_productos.dart';

class Carrito extends StatefulWidget {
  //hara que la lista  que se llama de productos no cambie
  final List<ListaProductos> _cart;

  const Carrito(this._cart, {super.key});

  @override
  _CarritoState createState() => _CarritoState(this._cart);
}

class _CarritoState extends State<Carrito> {
  _CarritoState(this._cart);

//almacena los productos que entren en la lista cart
  List<ListaProductos> _cart;
// se crea el widget para darle el diseño y funcionalidad a los elementos
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent[100],
      //se crea la barra de navegación que tendra carrito
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        title: const Text(
          'Detalles del producto',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
        //se crea un icono parq eu vuelva a la pagina inicial de productos
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              _cart.length;
            });
          },
          color: Colors.pink,
        ),
      ),
      //con el gestor logramos que esta tenga un diseño estructurado y que ademas cumpla la funcion de retornar a la pagina principal
      body: GestureDetector(
          child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                   shrinkWrap: true,
                   physics: const NeverScrollableScrollPhysics(),
                    itemCount: _cart.length,
                    itemBuilder: (context, index) {
                      //retornara lo productos que entren dependiento que se selecciono en la lista
                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 9),
                       child: Column(
                          children: <Widget>[
                           Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //se le adjunta la imagen a cada item
                                Container(
                                  width: 70,
                                  height: 70,
                                  child: Image(
                                    image: NetworkImage(
                                        _cart[index].imageURL.toString()),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                 Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                           Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Center(
                                              child: Text(
                                                _cart[index].nombre.toString(),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                 ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ))),
    );
  }
}