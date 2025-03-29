import 'package:api_crud_app/Widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/product_cart_provider.dart';
import '../Style/style.dart';
import '../Widgets/product_cart_tile.dart';
import 'package:intl/intl.dart';

class ProductCart extends StatelessWidget {
  const ProductCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
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
            body: cartProvider.cartItems.isEmpty
                ? const Center(
                    child: Text('No Item Available'),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: cartProvider.cartItems.length,
                          itemBuilder: (context, index) {
                            var product =
                                cartProvider.cartItems.values.toList()[index];
                            return ProductCartTile(
                                data: product,
                                icon: const Icon(Icons.delete_forever_rounded),
                                onPressed: () {
                                   cartProvider.removeFromCart(product.sId!);
                                   ScaffoldMessenger.of(context).showSnackBar(
                                    bottomSnackBar(
                                        label:
                                            'Cart Product has been deleted!',
                                        backgroundColor: colorRed));
                                });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                                "Total: ৳${NumberFormat.decimalPattern().format(cartProvider.totalAmount)}",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            AppButton(
                              buttonText: 'Proceed to Checkout',
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    bottomSnackBar(
                                        label:
                                            'Checkout is not implemented yet!',
                                        backgroundColor: colorRed));
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ));
      },
    );
  }
}
