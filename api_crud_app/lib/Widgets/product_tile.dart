import 'package:flutter/material.dart';

import '../RestAPI/product_model.dart';

class ProductTile extends StatelessWidget {
  final Data data;
  final Widget icon;
  final VoidCallback onPressed;

  const ProductTile({required this.data, required this.icon, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      child: ListTile(
        title: Text(data.productName.toString()),
        subtitle: Text(data.unitPrice.toString()),
        leading: Image.network(data.img.toString()),
        trailing: IconButton(
          icon: icon,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
