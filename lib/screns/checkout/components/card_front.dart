import 'package:brasil_fields/brasil_fields.dart';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:michellemirandastore/models/credit_card.dart';
import 'package:michellemirandastore/screns/checkout/components/card_text_field.dart';
class CardFront extends StatelessWidget {

  final FocusNode numberFocus;
  final FocusNode dateFocus;
  final FocusNode nameFocus;
  final VoidCallback finished;
  final CreditCard creditCard;

  CardFront({this.numberFocus,this.dateFocus,this.nameFocus,this.finished, this.creditCard});

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
              onSubmitted: (_){
                dateFocus.requestFocus();
              },
              focusNode: numberFocus,
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
                else if(detectCCType(number) == CreditCardType.unknown)
                  return 'Cartão Inválido';
                return null;
              },
              onSaved: creditCard.setNumber,
            ),
            CardTextField(
              onSubmitted: (_){
                nameFocus.requestFocus();
              },
              onSaved: creditCard.setExpirationDate,
              focusNode: dateFocus,
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
              focusNode: nameFocus,
              onSubmitted: (_){
              finished();
              },
              onSaved: creditCard.setHolder,
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