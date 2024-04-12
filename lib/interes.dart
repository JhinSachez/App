import 'package:flutter/material.dart';

import 'menu.dart';

class Interes extends StatefulWidget {
  var usuario;
  Interes(this.usuario,{super.key});

  @override
  State<Interes> createState() => _InteresState();
}

class _InteresState extends State<Interes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lugares de interes'),
      ),
      endDrawer: Menu(widget.usuario),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: ListView(
            children: [
              Column(
                children: [
                  
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
