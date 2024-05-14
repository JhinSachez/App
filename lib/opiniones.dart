import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:maps/addopinion.dart';
import 'datos_opiniones.dart';
import 'package:http/http.dart' as http;
import 'menu.dart';

class Opiniones extends StatefulWidget {
  const Opiniones({super.key});

  @override
  State<Opiniones> createState() => _OpinionesState();
}

class _OpinionesState extends State<Opiniones> {
  List<Datos_Opiniones> datos = [];
  bool loading = true;

  Future<List<Datos_Opiniones>> tomar_datos() async{
    var url = Uri.http('housemanager.website', '/clase_apps/php/veropiniones.php');

    var response = await http.post(url).timeout(Duration(seconds: 90));
    //print(response.body);
    var datos = jsonDecode(response.body);
    List<Datos_Opiniones> registros = [];
    for(datos in datos){
      registros.add(Datos_Opiniones.fromJson(datos));
    }
    return registros;
  }

  mostrar_alerta(id,opinion_msg){
    showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('ALERT!!!'),
            content: SingleChildScrollView(
              child: Text('Realmente lo quieres eliminar?'),
            ),
            actions: [
              TextButton(onPressed: (){
                confirmar_eliminar(id);
              }, child:Text('Eliminar',style: TextStyle(color: Colors.red))),
              TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text('Cancelar', style: TextStyle(color: Colors.blue))),
            ],
          );
        });
  }

  Future<void> confirmar_eliminar(id) async{
    var url = Uri.http('housemanager.website', '/clase_apps/php/erase.php');
    var response = await http.post(url, body: {
      'opinion_id' : id
    });
    Navigator.of(context).pop();
    if(response.body == '1'){
      setState(() {
        datos = [];
        loading = true;
        tomar_datos().then((value){
          setState(() {
            datos.addAll(value);
            loading = false;
          });
        });
      });

    }else{
      print(response.body);
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tomar_datos().then((value){
      setState(() {
        datos.addAll(value);
        loading = false;
        print(datos);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Opiniones"),
      ),
      endDrawer: Menu(),
      body: loading == true ? Center(child: CircularProgressIndicator(color: Colors.blue)) :Column(
        children: [
          Expanded(child: ListView.builder(
            itemCount: datos.length,
            itemBuilder: (BuildContext context, int index){
              return Container(
                padding: EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  border:Border(
                    bottom:BorderSide(color: Colors.black)
                  )
                ),
                child: Row(
                  children: [
                    Expanded(child: Text(datos[index].opinion_msg!, style: const TextStyle(fontSize: 14))),
                    GestureDetector(child: Icon(Icons.delete, color: Colors.red,),
                      onTap: (){
                        mostrar_alerta(datos[index].id, datos[index].opinion_msg);
                      },
                    )
                  ],
                ),
              );
            },
          ))
        ]
    ),
floatingActionButton: FloatingActionButton(
  onPressed: ()
    {
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
        return AddOpinion();
      })).then((value){
setState(() {
datos= [];
loading = true;
tomar_datos().then((value){
setState(() {
  datos.addAll(value);
  loading = false;
});
});
});
      });
    },
  child: Icon(Icons.add, color: Colors.white),
  backgroundColor: Colors.orange,
  )
  );
}}

