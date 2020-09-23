import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ImageSourceSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(!Platform.isAndroid){
      return BottomSheet(
        onClosing: (){},
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FlatButton(
              onPressed: (){},
              child: Text("Câmera"),
            ),
            Divider(
              color: Colors.grey,
              height: 20,
            ),
            FlatButton(
              onPressed: (){},
              child: Text("Galeria"),
            ),
          ],
        ),
      );
    } else {
      return CupertinoActionSheet(
        title: const Text("Selecionar foto para o item"),
        message: Text("Escolha a origem da foto"),
        cancelButton: CupertinoActionSheetAction(
          onPressed: (){
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        actions: [
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: (){},
            child: const Text("Câmera"),
          ),
          CupertinoActionSheetAction(
            child: const Text("Câmera"),
            onPressed: () {},
          ),
        ],
      );
    }
    }

}
