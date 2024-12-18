import 'package:flutter/material.dart';
import 'package:pr3/models/product.dart';
import 'package:pr3/api/api.dart';

class CartManager with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final List<Product> _cartProducts = <Product>[];

  List<Product> get cartProducts => _cartProducts;

  Future<void> addToCart(Product product) async {
    if (!_cartProducts.contains(product)) {
      _cartProducts.add(product);
      product.quantity++;
      product.inCart = true;
      await _apiService.updateProductQuantity(
          product.productId, product.quantity);
      await _apiService.toggleCart(product.productId);
      notifyListeners();
    }
  }

  Future<void> removeFromCart(Product product, BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.amberAccent,
          title: const Text('Подтверждение удаления'),
          content: const Text('Вы уверены, что хотите удалить этот товар?'),
          actions: <Widget>[
            TextButton(
              child: const Text(
                  'Отмена', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                  'Удалить', style: TextStyle(color: Colors.black)),
              onPressed: () async {
                _cartProducts.remove(product);
                product.quantity = 0;
                product.inCart = false; // Сбрасываем флаг InCart
                await _apiService.updateProductQuantity(
                    product.productId, product.quantity);
                await _apiService.toggleCart(
                    product.productId); // Обновляем флаг InCart на сервере
                notifyListeners();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );


    bool isInCart(Product product) {
      return _cartProducts.contains(product);
    }
  }

  double getTotalPrice() {
    return _cartProducts.fold(0, (sum, product) {
      return sum + (product.productPrice * product.quantity);
    });
  }

  void updateQuantity(Product product, int newQuantity) {
    final index = _cartProducts.indexWhere((p) =>
    p.productId == product.productId);
    if (index != -1) {
      _cartProducts[index].quantity = newQuantity;
      notifyListeners();
    }
  }
}