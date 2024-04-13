import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:maps/Inicio.dart';
import 'package:maps/JsonModels/users.dart';
import 'package:maps/SQLite/sqlite.dart';
import 'package:maps/password.dart';
import 'package:maps/registro.dart';
import 'package:maps/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final usuario = TextEditingController();
  final pass = TextEditingController();
  bool isLoggingTrue = false;
  bool isChecked =  false;

  final db = DatabaseHelper();

  login() async{
    Users? usrDetails = await db.getUser(usuario.text);
    var res = await db.login(Users(usrName: usuario.text, usrPassword: pass.text));
    if(res == true){
      if(!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Perfil(perfiles: usrDetails,)));
    } else {
      isLoggingTrue = true;
    }
  }



  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap:(){
          final FocusScopeNode focus = FocusScope.of(context);
          if(!focus.hasPrimaryFocus && focus.hasFocus){
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            child: ListView(
              children: [
                Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 200,
                      ),
                      TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return "usuario requerido";
                          }
                          return null;
                        },
                        controller: usuario,
                        keyboardType: TextInputType.text,
                        autocorrect: true,
                        textCapitalization: TextCapitalization.words,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        decoration: InputDecoration(
                          hintText: 'Username',
                          hintStyle: TextStyle(color: Colors.grey),
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
                      TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return 'contraseña requerida';
                          }
                          return null;
                        },
                        controller: pass,
                        keyboardType: TextInputType.text,
                        autocorrect: true,
                        textCapitalization: TextCapitalization.words,
                        obscureText: true,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.grey),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                                return ForgotPass();
                              }
                              ));
                            },
                            child: Text('Forgot Password?', style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                            ),),
                          )
                        ],
                      ),
                      ListTile(
                        horizontalTitleGap: 1,
                        title: Text('Remember me', style: TextStyle(fontSize: 20)),
                        leading: Checkbox(
                          value: isChecked,
                          onChanged: (value){
                            setState(() {
                              isChecked = !isChecked;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      isLoggingTrue
                          ? const Text('El usuario o la contraseña son incorrectos', style: TextStyle(color: Colors.red, fontSize: 17)):
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(onPressed: (){
                              if(formkey.currentState!.validate()){
                                login();
                              }
                              FocusScope.of(context).unfocus();
                            }, child: Text('Sign In',style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('¿No tienes cuenta?',style: TextStyle(fontSize: 20)),
                      Text('Crea una aqui',style: TextStyle(fontSize: 18)),
                      Icon(CupertinoIcons.arrow_down),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(onPressed: (){

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Registro()));
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
          )
        ),
      ),

    );
  }
}
