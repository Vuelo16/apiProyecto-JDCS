import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//https://frontendhbs.onrender.com/
Future<Product> editProducto(String nombreProd, String descripcion, String categoria, String stock, String stock_min, String valor_uni, String estadoProd) async {
  final response = await http.put(
    Uri.parse('https://entregable-node-back.onrender.com/api/producto'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "nombreProd": nombreProd,
        "descripcion": descripcion,
        "categoria": categoria,
        "stock": stock,
        "stock_min": stock_min,
        "valor_uni": valor_uni,
        "estadoProd": estadoProd,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Product.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception(response.body);
  }
}

class Product {
  final  String id;
  final  String nombreProd;
  final  int descripcion;
  final  String categoria;
  final  int stock;
  final  String stock_min;
  final double valor_uni;
  final  bool estadoProd;

  const Product({required this.id, required this.nombreProd, required this.descripcion, required this.categoria, required this.stock, required this.stock_min, required this.valor_uni, required this.estadoProd});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["_id"],
        nombreProd: json["nombreProd"],
        descripcion: json["descripcion"],
        categoria: json["categoria"],
        stock: json["stock"],
        stock_min: json["stock_min"],
        valor_uni: json["valor_uni"]?.toDouble(),
        estadoProd: json["estadoProd"],
    );
  }
}


void main() {
  runApp(const editarProducto());
}

class editarProducto extends StatefulWidget {
  const editarProducto({super.key});

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
  Future<Product>? _futureProduct;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Editar Productos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Editar'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: (_futureProduct == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _nombreProd,
          decoration: const InputDecoration(hintText: 'Digite Nombre'),
        ),
        TextField(
          controller: _descripcion,
          decoration: const InputDecoration(hintText: 'Digite descripcion'),
        ),
         TextField(
          controller: _categoria,
          decoration: const InputDecoration(hintText: 'Digite categoria'),
        ),
        TextField(
          controller: _stock,
          decoration: const InputDecoration(hintText: 'Digite stock'),
        ),
        TextField(
          controller: _stock_min,
          decoration: const InputDecoration(hintText: 'Digite stock minimo'),
        ),
        TextField(
          controller: _valor_uni,
          decoration: const InputDecoration(hintText: 'Digite valor unitario'),
        ),
          TextField(
          controller: _estadoProd,
          decoration: const InputDecoration(hintText: 'Digite Estado'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureProduct = editProducto(_nombreProd.text, _descripcion.text, _categoria.text, _stock.text, _stock_min.text, _valor_uni.text, _estadoProd.text);
            });
          },
          child: const Text('Editar Producto'),
        ),
      ],
    );
  }

  FutureBuilder<Product> buildFutureBuilder() {
    return FutureBuilder<Product>(
      future: _futureProduct,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.nombreProd);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}