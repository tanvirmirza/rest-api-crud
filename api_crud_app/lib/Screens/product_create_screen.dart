import 'package:api_crud_app/RestAPI/rest_api_client.dart';
import 'package:api_crud_app/Widgets/app_button.dart';
import 'package:flutter/material.dart';
import '../Style/style.dart';
import '../Widgets/product_textfield.dart';
import '../Widgets/secondary_button.dart';

class ProductCreateScreen extends StatefulWidget {
  final String? id;
  final String? name;
  final int? qty;
  final String? img;
  final int? unitPrice;
  final int? totalPrice;

  const ProductCreateScreen(
      {this.id,
      this.name,
      this.qty,
      this.img,
      this.unitPrice,
      this.totalPrice,
      super.key});

  @override
  State<ProductCreateScreen> createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  ProductController productController = ProductController();

  TextEditingController prodNameController = TextEditingController();
  TextEditingController prodQuantityController = TextEditingController();
  TextEditingController prodImageController = TextEditingController();
  TextEditingController prodUnitPriceController = TextEditingController();
  TextEditingController prodTotalPriceController = TextEditingController();

  Future<void> createdProduct() async {
    await productController.fetchProducts();
    try {
      if (prodNameController.text.isNotEmpty &&
          prodImageController.text.isNotEmpty &&
          int.tryParse(prodQuantityController.text) != null &&
          int.tryParse(prodUnitPriceController.text) != null &&
          int.tryParse(prodTotalPriceController.text) != null) {
        await productController.createProduct(
          prodNameController.text,
          prodImageController.text,
          int.parse(prodQuantityController.text),
          int.parse(prodUnitPriceController.text),
          int.parse(prodTotalPriceController.text),
        );
      }
    } catch (e) {
      throw Exception('An error occurred while processing the data!');
    }
  }

  @override
  void initState() {
    createdProduct();
    super.initState();
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
        title: const Text('Add Product'),
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
            DropdownButtonFormField(
              
              value: prodQuantityController.text,
              decoration: appInputDecoration(),
              items:  const [
                DropdownMenuItem(
                  value: '',
                  child: Text('Product Quantity', style: textStyle,),
                ),
                DropdownMenuItem(
                  value: '1',
                  child: Text('1 pcs'),
                ),
                DropdownMenuItem(
                  value: '2',
                  child: Text('2 pcs'),
                ),
                DropdownMenuItem(
                  value: '3',
                  child: Text('3 pcs'),
                ),
                DropdownMenuItem(
                  value: '4',
                  child: Text('4 pcs'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  prodQuantityController.text = value.toString();
                });
              },
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
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              controller: prodTotalPriceController,
              labelText: 'Product Total Price'
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
                    await createdProduct();

                    ScaffoldMessenger.of(context).showSnackBar(
                      bottomSnackBar(label: 'Sucessfully Created Product!'),
                    );
                    Navigator.pop(context, true);
                    setState(() {});
                    
                  },
                  buttonText: 'Create',
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
