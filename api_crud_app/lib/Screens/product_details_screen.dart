import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Provider/product_cart_provider.dart';
import '../Model/product_model.dart';
import '../Style/style.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Data product;
  final int index;

  const ProductDetailsScreen({
    required this.product,
    required this.index,
    super.key,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  Data get product => widget.product;
  int get index => widget.index;

  late double regularPrice;
  int discount = 10;

  @override
  void initState() {
    regularPrice = (product.unitPrice! + (discount * product.unitPrice! / 100))
        .roundToDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bodyBackground,
        appBar: AppBar(
          leading: IconButton(
            icon: backNavigat,
            iconSize: 35,
            color: colorGrey,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/homeScreen');
            },
          ),
          backgroundColor: bodyBackground,
          elevation: 0,
          forceMaterialTransparency: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              color: colorGrey,
              onPressed: () {},
            ),
            IconButton(
              icon: shopCart,
              color: colorGrey,
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/cartScreen');
              },
            ),
          ],
        ),
        body: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        product.img.toString(),
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      (product.productName.toString()),
                      style: GoogleFonts.lexend(
                          fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (product.qty != 0)
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 24,
                            width: 70,
                            decoration: discountBoxDecoration(),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                    text: '$discount%',
                                    style: GoogleFonts.lexend(
                                      color: colorWhite,
                                      fontSize: 18,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: ' OFF',
                                        style: GoogleFonts.lexend(
                                          color: colorWhite,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '৳${NumberFormat.decimalPattern().format(regularPrice)}',
                            style: GoogleFonts.lexend(
                                fontSize: 21,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700,
                                decorationColor: Colors.grey.shade900,
                                wordSpacing: 15,
                                decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '৳${NumberFormat.decimalPattern().format(product.unitPrice)}',
                            style: GoogleFonts.lexend(
                              fontSize: 23,
                              fontWeight: FontWeight.w600,
                              wordSpacing: 15,
                            ),
                          )
                        ],
                      )
                    else
                      Text(
                        '৳${NumberFormat.decimalPattern().format(product.unitPrice)}',
                        style: GoogleFonts.lexend(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                          wordSpacing: 15,
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (product.qty != 0)
                      Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: colorGreen,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'In Stock',
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: colorGreen),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '(available ${product.qty} pcs)',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      )
                    else
                      Text(
                        'Out Of Stock',
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: colorRed),
                      ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (product.qty == 0)
                    const SizedBox(height: 0,)
                    else
                    GestureDetector(
                      onTap: () {
                        cartProvider.addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                            bottomSnackBar(label: 'Added to Cart'));
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: appPrimaryBackground,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Add to Cart',
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: colorWhite),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const Icon(
                              Icons.add_shopping_cart,
                              color: colorWhite,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Text(
                      'Description',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      description,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
