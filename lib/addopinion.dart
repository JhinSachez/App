import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddOpinion extends StatefulWidget {
  const AddOpinion({super.key});

  @override
  State<AddOpinion> createState() => _AddOpinionState();
}

class _AddOpinionState extends State<AddOpinion> {
  final c_opinion =TextEditingController();

  String opinion = '';

  Future<void> agregar() async {
    var url =Uri.http('housemanager.website', '/clase_apps/php/addopinion.php');
    var response =await http.post(url, body: {
      'opinion_msg' : opinion,
    });
    print('Respuesta: ' + response.body);

    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agrega una opinion"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: ListView(
          children: [
            Column(
              children: [
                TextField(
                  controller: c_opinion,
                  keyboardType: TextInputType.text,
                  autocorrect: true,
                  textCapitalization: TextCapitalization.words,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  decoration: InputDecoration(
                    hintText: 'Opinion',
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black
                        ),
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(flex: 1,
                        child: ElevatedButton(onPressed: (){
                         opinion = c_opinion.text;

                          agregar();
                        }, child: Text('Guardar',style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange)
                        )
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
