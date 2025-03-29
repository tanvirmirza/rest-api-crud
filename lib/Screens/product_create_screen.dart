import 'package:api_crud_app/Provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Style/style.dart';
import '../Widgets/app_button.dart';
import '../Widgets/secondary_button.dart';
import '../Widgets/product_textfield.dart';

class ProductCreateScreen extends StatefulWidget {
  const ProductCreateScreen({super.key});

  @override
  State<ProductCreateScreen> createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  final TextEditingController prodImageController = TextEditingController();
  final TextEditingController prodNameController = TextEditingController();

  final TextEditingController prodQuantityController = TextEditingController();

  final TextEditingController prodUnitPriceController = TextEditingController();

  final TextEditingController prodTotalPriceController =
      TextEditingController();

  Future<void> createdProduct(BuildContext context) async {
    final productController =
        Provider.of<ProductProvider>(context, listen: false);

    if (prodNameController.text.isNotEmpty &&
        prodImageController.text.isNotEmpty &&
        int.tryParse(prodQuantityController.text) != null &&
        int.tryParse(prodUnitPriceController.text) != null &&
        int.tryParse(prodTotalPriceController.text) != null) {
      try {
        await productController.createProduct(
          prodNameController.text,
          prodImageController.text,
          int.parse(prodQuantityController.text),
          int.parse(prodUnitPriceController.text),
          int.parse(prodTotalPriceController.text),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          bottomSnackBar(label: 'Sucessfully Created Product!'),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(bottomSnackBar(
            label: 'Failed to create product!', backgroundColor: colorRed));
      }
    }
  }

  @override
  void dispose() {
    prodImageController.dispose();
    prodNameController.dispose();
    prodQuantityController.dispose();
    prodUnitPriceController.dispose();
    prodTotalPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyBackground,
      appBar: AppBar(
        title: const Text('Add Product'),
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
        child: ListView(
          children: [
            const SizedBox(height: 20),
            ProductTextField(
                controller: prodImageController, labelText: 'Product Image'),
            const SizedBox(height: 15),
            ProductTextField(
                controller: prodNameController, labelText: 'Product Name'),
            const SizedBox(height: 15),
            DropdownButtonFormField(
              value: prodQuantityController.text,
              decoration: appInputDecoration(),
              items: const [
                DropdownMenuItem(
                    value: '',
                    child: Text('Product Quantity', style: textStyle)),
                DropdownMenuItem(value: '1', child: Text('1 pcs')),
                DropdownMenuItem(value: '2', child: Text('2 pcs')),
                DropdownMenuItem(value: '3', child: Text('3 pcs')),
                DropdownMenuItem(value: '4', child: Text('4 pcs')),
              ],
              onChanged: (value) {
                prodQuantityController.text = value.toString();
              },
            ),
            const SizedBox(height: 15),
            ProductTextField(
              controller: prodUnitPriceController,
              keyboardType: TextInputType.number,
              labelText: 'Product Unit Price',
            ),
            const SizedBox(height: 15),
            ProductTextField(
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              controller: prodTotalPriceController,
              labelText: 'Product Total Price',
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AppSecondaryButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/homeScreen');
                    },
                    buttonText: 'Cancel',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AppButton(
                    onPressed: () async {
                      await createdProduct(context);
                      Navigator.pushReplacementNamed(context, '/homeScreen');
                    },
                    buttonText: 'Create',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
