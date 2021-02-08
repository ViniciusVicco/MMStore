import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:michellemirandastore/models/credit_card.dart';
import 'package:michellemirandastore/screns/checkout/components/card_text_field.dart';

class CardBack extends StatelessWidget {

  final FocusNode cvvFocus;
  final CreditCard creditCard;
  CardBack({this.cvvFocus, this.creditCard});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 16,
      child: Container(
        height: 200,
        color: const Color(0xFF1B4B52),
        child: Column(
          children: [
            Container(
              color: Colors.black,
              height: 40,
              margin: EdgeInsets.symmetric(vertical: 16),
            ),
            Row(
              children: [
                Expanded(
                  flex: 70,
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(left: 12),
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    color: Colors.grey[500],
                    child: CardTextField(
                      focusNode: cvvFocus,
                      onSaved: creditCard.setCVV,
                      tittle: "",
                      hint: '123',
                      maxLenght: 3,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                      textAlign: TextAlign.end,
                      textInputType: TextInputType.number,
                      validator: (cvv) {
                        if (cvv.length != 3) return 'Inválido';
                        return null;
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 30,
                  child: Container(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
