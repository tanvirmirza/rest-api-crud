import 'package:api_crud_app/Widgets/secondary_button.dart';
import 'package:flutter/material.dart';

import '../RestAPI/product_model.dart';
import '../RestAPI/rest_api_client.dart';
import '../Style/style.dart';
import '../Widgets/app_button.dart';
import '../Widgets/product_textfield.dart';

class ProductUpdateScreen extends StatefulWidget {
  final Data data;
  final String? id;


  const ProductUpdateScreen(
      {
        required this.data,
        this.id,

      super.key});

  @override
  State<ProductUpdateScreen> createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {
  final ProductController productController = ProductController();
  Data get data => widget.data;



  late TextEditingController prodNameController;
  late TextEditingController prodQuantityController;
  late TextEditingController prodImageController;
  late TextEditingController prodUnitPriceController;
  late TextEditingController prodTotalPriceController;

  Future<void> UpdatedProduct() async {
    await productController.fetchProducts();
    try {
      if (prodNameController.text.isNotEmpty &&
          prodImageController.text.isNotEmpty &&
          int.tryParse(prodQuantityController.text) != null &&
          int.tryParse(prodUnitPriceController.text) != null &&
          int.tryParse(prodTotalPriceController.text) != null) {
        if (data.sId != null) {
          await productController.updateProduct(
            data.sId!,
            prodNameController.text,
            prodImageController.text,
            int.parse(prodQuantityController.text),
            int.parse(prodUnitPriceController.text),
            int.parse(prodTotalPriceController.text),
          );
        }
      }
    } catch (e) {
      throw Exception('An error occurred while processing the data!');
    }
  }

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
    UpdatedProduct();
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
             Navigator.popAndPushNamed(context, '/homeScreen');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
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
                        Navigator.pop(context);
                      },
                      buttonText: 'Cencel'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: AppButton(
                      onPressed: () async {
                        await UpdatedProduct();
                        ScaffoldMessenger.of(context).showSnackBar(
                          bottomSnackBar(
                            label: 'Successfully Updated Product!',
                          ),
                        );

                        Navigator.pop(context, true);
                        setState(() {});
                      },
                      buttonText: 'Update'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
