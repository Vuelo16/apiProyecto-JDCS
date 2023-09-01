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

  @override
  void initState() {
    super.initState();
    _getData();
  }

  ProveedorModel? dataFromAPI;
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
            )
          :Column(
            children: [
            Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final proveedor = dataFromAPI!.proveedors[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(proveedor.nombre.toString()),
                      Text(proveedor.categoria.toString()),
                      Text(proveedor.nit.toString()),
                      Text(proveedor.email.toString()),                     
                      Text(proveedor.telefono.toString()),
                      if(proveedor.estado == true)
                        const Text ("Activo")
                      else
                        const Text("Inactivo")
                      
                    ],
                  ),
                );
              },
              itemCount: dataFromAPI!.proveedors.length,
            ),
          ),
          ElevatedButton(
      onPressed: () {
         Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CrearProveedor()),
          );
      },
      child: const SizedBox(
        width: 100,
        child: Center(
          child: Text('Crear Proveedor'),
        ),
        ),
    ),
    const SizedBox(height: 50,),
    ElevatedButton(
      onPressed: () {
         Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const editarProveedor()),
          );
      },
      child: const SizedBox(
        width: 100,
        child: Center(
          child: Text('Editar Proveedor'),
        ),
        ),
    ),
        const SizedBox(height: 100,),

              ],
            ),
    );
  }
}