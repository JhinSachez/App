import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maps/Inicio.dart';
import 'package:maps/interes.dart';
import 'package:maps/puntos.dart';
import 'package:maps/usuario.dart';


class Menu extends StatefulWidget {
  var usuario;
   Menu(this.usuario, {super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          SizedBox(
            height: 200,
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Inicio(widget.usuario);
                  }
              ), (route) => false);
            },
            title: Text('Inicio'),
            leading: Icon(Icons.home),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Marcadores(widget.usuario);
                  }
              ), (route) => false);
            },
            title: Text('Aparto'),
            leading: Icon(Icons.flag),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Interes(widget.usuario);
                  }
              ), (route) => false);
            },
            title: Text('Lugares de interes'),
            leading: Icon(Icons.map),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Usuario(widget.usuario);
                  }
              ), (route) => false);
            },
            title: Text('Usuario'),
            leading: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
