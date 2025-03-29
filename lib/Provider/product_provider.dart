import 'dart:convert';
import 'package:flutter/material.dart';
import '../Model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier {
  List<Data> _products = [];

  static String baseUrl = 'http://35.73.30.144:2008/api/v1';
  static String readUrl = '$baseUrl/ReadProduct';
  static String createUrl = '$baseUrl/CreateProduct';
  static String deleteUrl(String id) => '$baseUrl/DeleteProduct/$id';
  static String updateUrl(String id) => '$baseUrl/UpdateProduct/$id';
  bool _isLoading = false;
  bool _hasError = false;

  List<Data> get products => _products;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _hasError = false;
    try {
      final response = await http.get(Uri.parse(readUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        ProductModel model = ProductModel.fromJson(data);
        _products = model.data ?? [];
      } else {
        _hasError = true;
      }
    } catch (e) {
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createProduct(
      String name, String img, int qty, int price, int totalPrice) async {
    _isLoading = true;
    notifyListeners();

    try {
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
        await fetchProducts();
      }
    } catch (e) {
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProduct(String id, String name, String img, int qty,
      int price, int totalPrice) async {
    _isLoading = true;
    notifyListeners();

    try {
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

      if (response.statusCode == 201) {
        await fetchProducts();
      }
    } catch (e) {
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteProduct(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(deleteUrl(id)));

      if (response.statusCode == 200) {
        await fetchProducts();
        return true;
      } else {
        _hasError = true;
        return false;
      }
    } catch (e) {
      _hasError = true;
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateState() {
    notifyListeners();
  }
}
