import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maps/datos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';

import 'login.dart';
import 'menu.dart';


class Usuario extends StatefulWidget {
  var usuario;
   Usuario(this.usuario, {super.key});

  @override
  State<Usuario> createState() => _UsuarioState();
}

class _UsuarioState extends State<Usuario> {

  Future cerrar_sesion() async {

    final SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.clear();

    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (BuildContext context){
          return Login();
        }
    ), (route) => false);
  }

  File? imagen = null;
  final ImagePicker picker = new ImagePicker();

  Future selecionar_imagen(op) async{

    var pickerFile;
    if(op == 1){
      pickerFile = await picker.pickImage(source: ImageSource.camera);
    }else{
      pickerFile = await picker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      if(pickerFile != null){
        //imagen = File(pickerFile.path);
        cortar(File(pickerFile.path));
      }
    });
  }

  Future cortar(picker) async {

    CroppedFile? cortado = await ImageCropper().cropImage(sourcePath: picker.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0));

    if(cortado != null){
      setState(() {
        imagen = File(cortado.path);
      });
    }
  }
  
  seleccionar(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: SingleChildScrollView(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        selecionar_imagen(1);
                      },
                      child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(width: 2, color: Colors.grey)
                                )
                            ),
                            child: Column(
                              children: [
                                Image.asset('imagenes/Camara.png', width: 50),
                                Text('Tomar foto', style: TextStyle(fontSize: 20),)
                              ],
                            )
                          )
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                        selecionar_imagen(2);
                      },
                      child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Image.asset('imagenes/Galeria.png', width: 50),
                              Text('Usar galeria', style: TextStyle(fontSize: 20),)
                            ],
                          )
                      )
                    )
                  ],
                ),
              )
          );
        }
        );
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuario'),
      ),
        endDrawer: Menu(widget.usuario),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            children: [
              imagen == null ? Center() : Image.file(imagen!),
              InkWell(
                onTap: (){
                  seleccionar();
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Cambiar imagen', style: TextStyle(fontSize: 20)),
                    Icon(CupertinoIcons.pencil_circle_fill, size: 30)
                  ],
                )
              ),
              Text(widget.usuario, style: TextStyle(fontSize: 30)),
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                      builder: (BuildContext context) {
                        return EditarDatos(widget.usuario);
                      }
                  ), (route) => false);
                },
                child: Text("Editar Datos", style: TextStyle(fontSize: 20)),
              ),
              ElevatedButton(
                onPressed: (){
                  cerrar_sesion();
                },
                child: Text("Cerrar sesion", style: TextStyle(fontSize: 20)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
