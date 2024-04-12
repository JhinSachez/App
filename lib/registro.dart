import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maps/JsonModels/users.dart';
import 'package:maps/SQLite/sqlite.dart';
import 'package:maps/login.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {

  final usuario = TextEditingController();
  final pass = TextEditingController();
  final conpass = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: ListView(
            children: [
              Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Text('Agregue un username'),
                    TextFormField(
                      controller: usuario,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'usuario requerido';
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
                    Text('Agregue una contraseña'),
                    TextFormField(
                      controller: pass,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'contraseña requerida';
                        }
                        return null;
                      },
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
                    Text('Confirme la contraseña'),
                    TextFormField(
                      controller: conpass,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'contraseña requerida';
                        } else if (pass.text != conpass.text){
                          return "las contraseñas no coinciden";
                        }
                        return null;
                      },
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
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(onPressed: (){
                            if(formkey.currentState!.validate()){
                              final db = DatabaseHelper();
                              db.signup(Users(usrName: usuario.text, usrPassword: pass.text)).whenComplete(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const Login()));
                              });
                            }


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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
