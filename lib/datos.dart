import 'package:flutter/material.dart';
import 'package:maps/menu.dart';

class EditarDatos extends StatefulWidget {
  var usuario;
  EditarDatos(this.usuario,{super.key});

  @override
  State<EditarDatos> createState() => _EditarDatosState();
}

class _EditarDatosState extends State<EditarDatos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar datos del usuario'),
      ),
      endDrawer: Menu(widget.usuario),
    );
  }
}
