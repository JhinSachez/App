import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:maps/userPreferences/current_user.dart';

import 'menu.dart';

class Inicio extends StatelessWidget {
  CurrentUser _rememberCurrentUser = Get.put(CurrentUser());


    List<String> imagelist = [
      "imagenes/casa/Imagen1.jpg",
      "imagenes/casa/Imagen2.jpg",
      "imagenes/casa/Imagen3.jpg",
      "imagenes/casa/Imagen4.jpg",
      "imagenes/casa/Imagen5.jpg",
      "imagenes/casa/Imagen6.jpg",
      "imagenes/casa/Imagen7.jpg",
      "imagenes/casa/Imagen8.jpg",
    ];


    @override
    Widget build(BuildContext context) {
      return GetBuilder(
        init: CurrentUser(),
        initState: (currentState){
          _rememberCurrentUser.getUserInfo();
        }, builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Inicio'),
            ),
            endDrawer: Menu(),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Localizacion de la casa: Río Évora 365-255, Lomas del Mar, 82010 Mazatlán, Sin.', style: TextStyle(fontSize: 20)),
                ),
                Text('Reglas',style: TextStyle(fontSize: 30))

              ],
            )
        );
      },
      );
    }
  }


