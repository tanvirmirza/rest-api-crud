import 'package:api_crud_app/RestAPI/rest_api_client.dart';
import 'package:flutter/material.dart';

import '../Style/style.dart';
import '../Widgets/product_tile.dart';

class ProductCart extends StatefulWidget {
  const ProductCart({super.key});

  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {

  final ProductController productController = ProductController(); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: bodyBackground,
      appBar: AppBar(
        title: const Text('Product Cart'),
        leading: IconButton(
          icon: backNavigat,
          iconSize: 35,
          color: colorGrey,
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/homeScreen');
          },
        ),
      ),
      body: ListView.builder(
        itemCount: productController.products.length,
        itemBuilder: (context, index) {
          var product = productController.products[index];
        return ProductTile(
          data: product,
          icon: const Icon(Icons.delete),
          onPressed: (){},
        );
      }),
    );
  }
}
