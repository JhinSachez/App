import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'menu.dart';

class Marcadores extends StatefulWidget {
  const Marcadores({super.key});

  @override
  State<Marcadores> createState() => _MarcadoresState();
}

class _MarcadoresState extends State<Marcadores> {
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rente la casa'),
      ),
      endDrawer: Menu(),
    body: GestureDetector(
    onTap:(){
    final FocusScopeNode focus = FocusScope.of(context);
    if(!focus.hasPrimaryFocus && focus.hasFocus){
    FocusManager.instance.primaryFocus?.unfocus();
    }
    },
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: ListView(
            children: [
              Form(
                key: formkey,
               child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Text('Agregue de que dia a que dia piensa alquilar la casa', style: TextStyle(fontSize: 25)),
                    Text('Fecha de llegada'),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Fecha requerida';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      autocorrect: true,
                      textCapitalization: TextCapitalization.words,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2
                              )
                          )
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Fecha de salida'),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Fecha requerida';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      autocorrect: true,
                      textCapitalization: TextCapitalization.words,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2
                              )
                          )
                      ),
                    ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(onPressed: (){
                        FocusScope.of(context).unfocus();
                      }, child: Text('Alquilar',style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black
                        ),
                      ),
                  ],
                ),
              )
            ],
        )
          ),
        ),
      ),
    );
  }
}
