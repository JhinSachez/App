import 'package:flutter/material.dart';

import 'menu.dart';

class Interes extends StatefulWidget {

  const Interes({super.key});

  @override
  State<Interes> createState() => _InteresState();
}

class _InteresState extends State<Interes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lugares de interes'),
      ),
      endDrawer: Menu(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: ListView(
            children: [
              Column(
                children: [
                  
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
