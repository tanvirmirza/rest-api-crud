import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../RestAPI/product_model.dart';
import '../Style/style.dart';

class ProductCard extends StatelessWidget {
  final Data data;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const ProductCard(
      {
      required this.data,
      required this.onTap,
      required this.onEdit,
      required this.onDelete,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              color: colorWhite,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.network(
                    data.img.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.productName.toString(),
                        style: GoogleFonts.lexend(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: colorGrey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '৳${data.unitPrice.toString()}',
                            style: GoogleFonts.lexend(
                                fontSize: 18,
                                color: bodyText,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          PopupMenuButton(
                              tooltip: '',
                              icon: const Icon(
                                Icons.more_vert,
                                color: colorGrey,
                              ),
                              color: appPrimaryBackground,
                              itemBuilder: (context) => [
                                    PopupMenuItem(
                                      onTap: onEdit,
                                      child: const Text('Edit',
                                          style: TextStyle(
                                            color: appPrimaryForeground,
                                          )),
                                    ),
                                    PopupMenuItem(
                                      onTap: onDelete,
                                      child: const Text('Delete',
                                          style: TextStyle(
                                            color: appPrimaryForeground,
                                          )),
                                    ),
                                  ]),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
