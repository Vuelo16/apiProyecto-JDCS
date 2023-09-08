import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//https://frontendhbs.onrender.com/
Future<Product> createProducto(String nombreProd, String descripcion, String categoria, String stock, String stock_min, String valor_uni, String estadoProd) async {
  final response = await http.post(
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
  runApp(const CrearProducto());
}

class CrearProducto extends StatefulWidget {
  const CrearProducto({super.key});

  @override
  State<CrearProducto> createState() {
    return _CrearProductoState();
  }
}


class _CrearProductoState extends State<CrearProducto> {
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
      debugShowCheckedModeBanner: false,
      title: 'Crear Productos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: (_futureProduct == null) ? buildColumn() : buildFutureBuilder(),
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
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureProduct = createProducto(_nombreProd.text, _descripcion.text, _categoria.text, _stock.text, _stock_min.text, _valor_uni.text, _estadoProd.text);
            });
          },
          child: const Text('Crear Producto'),
        ),
      ],
          ),
        ),
       ),
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