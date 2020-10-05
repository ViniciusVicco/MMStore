import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/product.dart';

import 'image_source_sheet.dart';

class ImagesForm extends StatelessWidget {

  Product product;
  ImagesForm(this.product);
  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: List.from(product.images),
      validator: (images){
        if(images.isEmpty){
          return 'Insira ao menos uma Imagem';
        } else return null;
      },
      onSaved: (images) => product.newImages = images,
      autovalidate: true,
      builder: (state){
        void onImageSelected(File file){
          state.value.add(file);
          state.didChange(state.value);
          Navigator.of(context).pop();
        }

        return Column(
          children:[ AspectRatio(
            aspectRatio: 1,
            child: Carousel(
              images: state.value.map<Widget>((image){
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    if(image is String)
                      Image.network(image, fit: BoxFit.cover,)
                    else
                      Image.file(image as File, fit: BoxFit.cover,),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.remove),
                        color: Colors.red,
                        onPressed: (){
//                        if(state.value.length==1){
//                          print("Não pode remover a única imagem");
//                          return;
//                        }
//                        else{
//                          state.value.remove(image);
//                          state.didChange(state.value);
//                        }
                          state.value.remove(image);
                          state.didChange(state.value);
                        },
                      ),
                    )
                  ],
                );
              }).toList()..add(
                Material(
                  color: Colors.grey[100],
                  child: IconButton(
                    color: Theme.of(context).primaryColor,
                    iconSize: 50,
                    icon: Icon(Icons.add_a_photo),
                    onPressed: (){
                      if(Platform.isAndroid)
                      showModalBottomSheet(context: context, builder: (_) => ImageSourceSheet(onImageSelected: onImageSelected));
                      else
                        showCupertinoModalPopup(context: null, builder: (_) => ImageSourceSheet(onImageSelected: onImageSelected));
                    },
                  ),
                )
              ),
              dotSize: 4,
              dotSpacing: 15,
              dotBgColor: Theme.of(context).primaryColor,
              dotColor: Colors.white,
              autoplay: false, // AutoPlay
            ),
          ),
            if(state.hasError)
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 16,left: 16),
                child: Text(
                  state.errorText,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 14
                  ),
                ),
              ),
        ]
        );
      }
    );
  }
}
