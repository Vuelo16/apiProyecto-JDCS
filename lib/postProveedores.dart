import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//https://frontendhbs.onrender.com/
Future<Proveed> createProveedor(String nombreProveedor, String nit, String emailProv, String telefonoProv, String categoriaProv, String estadoProv ) async {
  final response = await http.post(
    Uri.parse('https://project-valisoft-2559218.onrender.com/api/proveedores'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "nombreProveedor": nombreProveedor,
        "nit": nit,
        "emailProv": emailProv,
        "telefonoProv": telefonoProv,
        "categoriaProv": categoriaProv,
        "estadoProv": estadoProv,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Proveed.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception(response.body);
  }
}

class Proveed {
  final  String id;
  final  String nombreProveedor;
  final  int nit;
  final  String emailProv;
  final  int telefonoProv;
  final  String categoriaProv;
  final  bool estadoProv;

  const Proveed({required this.id, required this.nombreProveedor, required this.nit, required this.emailProv, required this.telefonoProv, required this.categoriaProv, required this.estadoProv});

  factory Proveed.fromJson(Map<String, dynamic> json) {
    return Proveed(
      id: json["_id"],
        nombreProveedor: json["nombreProveedor"],
        nit: json["nit"],
        emailProv: json["emailProv"],
        telefonoProv: json["telefonoProv"],
        categoriaProv: json["categoriaProv"],
        estadoProv: json["estadoProv"],
    );
  }
}


void main() {
  runApp(const CrearProveedor());
}

class CrearProveedor extends StatefulWidget {
  const CrearProveedor({super.key});

  @override
  State<CrearProveedor> createState() {
    return _CrearProveedorState();
  }
}


class _CrearProveedorState extends State<CrearProveedor> {
  final TextEditingController _nombreProveedor = TextEditingController();
  final TextEditingController _nit = TextEditingController();
  final TextEditingController _emailProv = TextEditingController();
  final TextEditingController _telefonoProv = TextEditingController();
  final TextEditingController _categoriaProv = TextEditingController();
  final TextEditingController _estadoProv = TextEditingController();
  Future<Proveed>? _futureProveed;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crear Proveedores',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: (_futureProveed == null) ? buildColumn() : buildFutureBuilder(),
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
      controller: _nombreProveedor,
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
      controller: _categoriaProv,
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
      controller: _nit,
      decoration: const InputDecoration(
        labelText: 'Nit',
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
      controller: _emailProv,
      decoration: const InputDecoration(
        labelText: 'Correo electronico',
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
      controller: _telefonoProv,
      decoration: const InputDecoration(
        labelText: 'Telefono',
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
      controller: _estadoProv,
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
              _futureProveed = createProveedor(_nombreProveedor.text, _nit.text, _emailProv.text, _telefonoProv.text, _categoriaProv.text, _estadoProv.text);
            });
                      },
          child: const Text('Crear proveedor'),
        ),
      ],
          ),
        ),
       ),
    );
  }

  FutureBuilder<Proveed> buildFutureBuilder() {
    return FutureBuilder<Proveed>(
      future: _futureProveed,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.nombreProveedor);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}