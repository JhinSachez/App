import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text('Agregue un username'),
                  TextField(
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
                  Text('Agregue una contraseña'),
                  TextField(
                    keyboardType: TextInputType.text,
                    autocorrect: true,
                    textCapitalization: TextCapitalization.words,
                    obscureText: true,
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
                  Text('Agregue un email'),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: true,
                    textCapitalization: TextCapitalization.words,
                    obscureText: true,
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
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(onPressed: (){

                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                              builder: (BuildContext context) {
                                return Registro();
                              }
                          ), (route) => false);
                          FocusScope.of(context).unfocus();


                        }, child: Text('Log in',style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
