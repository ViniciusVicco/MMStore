import 'package:flutter/material.dart';

class RecoverPassowrd extends StatefulWidget {
  @override
  _RecoverPassowrdState createState() => _RecoverPassowrdState();
}

class _RecoverPassowrdState extends State<RecoverPassowrd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recuperação de senha"),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                   height:  MediaQuery.of(context).size.height * 0.5,
                   child: Column(
                     children: [
                       SizedBox(
                         height: 20,
                       ),
                       Container(
                             width: MediaQuery.of(context).size.width * 0.8,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           border: Border.all(
                             color: Theme.of(context).scaffoldBackgroundColor,

                           )
                         ),
                         child: TextFormField(
                           decoration: InputDecoration(
                             border: InputBorder.none
                           ),
                         ),
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