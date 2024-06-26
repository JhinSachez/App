import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:maps/api_connection/api_connection.dart';
import 'package:maps/login.dart';
import 'package:http/http.dart' as http;
import 'package:maps/userPreferences/user_preferences.dart';
import 'package:path/path.dart' as path;
import 'home.dart';
import 'model/user.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {

  final usuario = TextEditingController();
  final password = TextEditingController();
  final email = TextEditingController();
  final formkey = GlobalKey<FormState>();

  validateUserEmail() async{
    try
    {
      var res = await http.post(
        Uri.http('housemanager.website', '/clase_apps/php/validate_email.php'),
        body: {
          'user_email': email.text.trim(),
        }
      );

      if(res.statusCode == 200){
        var resBodyOfValidateEmail = jsonDecode(res.body);

        if(resBodyOfValidateEmail['emailFound'] == true){
          Fluttertoast.showToast(msg: "El email ya esta en uso");
        } else{
          registarAndSaveUserRecord();

        }
      }
    }
    catch(e)
    {

    }
  }

  registarAndSaveUserRecord() async{
    User userModel = User(
      1,
      usuario.text.trim(),
      email.text.trim(),
      password.text.trim(),
    );

    try{
     var res = await http.post(
        Uri.http('housemanager.website', '/clase_apps/php/signup.php'),
        body: userModel.toJson(),
      );

     if(res.statusCode == 200){
       var resBodyOfSignUp = jsonDecode(res.body);
       if(resBodyOfSignUp['success'] == true){
         Fluttertoast.showToast(msg: "Se ha registrado correctamente");

         try{
           var res = await http.post(
             Uri.http('housemanager.website','/clase_apps/php/login.php'),
             body: {
               "user_name": usuario.text.trim(),
               "user_password": password.text.trim(),
             },
           );

           var resBodyOfLogin = jsonDecode(res.body);
           Fluttertoast.showToast(msg: "Logged in.");


           User userInfo = User.fromJson(resBodyOfLogin["userData"]);
           await RememberUserPrefs.storeUserInfo(userInfo);

           Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
               builder: (BuildContext context) {
                 return Inicio();
               }
           ), (route) => false);
         }
         catch(errorMsg)
         {
           print("Error :: " + errorMsg.toString());
         }
       }
       else{
         Fluttertoast.showToast(msg: "Error Occurred, try again.");
         setState(() {
           usuario.clear();
           email.clear();
           password.clear();
         });
       }
     }
    }
    catch(e){
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

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
     child:  Center(
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
                          return 'Usuario requerido';
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
                    Text('Agregue un email'),
                    TextFormField(
                      controller: email,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Email requerido';
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
                      controller: password,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Contraseña requerida';
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
                              validateUserEmail();

                            }

                            FocusScope.of(context).unfocus();


                          }, child: Text('Create',style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
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
        ),
      ),
    )
    );
  }
}
