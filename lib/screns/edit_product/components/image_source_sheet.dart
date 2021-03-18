import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
class ImageSourceSheet extends StatelessWidget {
  final ImagePicker picker = new ImagePicker();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final Function(File) onImageSelected;



  ImageSourceSheet({this.onImageSelected});
  @override
  Widget build(BuildContext context) {

    Future<void> editImage(String path) async{
      final File croppedFile = await ImageCropper.cropImage(
        compressQuality: 75,
          sourcePath: path,
          aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
          androidUiSettings: AndroidUiSettings(
            toolbarTitle: "Editar Imagem",
            backgroundColor: Theme.of(context).primaryColor,
          ),
        iosUiSettings: const IOSUiSettings(
          title: "Editar Imagem",
          cancelButtonTitle: "Cancelar",
          doneButtonTitle: "Concluir",
        ),
      );
      if(croppedFile != null){
        onImageSelected(croppedFile);
      }
    }

    if(Platform.isAndroid){
      return BottomSheet(
        onClosing: (){},
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FlatButton(
              onPressed: () async{

                final PickedFile pickedfile = await picker.getImage(imageQuality: 25,source: ImageSource.camera);
                if(pickedfile == null){
                  return;
                }
                editImage(pickedfile.path);
                },
              child: Text("Câmera"),
            ),
            Divider(
              color: Colors.grey,
              height: 20,
            ),
            FlatButton(
              onPressed: () async{
                final PickedFile pickedfile = await picker.getImage(imageQuality: 25,source: ImageSource.gallery);
                if(pickedfile == null){
                  return;
                }
                editImage(pickedfile.path);
              },
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
            onPressed: () async {
              final PickedFile pickedfile = await picker.getImage(source: ImageSource.camera);
              editImage(pickedfile.path);
              Navigator.of(context).pop();
            },
            child: const Text("Câmera"),
          ),
          CupertinoActionSheetAction(
            child: const Text("Galeria"),
            onPressed: () async {
              final PickedFile pickedfile = await picker.getImage(source: ImageSource.gallery);
              editImage(pickedfile.path);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
    }

}
