import 'package:flutter/material.dart';
import 'package:flutter_application_api1/home.dart';
import 'package:flutter_application_api1/homeProv.dart';

List<String> opciones = ['home', 'homeProv'];

class Lista extends StatelessWidget {
  const Lista({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Proyecto', style: TextStyle(color: Colors.white, fontSize: 25),),
      ),
      body: ListView(
        children:  [
           Card(
            child: Center(
              child:Image.network('https://static.vecteezy.com/system/resources/thumbnails/002/399/634/small/v-letter-logo-business-template-icon-free-vector.jpg', height: 200
              ,)
              ,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_box),
            title: const Text('Productos'),
            onTap: () {
              final route = MaterialPageRoute(builder: (context) => const Home());
              Navigator.push(context, route);
            },
          ),

          ListTile(
            leading: const Icon(Icons.account_box),
            title: const Text('Proveedores'),
            onTap: () {
              final route = MaterialPageRoute(builder: (context) => const ProveedorApi());
              Navigator.push(context, route);
            },
          ),
         
        ],
      ),
    );
  }
}