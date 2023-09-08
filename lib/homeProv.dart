import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_api1/models/data_modelProv.dart';
import 'package:flutter_application_api1/postProveedores.dart';
import 'package:flutter_application_api1/putProveedores.dart';
import 'package:http/http.dart' as http;

class ProveedorApi extends StatefulWidget {
  const ProveedorApi({Key? key}) : super(key: key);

  @override
  State<ProveedorApi> createState() => _ProveedorApiState();
}

class _ProveedorApiState extends State<ProveedorApi> {
  bool _isLoading = true;
  ProveedorModel? dataFromAPI;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    try {
      String url = "https://project-valisoft-2559218.onrender.com/api/proveedores";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        dataFromAPI = ProveedorModel.fromJson(json.decode(res.body));
        _isLoading = false;
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Proveedores"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            ): Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Text(
                "Proveedores",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
                  const SizedBox(height: 16),
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('Nombre')),
                      DataColumn(label: Text('Categoría')),
                      DataColumn(label: Text('NIT')),
                      DataColumn(label: Text('Email')),
                      DataColumn(label: Text('Teléfono')),
                      DataColumn(label: Text('Estado')),
                      DataColumn(label: Text('Acciones')),
                    ],
                    rows: dataFromAPI!.proveedors.map((proveedor) {
                      return DataRow(cells: [
                        DataCell(Text(proveedor.nombre.toString())),
                        DataCell(Text(proveedor.categoria.toString())),
                        DataCell(Text(proveedor.nit.toString())),
                        DataCell(Text(proveedor.email.toString())),
                        DataCell(Text(proveedor.telefono.toString())),
                        DataCell(proveedor.estado == true
                            ? const Text("Activo")
                            : const Text("Inactivo")),
                        DataCell(Row(children: [IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const editarProveedor()),
                );
      },
    ),
    IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        // Lógica para eliminar el producto aquí
        // Puedes mostrar un cuadro de diálogo de confirmación antes de eliminar.
        // Luego, realiza la eliminación y actualiza la lista de productos.
      },
    ),
  ],
)),
                      ]);
                    }).toList(),
                  ),
                ],
              ),
            ),
            ),
            floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CrearProveedor()),
              );
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}