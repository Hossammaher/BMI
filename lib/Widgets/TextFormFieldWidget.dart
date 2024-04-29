import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget({required this.labelText , required this.controller});


  String labelText;
  TextEditingController? controller ;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
        decoration: InputDecoration(
            labelText: labelText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $labelText';
          }
          return null;
        },
        );
  }
}
