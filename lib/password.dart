import 'package:flutter/material.dart';
import 'package:maps/login.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  alerta() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Email enviado'),
            content: SingleChildScrollView(
            ),
            actions: [
              TextButton(onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Login();
                    }
                ), (route) => false);
              },
                child: Text('Okay'),
              ),
            ],
          );
        });
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
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: ListView(
            children:[ Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                Text('Ingrese un email para enviarle los pasos', style: TextStyle(fontSize: 20)),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: true,
                  textCapitalization: TextCapitalization.words,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  decoration: InputDecoration(
                      hintText: 'Email',
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
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(onPressed: (){

                        FocusScope.of(context).unfocus();
                        alerta();


                      }, child: Text('Send Email',style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ]
          ),
        ),
      ),
    ),
    );
  }
}
