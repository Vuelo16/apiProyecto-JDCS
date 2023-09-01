import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_api1/models/data_model.dart';
import 'package:flutter_application_api1/postProductos.dart';
import 'package:flutter_application_api1/putProductos.dart';
import 'package:http/http.dart' as http;
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  DataModel? dataFromAPI;
  _getData() async {
    try {
      String url = "https://entregable-node-back.onrender.com/api/producto";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        dataFromAPI = DataModel.fromJson(json.decode(res.body));
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
        title: const Text("Productos"),
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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(dataFromAPI!.products[index].nombreProd.toString()),
                      Text(dataFromAPI!.products[index].descripcion.toString()),
                      Text(dataFromAPI!.products[index].categoria.toString()),
                      Text(dataFromAPI!.products[index].stock.toString()),
                      Text(dataFromAPI!.products[index].stock_min.toString()),
                      Text("\$${dataFromAPI!.products[index].valor_uni.toString()}"),
                      if(dataFromAPI!.products[index].estadoProd == true)
                        const Text ("Activo")
                      else
                        const Text("Inactivo")

                    ],
                  ),
                );
              },
              itemCount: dataFromAPI!.products.length,
              ),
            ),
     ElevatedButton(
      onPressed: () {
         Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CrearProducto()),
          );
      },
      child: const SizedBox(
        width: 100,
        child: Center(
          child: Text('Crear Producto'),
        ),
        ),
    ),
        const SizedBox(height: 50,),

    ElevatedButton(
      onPressed: () {
         Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const editarProducto()),
          );
      },
      child: const SizedBox(
        width: 100,
        child: Center(
          child: Text('Editar Producto'),
        ),
        ),
    ),
        const SizedBox(height: 100,),

              ],
            ),
    );
  }
}