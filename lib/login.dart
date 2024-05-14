import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maps/password.dart';
import 'package:maps/registro.dart';
import 'package:maps/userPreferences/user_preferences.dart';
import 'package:maps/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'api_connection/api_connection.dart';
import 'home.dart';
import 'model/user.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  //final usuario = TextEditingController();
  final user = TextEditingController();
  final pass = TextEditingController();
  bool isLoggingTrue = false;
  final formkey = GlobalKey<FormState>();


  loginUserNow() async{
    try{
      var res = await http.post(
        Uri.http('housemanager.website', '/clase_apps/php/login.php'),
        body: {
          "user_name": user.text.trim(),
          "user_password": pass.text.trim(),
        },
      );

      if(res.statusCode == 200){
        var resBodyOfLogin = jsonDecode(res.body);
        if(resBodyOfLogin['success'] == true){
          Fluttertoast.showToast(msg: "Haz ingresado ");

          User userInfo = User.fromJson(resBodyOfLogin["userData"]);
          await RememberUserPrefs.storeUserInfo(userInfo);
          
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              builder: (BuildContext context) {
                return Inicio();
              }
          ), (route) => false);
        } else {
          Fluttertoast.showToast(msg: "Escriba bien los datos, vuelva a intentarlo");

        }
      }
    }catch(e){
      print("Error :: " + e.toString());
    }
  }

  /*Future<void> ingresar() async{
    var url = Uri.http('housemanager.website', '/clase_apps/php/login.php');

    var response = await http.post(url, body: {
      'usuario' : usuario,
      'pass' : pass
    });
    var datos = jsonDecode(response.body);

    if(datos['respuesta'] == '1'){

      /*Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (BuildContext context) {
            return Bienvenida(usuario);
          }
      ), (route) => false);*/

    } else {
      print(datos['mensaje']);
    }

    //Navigator.of(context).pop();
  }*/



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
                            return "email requerido";
                          }
                          return null;
                        },
                        controller: user,
                        keyboardType: TextInputType.text,
                        autocorrect: true,
                        textCapitalization: TextCapitalization.words,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        decoration: InputDecoration(
                          hintText: 'email',
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
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(onPressed: (){
                              if(formkey.currentState!.validate()){
                              loginUserNow();
                              }
                              FocusScope.of(context).unfocus();
                            }, child: Text('Login',style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange
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
                  
                  
                            }, child: Text('Sign in',style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange
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
