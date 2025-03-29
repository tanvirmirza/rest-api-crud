import 'package:flutter/material.dart';
import '../Model/product_model.dart';

class CartProvider with ChangeNotifier {
  final Map<String, Data> _cartItems = {};

  Map<String, Data> get cartItems => _cartItems;

  void addToCart(Data product) {
    if (_cartItems.containsKey(product.sId)) {
      _cartItems.update(product.sId!, (existingProduct) {
        return Data(
          sId: existingProduct.sId,
          productName: existingProduct.productName,
          img: existingProduct.img,
          qty: existingProduct.qty! + 1,
          unitPrice: existingProduct.unitPrice,
        );
      });
    } else {
      _cartItems[product.sId!] = product;
    }
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  double get totalAmount {

    return _cartItems.values
        .fold(0, (sum, item) => sum + (item.unitPrice ?? 0));
  }
}
