import 'package:flutter/material.dart';
import 'package:navigator2_v3/presentation/shooping_cart.dart' show Carrito;

import 'lista_productos.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ListaProductos> _productosModel = <ListaProductos>[];

  final List<ListaProductos> _listaCarro = <ListaProductos>[];

  @override
  void initState() {

    super.initState();
    _productos();
  }

  @override
 Widget build(BuildContext context) {
    //Es un Widget el cual nos ayuda a darle un mejor diseño a nuestra hoja
    return Scaffold(
      backgroundColor: Colors.cyanAccent[100],
      //creamos un header con un titulo y un icono el cual hace un conteo de los productos que entran a la lista del carrito
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text('Productos '),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 8.0),
              child: GestureDetector(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    const Icon(
                      Icons.shopping_cart,
                      size: 38,
                    ),
                    if (_listaCarro.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: CircleAvatar(
                          radius: 8.0,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          child: Text(
                            _listaCarro.length.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12.0),
                          ),
                        ),
                      )
                  ],
                ),
                //Nos envia a la lista de productos de carrito
                onTap: () {
                  if (_listaCarro.isNotEmpty) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Carrito(_listaCarro),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
        //creamos una lista la cual tiene una imagen del producto, el nombre del producto y un icono paraa añadir a la lista del carrito
        body: ListView.builder(
          //mostramos los productos que tenemos en la lista
          itemCount: _productosModel.length,
          itemBuilder: (context, index) {
            var item =_productosModel[index];
            //hacemos un carta para tenertodo mas organizado
            return Card(
              //la separamos 5px una de cada
              elevation: 5,
              //hacemos una margen de cada carta
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Container(
                padding: EdgeInsets.all(8),
                //Creamos una fila
                child: Row(
                  //alineamos al centro
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //hacemos un contenedor el cual tiene una imagen
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      child: Image(
                        image: NetworkImage(
                            _productosModel[index].imageURL.toString()),
                        fit: BoxFit.fill,
                      ),
                    ),
                    //expandimos el row
                    Expanded(
                      //creamos otro contenedor el cual tiene el nombre del producto y precio
                        child: Container(
                          padding: EdgeInsets.only(bottom: 8),
                          //creamos una columna para tener los dos objetos uno debajo del otro
                          child: Column(
                            //centramos
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                child: Text(
                                  //productosModel es el array de productos en este momento lo utilizamos para que nos traiga el nombre
                                  _productosModel[index].nombre.toString(),
                                  //damos un negrilla y tamaño de letra
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                child:
                                //productosModel es el array de productos en este momento lo utilizamos para que nos traiga el precio
                                Text(_productosModel[index].precio.toString()),
                              ),
                            ],
                          ),
                        )),
                    //creamos un icono que sirve de boton
                    IconButton(
                        onPressed: () {
                          //Nos sirve para mantener el estado del boton actualizado
                          setState(() {
                            if(!_listaCarro.contains(item)) {
                              _listaCarro.add(item);
                            } else {
                              _listaCarro.remove(item);
                            }

                          });
                        },
                        //los signos de diferente al inicio y al finalnos sirve para invertir de false a true y viceversa
                        icon: (!_listaCarro.contains(item))
                        //el signo? convinado con los : nos sirve como una sentencia de if y else
                            ? const Icon(Icons.shopping_cart)
                            : const Icon(
                          Icons.shopping_cart_checkout,
                          color: Colors.green,
                        ))
                  ],
                ),
              ),
            );
          },
        ));
  }
//creacion lista de productos
  void _productos() {
    var list = <ListaProductos>[
      ListaProductos(nombre: 'Pizza familiar 3 carnes', precio: 40000, imageURL: 'img/pizza.png', id: 1, isAdd: false),
      ListaProductos(nombre: 'Hamburguesa', precio: 16500, imageURL: 'img/hamburguesa.jpg', id: 2, isAdd: false),
      ListaProductos(nombre: 'Salchipapas', precio: 11750, imageURL: 'img/salchipapa.jpg', id: 3, isAdd: false),
      ListaProductos(nombre: 'Perro Caliente', precio: 8900, imageURL: 'img/perrito.jpg', id: 4, isAdd: false),
      ListaProductos(nombre: 'Lasaña', precio: 17000, imageURL: 'img/lasaña.jpg', id: 5, isAdd: false)
    ];
    setState(() {
      _productosModel = list;
    });
  }
}
