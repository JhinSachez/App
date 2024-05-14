import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:maps/menu.dart';
import 'package:maps/userPreferences/current_user.dart';
import 'package:http/http.dart' as http;
import 'package:maps/usuario.dart';

class EditarDatos extends StatefulWidget {
  const EditarDatos({super.key});

  @override
  State<EditarDatos> createState() => _EditarDatosState();
}

class _EditarDatosState extends State<EditarDatos> {

  final CurrentUser _currentUser = Get.put(CurrentUser());

  final email = TextEditingController();
  final name = TextEditingController();

  Future<void> saveInfo() async
  {
    var res = await http.post(
      Uri.http('housemanager.website', '/clase_apps/php/editarperfil.php'),
      body: {
        "user_id": _currentUser.user.user_id.toString(),
        "user_email": email.text.trim(),
        "user_name": name.text.trim(),
      },
    );

    print('Response: ' +res.body);

    if(res.body == '1'){
      Fluttertoast.showToast(msg: "Se ha guardado correctamente");
      //Navigator.of(context).pop();
    }
    else{
      Fluttertoast.showToast(msg: "Error Occurred, try again.");
      setState(() {
        name.clear();
        email.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Editar datos del usuario'),
        ),
        endDrawer: Menu(),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Text('Escribe tu nombre', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              TextField(
                controller: name,
                cursorColor: Colors.blueAccent,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Escribe tu nombre',
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.white)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blueAccent)
                    )
                ),
              ),
              SizedBox(height: 20,),
              Text('Escribe tu nuevo email', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              TextField(
                controller: email,
                cursorColor: Colors.blueAccent,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Escribe tu email',
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.white)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blueAccent)
                    )
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: (){
                    FocusScope.of(context).unfocus();
                    saveInfo();
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                      return Perfil();
                    }));
                  },
                  child: Text('Guardar')
              ),
            ],
          )
      ),
    );
  }
}


