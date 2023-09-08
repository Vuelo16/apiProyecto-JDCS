import 'dart:async';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_api1/home.dart';
import 'package:http/http.dart' as http;

class editarProducto extends StatefulWidget {
  final Product producto;

  const editarProducto({Key? key, required this.producto}) : super(key: key);

  @override
  State<editarProducto> createState() {
    return _editarProductoState();
  }
}

class _editarProductoState extends State<editarProducto> {
  final TextEditingController _nombreProd = TextEditingController();
  final TextEditingController _descripcion = TextEditingController();
  final TextEditingController _categoria = TextEditingController();
  final TextEditingController _stock = TextEditingController();
  final TextEditingController _stock_min = TextEditingController();
  final TextEditingController _valor_uni = TextEditingController();
  final TextEditingController _estadoProd = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nombreProd.text = widget.producto.nombreProd;
    _descripcion.text = widget.producto.descripcion;
    _categoria.text = widget.producto.categoria;
    _stock.text = widget.producto.stock.toString();
    _stock_min.text = widget.producto.stock_min.toString();
    _valor_uni.text = widget.producto.valor_uni.toString();
    _estadoProd.text = widget.producto.estadoProd.toString();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Editar Productos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: buildColumn(),
        ),
      ),
    );
  }

  Scaffold buildColumn() {
    return Scaffold(
       body:  SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 200),
          child: Column(
            children: [
          const SizedBox(height: 16),
              TextFormField(
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      controller: _nombreProd,
      decoration: const InputDecoration(
        labelText: 'Nombre',
        suffixIcon: Icon(Icons.group_outlined),
        icon: Icon(Icons.assignment_ind_outlined),
      ),
      onChanged: (value) {
        print('value: $value');
      },
    ),
    const SizedBox(height: 16),

    TextFormField(
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      controller: _descripcion,
      decoration: const InputDecoration(
        labelText: 'Descripcion',
        suffixIcon: Icon(Icons.group_outlined),
        icon: Icon(Icons.assignment_ind_outlined),
      ),
      onChanged: (value) {
        print('value: $value');
      },
    ),
    const SizedBox(height: 16),

    TextFormField(
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      controller: _categoria,
      decoration: const InputDecoration(
        labelText: 'Categoria',
        suffixIcon: Icon(Icons.group_outlined),
        icon: Icon(Icons.assignment_ind_outlined),
      ),
      onChanged: (value) {
        print('value: $value');
      },
    ),
    const SizedBox(height: 16),

    TextFormField(
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      controller: _stock,
      decoration: const InputDecoration(
        labelText: 'Stock',
        suffixIcon: Icon(Icons.group_outlined),
        icon: Icon(Icons.assignment_ind_outlined),
      ),
      onChanged: (value) {
        print('value: $value');
      },
    ),
    const SizedBox(height: 16),

    TextFormField(
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      controller: _stock_min,
      decoration: const InputDecoration(
        labelText: 'Stock Minimo',
        suffixIcon: Icon(Icons.group_outlined),
        icon: Icon(Icons.assignment_ind_outlined),
      ),
      onChanged: (value) {
        print('value: $value');
      },
    ),
    const SizedBox(height: 16),

    TextFormField(
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      controller: _valor_uni,
      decoration: const InputDecoration(
        labelText: 'Valor unitario',
        suffixIcon: Icon(Icons.group_outlined),
        icon: Icon(Icons.assignment_ind_outlined),
      ),
      onChanged: (value) {
        print('value: $value');
      },
    ),

    TextFormField(
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      controller: _estadoProd,
      decoration: const InputDecoration(
        labelText: 'Estado',
        suffixIcon: Icon(Icons.group_outlined),
        icon: Icon(Icons.assignment_ind_outlined),
      ),
      onChanged: (value) {
        print('value: $value');
      },
    ),
    const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            final String nuevoNombreProd = _nombreProd.text;
            final String nuevaDescripcion = _descripcion.text;
            final String nuevaCategoria = _categoria.text;
            final String nuevoStock = _stock.text;
            final String nuevoStockMin = _stock_min.text;
            final String nuevoValorUni = _valor_uni.text;
            final String nuevoEstadoProd = _estadoProd.text;

            final Product productoActualizado = Product(
              id: widget.producto.id,
              nombreProd: nuevoNombreProd,
              descripcion: nuevaDescripcion,
              categoria: nuevaCategoria,
              stock: int.parse(nuevoStock),
              stock_min: int.parse(nuevoStockMin),
              valor_uni: double.parse(nuevoValorUni),
              estadoProd: bool.fromEnvironment(nuevoEstadoProd),
            );

            actualizarProducto(context, productoActualizado);
            
            // Envía el producto actualizado al servidor o realiza la edición según tus necesidades
            // Aquí puedes llamar a una función que envíe la solicitud de edición al servidor

            // Después de editar, puedes navegar de regreso a la página anterior o realizar otras acciones
          },
          child: const Text('Editar Producto'),
        ),
      ],
          ),
        ),
       ),
    );
  }
}

Future<void> actualizarProducto(BuildContext context, Product productoActualizado) async {
             const url = 'https://entregable-node-back.onrender.com/api/producto/';

  final response = await http.put(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'nombreProd': productoActualizado.nombreProd,
      'descripcion': productoActualizado.descripcion,
      'categoria': productoActualizado.categoria,
      'stock': productoActualizado.stock,
      'stock_min': productoActualizado.stock_min,
      'valor_uni': productoActualizado.valor_uni,
      'estadoProd': productoActualizado.estadoProd,
    }),
  );

  if (response.statusCode == 200) {
    // El producto se actualizó con éxito en el servidor
    // Aquí puedes realizar cualquier acción adicional, como navegar de regreso a la página de inicio.
    print('Producto actualizado con éxito');
    // Puedes mostrar un mensaje de éxito o realizar otras acciones según tus necesidades.
  } else {
    // Hubo un error al actualizar el producto, puedes mostrar un mensaje de error o manejar la situación de otra manera.
    print('Error al actualizar el producto');
  }
}