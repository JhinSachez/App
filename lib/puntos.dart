import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'menu.dart';

class Marcadores extends StatefulWidget {
  var usuario;
  Marcadores(this.usuario,{super.key});

  @override
  State<Marcadores> createState() => _MarcadoresState();
}

class _MarcadoresState extends State<Marcadores> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apartar'),
      ),
      endDrawer: Menu(widget.usuario),

    );
  }
}
