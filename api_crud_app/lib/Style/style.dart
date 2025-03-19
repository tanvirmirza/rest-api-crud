import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

const colorRed = Color.fromRGBO(231, 28, 36, 1);
const colorGreen = Color.fromRGBO(33, 191, 115, 1);
const colorWhite = Color.fromRGBO(255, 255, 255, 1);
const colorDarkBlue = Color.fromRGBO(44, 62, 80, 1);
const colorGrey = Color.fromRGBO(117, 117, 117, 1);

const bodyBackground = Color.fromRGBO(240, 240, 240, 1);
const bodyText = Color.fromRGBO(97, 97, 97, 1);

const appPrimaryForeground = Color.fromRGBO(218, 220, 222, 1);
const appPrimaryBackground = Color.fromRGBO(45, 99, 143, 1);
const TextStyle textStyle = TextStyle(
    color: Color.fromRGBO(66, 66, 66, 1), fontWeight: FontWeight.w400);

const backNavigat = Icon(Icons.navigate_before);
const shopCart = Icon(Icons.shopping_cart_outlined);
const String bannerImage =
    'https://media.istockphoto.com/id/1974337259/vector/spring-sale-commercial-background-for-springtime-seasonal-sale-business-shopping-promotion.webp?b=1&s=612x612&w=0&k=20&c=qfajwJNtIT_pmBzYUwcJIRnynHnOJkntP3QNgqYt9Mg=';

const String description =
    'The length of Lorem Ipsum used for product descriptions depends on the size of the description needed. For smaller products, a few paragraphs of placeholder text may be sufficient. For larger product descriptions, you might need longer blocks of Lorem Ipsum to ensure the design accommodates the required amount of content. The key is to match the placeholder text length to the amount of text you anticipate for the final product description.';

BoxDecoration discountBoxDecoration() {
  return BoxDecoration(
      color: Colors.yellow.shade700,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(6), bottomLeft: Radius.circular(6)));
}

InputDecoration appInputDecoration({label}) {
  return InputDecoration(
    floatingLabelStyle: const TextStyle(color: appPrimaryBackground),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: appPrimaryForeground,
        width: 1,
      ),
    ),
    fillColor: colorWhite,
    filled: true,
    contentPadding: const EdgeInsets.fromLTRB(20, 10, 10, 20),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: colorWhite, width: 0),
    ),
    border: const OutlineInputBorder(),
    labelText: label,
  );
}

BoxDecoration bannerImageDecoration() {
  return BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 7,
        offset: const Offset(0, 3),
      ),
    ],
  );
}

DecoratedBox appDropDownStyle({child}) {
  return DecoratedBox(
    decoration: BoxDecoration(
      color: colorWhite,
      border: Border.all(color: colorWhite, width: 1),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: child,
    ),
  );
}

SliverGridDelegateWithFixedCrossAxisCount productGridViewStyle() {
  return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisExtent: 250,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 0.8);
}

Widget buildShimmerEffect() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: GridView.builder(
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.8),
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

SnackBar bottomSnackBar({label, backgroundColor = colorGreen}) {
  return SnackBar(
    content: Text(
      label,
      style: const TextStyle(color: colorWhite, fontSize: 16),
    ),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    margin: const EdgeInsets.all(16),
    duration: const Duration(seconds: 3),
  );
}
