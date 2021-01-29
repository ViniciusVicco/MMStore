import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:michellemirandastore/screns/checkout/components/card_text_field.dart';
class CardFront extends StatelessWidget {

  final MaskTextInputFormatter dateFormartter = MaskTextInputFormatter(
    mask: '!#/####',
    filter: {'#': RegExp('[0-9]'), '!': RegExp('[0-1]')}
  );

  final MaskTextInputFormatter creditCardFormartter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {'#': RegExp('[0-9]')}
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 16,
      child: Container(
        padding: const EdgeInsets.all(24.0),
        height: 200,
        color: const Color(0xFF1B4B52),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CardTextField(
              tittle: 'Número',
              hint: '0000 0000 0000 0000',
              textInputType: TextInputType.number,
              bold: true,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                CartaoBancarioInputFormatter(),
              ],
              validator: (number){
                if(number.length != 19) return 'Inválido';
                return null;
              },

            ),
            CardTextField(
              tittle: 'Validade',
              hint: '12/2021',
              textInputType: TextInputType.number,
              bold: true,
              inputFormatters: [
                dateFormartter,
              ],
              validator: (date){
                if(date.length != 7) return 'Inválido';
                return null;
              },
            ),
            CardTextField(
              tittle: 'Titular',
              hint: 'João da Silva',
              bold: true,
              validator: (name){
                if(name.isEmpty){
                  return 'Titular inválido';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}