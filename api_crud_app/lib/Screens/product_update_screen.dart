import 'package:api_crud_app/Provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/product_model.dart';
import '../Widgets/app_button.dart';
import '../Widgets/product_textfield.dart';
import '../Style/style.dart';
import '../Widgets/secondary_button.dart';

class ProductUpdateScreen extends StatefulWidget {
  final Data data;
  final String? id;

  const ProductUpdateScreen({required this.data, this.id, super.key});

  @override
  State<ProductUpdateScreen> createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {
  Data get data => widget.data;

  late TextEditingController prodNameController;
  late TextEditingController prodQuantityController;
  late TextEditingController prodImageController;
  late TextEditingController prodUnitPriceController;
  late TextEditingController prodTotalPriceController;

  @override
  void initState() {
    super.initState();
    prodImageController = TextEditingController(text: data.img ?? '');
    prodNameController = TextEditingController(text: data.productName ?? '');
    prodQuantityController =
        TextEditingController(text: data.qty?.toString() ?? '');
    prodUnitPriceController =
        TextEditingController(text: data.unitPrice?.toString() ?? '');
    prodTotalPriceController =
        TextEditingController(text: data.totalPrice?.toString() ?? '');
  }

  @override
  void dispose() {
    prodNameController.dispose();
    prodQuantityController.dispose();
    prodImageController.dispose();
    prodUnitPriceController.dispose();
    prodTotalPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyBackground,
      appBar: AppBar(
        title: const Text('Edit Product'),
        leading: IconButton(
          icon: backNavigat,
          iconSize: 35,
          color: colorGrey,
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/homeScreen');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            return ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                ProductTextField(
                  controller: prodImageController,
                  labelText: 'Product Image',
                ),
                const SizedBox(
                  height: 15,
                ),
                ProductTextField(
                  controller: prodNameController,
                  labelText: 'Product Name',
                ),
                const SizedBox(
                  height: 15,
                ),
                ProductTextField(
                  controller: prodQuantityController,
                  keyboardType: TextInputType.number,
                  labelText: 'Product Quantity',
                ),
                const SizedBox(
                  height: 15,
                ),
                ProductTextField(
                  controller: prodUnitPriceController,
                  keyboardType: TextInputType.number,
                  labelText: 'Product Unit Price',
                ),
                const SizedBox(
                  height: 15,
                ),
                ProductTextField(
                  controller: prodTotalPriceController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  labelText: 'Product Total Price',
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AppSecondaryButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/homeScreen');
                        },
                        buttonText: 'Cancel',
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: AppButton(
                        onPressed: () async {
                          await productProvider.updateProduct(
                            data.sId!,
                            prodNameController.text,
                            prodImageController.text,
                            int.parse(prodQuantityController.text),
                            int.parse(prodUnitPriceController.text),
                            int.parse(prodTotalPriceController.text),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            bottomSnackBar(
                                label: 'Successfully Updated Product!'),
                          );

                          Navigator.pushReplacementNamed(
                              context, '/homeScreen');
                        },
                        buttonText: 'Update',
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
