import 'package:api_crud_app/Provider/product_provider.dart';
import 'package:api_crud_app/Widgets/product_card.dart';
import 'package:api_crud_app/Widgets/secondary_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Style/style.dart';
import '../Widgets/app_button.dart';
import 'product_details_screen.dart';
import 'product_update_screen.dart';

class ProductHomeScreen extends StatefulWidget {
  const ProductHomeScreen({super.key});

  @override
  State<ProductHomeScreen> createState() => _ProductHomeScreenState();
}

class _ProductHomeScreenState extends State<ProductHomeScreen> {
  Future<void> fetchData() async {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    await provider.fetchProducts();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
      return Scaffold(
          backgroundColor: bodyBackground,
          appBar: AppBar(
            backgroundColor: appPrimaryBackground,
            forceMaterialTransparency: false,
            elevation: 0,
            centerTitle: false,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/tech_mart.png',
                  color: appPrimaryForeground,
                  width: 90,
                ),
                Text(
                  'TechMart',
                  style: GoogleFonts.baumans(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: appPrimaryForeground),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: shopCart,
                color: appPrimaryForeground,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/cartScreen');
                },
              ),
              IconButton(
                icon: const Icon(Icons.notifications_none_rounded),
                color: appPrimaryForeground,
                onPressed: () {},
              )
            ],
          ),
          body: (productProvider.isLoading)
              ? buildShimmerEffect()
              : (productProvider.hasError)
                  ? buildErrorWidget(productProvider)
                  : buildProductView(productProvider),
          floatingActionButton: (productProvider.isLoading)
              ? null
              : (productProvider.hasError)
                  ? null
                  : FloatingActionButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/createScreen')
                            .then((value) {
                          if (value == true) {
                            fetchData();
                          }
                        });
                      },
                      foregroundColor: appPrimaryForeground,
                      backgroundColor: appPrimaryBackground,
                      child: const Icon(Icons.add),
                    ));
    });
  }

  Widget buildProductView(ProductProvider productProvider) {
    return RefreshIndicator(
      onRefresh: () async {
        await fetchData();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: colorWhite, borderRadius: BorderRadius.circular(12)),
              child: const TextField(
                decoration: InputDecoration(
                  enabled: false,
                  prefixIcon: Icon(Icons.search, color: colorGrey),
                  suffixIcon: Icon(Icons.mic, color: colorGrey),
                  border: InputBorder.none,
                  hintText: 'Search products..',
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: bannerImageDecoration(),
                        child: Image.network(
                          bannerImage.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.more_horiz_outlined,
                      size: 40,
                      color: colorGrey,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: productProvider.products.length,
                      gridDelegate: productGridViewStyle(),
                      itemBuilder: (context, index) {
                        var product = productProvider.products[index];
                        return ProductCard(
                          data: product,
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetailsScreen(
                                          product: product,
                                          index: index,
                                        )));
                          },
                          onEdit: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductUpdateScreen(
                                  data: product,
                                ),
                              ),
                            ).then((value) {
                              if (value == true) fetchData();
                            });
                          },
                          onDelete: () {
                            showDialog(
                                context: context,
                                builder: (context) => deleteDialog(
                                    product, context, productProvider));
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(
      product, BuildContext context, ProductProvider productProvider) {
    return AlertDialog(
      title: const Text('Warning!'),
      content: const Text('Are you sure want to delete?'),
      actions: [
        AppButton(
          onPressed: () {
            Navigator.pop(context);
          },
          buttonText: 'No',
        ),
        AppSecondaryButton(
          onPressed: () {
            productProvider.deleteProduct(product.sId.toString());

            ScaffoldMessenger.of(context).showSnackBar(
              bottomSnackBar(
                  label: 'Product has been deleted!',
                  backgroundColor: colorRed),
            );
            Navigator.pop(context);
          },
          buttonText: "Yes",
        ),
      ],
    );
  }

  Widget buildErrorWidget(ProductProvider productProvider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 80, color: colorRed),
          const SizedBox(height: 10),
          const Text("Failed to load data!", style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          AppButton(
              onPressed: () async {
                await Future.delayed(const Duration(seconds: 3));
                await fetchData();
              },
              buttonText: "Retry"),
        ],
      ),
    );
  }
}
