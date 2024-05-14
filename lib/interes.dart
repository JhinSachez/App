import 'package:flutter/material.dart';

import 'menu.dart';

class Interes extends StatefulWidget {

  const Interes({super.key});

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
      endDrawer: Menu(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: ListView(
            children: [
              Column(
                children: [
                  Image.asset("imagenes/Interes/I1.jpg"),
                  Text("Malecon Mazatlán",style: TextStyle(fontSize: 20)),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset("imagenes/Interes/I2.jpg"),
                  Text("Nuevo Acuario Mazatlán",style: TextStyle(fontSize: 20)),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset("imagenes/Interes/I3.jpg"),
                  Text("Faro con mirador de cristal",style: TextStyle(fontSize: 20)),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset("imagenes/Interes/I4.jpg"),
                  Text("Plazuela Machado",style: TextStyle(fontSize: 20)),
                  SizedBox(
                    height: 10,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
