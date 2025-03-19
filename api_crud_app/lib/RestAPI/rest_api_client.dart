import 'dart:convert';
import 'package:http/http.dart' as http;
import 'product_model.dart';

class ProductController {
  late List products = [];
  static String baseUrl = 'http://35.73.30.144:2008/api/v1';
  static String readUrl = '$baseUrl/ReadProduct';
  static String createUrl = '$baseUrl/CreateProduct';
  static String deleteUrl(String id) => '$baseUrl/DeleteProduct/$id';
  static String updateUrl(String id) => '$baseUrl/UpdateProduct/$id';

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse(readUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      ProductModel model = ProductModel.fromJson(data);
      products = model.data ?? [];
    }
  }

  Future<void> createProduct(
      String name, String img, int qty, int price, int totalPrice) async {
    final response = await http.post(Uri.parse(createUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "ProductName": name,
          "ProductCode": DateTime.now().microsecondsSinceEpoch,
          "Img": img,
          "Qty": qty,
          "UnitPrice": price,
          "TotalPrice": totalPrice
        }));

    if (response.statusCode == 201) {
      fetchProducts();
    }
  }

  Future<void> updateProduct(String id, String name, String img, int qty,
      int price, int totalPrice) async {
    final response = await http.post(Uri.parse(updateUrl(id)),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "ProductName": name,
          "ProductCode": DateTime.now().microsecondsSinceEpoch,
          "Img": img,
          "Qty": qty,
          "UnitPrice": price,
          "TotalPrice": totalPrice
        }));

    print(response);
    if (response.statusCode == 201) {
      fetchProducts();
    }
  }

  Future<bool> deleteProducts(String id) async {
    final response = await http.get(Uri.parse(deleteUrl(id)));

    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
