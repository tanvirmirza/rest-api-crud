import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Model/product_model.dart';

class ProductCartTile extends StatelessWidget {
  final Data data;
  final Widget icon;
  final VoidCallback onPressed;

  const ProductCartTile(
      {required this.data,
      required this.icon,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 250, 250, 250),
          borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      child: ListTile(
        title: Text(data.productName.toString()),
        subtitle: Text(NumberFormat.decimalPattern().format(data.unitPrice)),
        leading: Image.network(
          data.img.toString(),
          width: 50,
          fit: BoxFit.cover,
        ),
        trailing: IconButton(
          icon: icon,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
