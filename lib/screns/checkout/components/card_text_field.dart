import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardTextField extends StatelessWidget {
  CardTextField({
    this.tittle,
    this.bold = false,
    this.hint,
    this.textInputType,
    this.inputFormatters,
    this.validator,
    this.maxLenght,
    this.textAlign,
    this.focusNode,
    this.onSubmitted,
    this.onSaved,
  }) : textInputAction =
            onSubmitted == null ? TextInputAction.done : TextInputAction.next;

  final String tittle;
  final bool bold;
  final String hint;
  final TextInputType textInputType;
  final List<TextInputFormatter> inputFormatters;
  final FormFieldValidator<String> validator;
  final int maxLenght;
  final TextAlign textAlign;
  final FocusNode focusNode;
  Function Function(String) onSubmitted;
  final TextInputAction textInputAction;
  final FormFieldSetter<String> onSaved;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: '',
      validator: validator,
      builder: (state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (tittle != null)
                Row(
                  children: [
                    Text(
                      tittle,
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    if (state.hasError)
                      const Text(
                        'Inválido',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 9,
                        ),
                      ),
                  ],
                ),
              TextFormField(
                style: TextStyle(
                  color: tittle == null && state.hasError
                      ? Colors.red
                      : Colors.white,
                  fontWeight: bold ? FontWeight.bold : FontWeight.w500,
                ),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  counterText: "",
                  hintText: hint,
                  hintStyle: TextStyle(
                    color: tittle == null && state.hasError
                        ? Colors.red.withAlpha(100)
                        : Colors.white.withAlpha(100),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 2),
                ),
                keyboardType: textInputType,
                inputFormatters: inputFormatters,
                onChanged: (text) {
                  state.didChange(text);
                },
                maxLength: maxLenght,
                textAlign: textAlign ?? TextAlign.start,
                focusNode: focusNode,
                onFieldSubmitted: onSubmitted,
                textInputAction: textInputAction,
              )
            ],
          ),
        );
      },
    );
  }
}
