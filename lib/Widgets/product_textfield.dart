import 'package:flutter/material.dart';
import '../Style/style.dart';

class ProductTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String labelText;
  const ProductTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: appPrimaryBackground,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: appInputDecoration(label: labelText),
    );
  }
}
