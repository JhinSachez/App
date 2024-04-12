import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:maps/Inicio.dart';
import 'package:maps/password.dart';
import 'package:maps/registro.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final c_usuario = TextEditingController();
  final c_pass = TextEditingController();

  String usuario = '';
  String pass = '';

  validar(usuario, pass){

    c_usuario.text = '';
    c_pass.text = '';
    SmartDialog.dismiss();

    if(usuario == '' || pass == ''){
      alerta('Debes de llenar todos los datos');
    }else if(usuario == 'jhin' && pass == '123') {
      guardar_datos(usuario, pass);

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (BuildContext context) {
            return Inicio(usuario);
          }
      ), (route) => false);

    }else{
      alerta('Usuario o contraseña incorrecto');
    }
  }
  Future guardar_datos(usuario, pass) async {

    final SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setString('usuario', usuario);
    await preferences.setString('password', pass);
  }
  Future ver_preferencias() async {

    final SharedPreferences preferences = await SharedPreferences.getInstance();

    usuario = await preferences.getString('usuario')!;
    pass = await preferences.getString('password')!;

    if(usuario != null){
      if(usuario != ''){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (BuildContext context) {
              return Inicio(usuario);
            }
        ), (route) => false);
      }
    }
  }
  alerta(mensaje) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Primera App'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(mensaje)
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () {
                Navigator.of(context).pop();
              },
                child: Text('Cancelar'),
              ),
            ],
          );
        });
  }

  @override
  void initState(){
    super.initState();
    ver_preferencias();
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                    ),
                    TextField(
                      controller: c_usuario,
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
                    TextField(
                      controller: c_pass,
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
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(onPressed: (){
                            usuario = c_usuario.text;
                            pass = c_pass.text;

                            FocusScope.of(context).unfocus();

                            //mostrar_loading();
                            validar(usuario,pass);

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
          )
        ),
      ),

    );
  }
}
