import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:michellemirandastore/models/address.dart';
import 'package:screenshot/screenshot.dart';

class ExportAddressDialog extends StatelessWidget {
  final Address address;
  final ScreenshotController screenShotController = ScreenshotController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  ExportAddressDialog({this.address, this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Endereço de Entrega'),
      content: Screenshot(
        controller: screenShotController,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(8),
          child: Text(
              '${address.street}, ${address.number} ${address.complement}\n'
              '${address.district}\n'
              '${address.city}/${address.state}\n'
              '${address.zipCode}'),
        ),
      ),
      actions: [
        FlatButton(
            onPressed: () async {
              final file = await screenShotController.capture();
              await GallerySaver.saveImage(file.path);
              scaffoldKey.currentState.showSnackBar(SnackBar(
                  content:
                      Text("Etiqueta do Endereço exportada para galeria")));
              Navigator.of(context).pop();
            },
            child: Text(
              "Exportar",
              style:
                  TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
            ))
      ],
      contentPadding: EdgeInsets.fromLTRB(8, 16, 8, 0),
    );
  }
}
