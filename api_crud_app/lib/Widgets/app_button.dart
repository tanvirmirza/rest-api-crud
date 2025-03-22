import 'package:api_crud_app/Style/style.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String buttonText;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onPressed;
  const AppButton(
      {required this.buttonText,
      this.backgroundColor = appPrimaryBackground,
      this.foregroundColor = appPrimaryForeground,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          foregroundColor: foregroundColor, backgroundColor: backgroundColor),
      child: Text(buttonText),
    );
  }
}
