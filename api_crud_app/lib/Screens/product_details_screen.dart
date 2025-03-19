import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Style/style.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String netImg;
  final String prodName;
  final int prodQty;
  final int prodPrice;

  const ProductDetailsScreen(
      {required this.netImg,
      required this.prodName,
      required this.prodQty,
      required this.prodPrice,
      super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String get netImg => widget.netImg;
  String get prodName => widget.prodName;
  int get prodQty => widget.prodQty;
  int get prodPrice => widget.prodPrice;

  late double regularPrice;
  int discount = 10;

  @override
  void initState() {
    regularPrice = (prodPrice + (discount * prodPrice / 100)).roundToDouble();
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
            Navigator.pop(context);
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
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  netImg,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                ('$prodName '),
                style: GoogleFonts.lexend(
                    fontSize: 30, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
             if (prodQty != 0) Row(
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
                    '৳${regularPrice.toString()}',
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
                    '৳$prodPrice',
                    style: GoogleFonts.lexend(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      wordSpacing: 15,
                    ),
                  )
                ],
              ) else Text(
                    '৳$prodPrice',
                    style: GoogleFonts.lexend(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      wordSpacing: 15,
                    ),
                  ),
              const SizedBox(
                height: 10,
              ),
              if (prodQty != 0) Row(
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
                          '(available $prodQty pcs)',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ) else Text(
                      'Out Of Stock',
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: colorRed),
                    ),
              const SizedBox(
                height: 20,
              ),
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
      ),
    );
  }
}
