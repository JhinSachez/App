import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'menu.dart';


class Inicio extends StatefulWidget {
  var usuario;
   Inicio(this.usuario, {super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  List<String> imagelist = [
    "imagenes/Imagen1.jpg",
    "imagenes/Imagen2.jpg",
    "imagenes/Imagen3.jpg",
    "imagenes/Imagen4.jpg",
    "imagenes/Imagen5.jpg",
    "imagenes/Imagen6.jpg",
    "imagenes/Imagen7.jpg",
    "imagenes/Imagen8.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Inicio'),
        ),
      endDrawer: Menu(widget.usuario),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          CarouselSlider(items: imagelist.map((e) => ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(e,
                //height: 200,
                //width: 150,
                fit: BoxFit.cover,
                ),
                //Text(e)
              ],
            ),
          )).toList(), options: CarouselOptions(
            autoPlay: true,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            //height: 150
          )),
          Text('Detalles de la casa', style: TextStyle(fontSize: 30)),
          Text('Reglas',style: TextStyle(fontSize: 30))

        ],
    )
    );
  }
}
