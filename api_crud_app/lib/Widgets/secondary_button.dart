import 'package:api_crud_app/Style/style.dart';
import 'package:flutter/material.dart';

class AppSecondaryButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const AppSecondaryButton(
      {required this.buttonText, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: appPrimaryBackground),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(color: appPrimaryBackground),
      ),
    );
  }
}
