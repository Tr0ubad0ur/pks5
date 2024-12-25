import 'package:flutter/material.dart';
import 'package:pr3/models/product.dart';
import 'package:pr3/api/api.dart';

class FavoriteManager with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final List<Product> _favProducts = <Product>[];

  List<Product> get favProducts => _favProducts;

  Future<void> addToFavorite(Product product) async {
    if (!_favProducts.contains(product)) {
      _favProducts.add(product);
      await _apiService.toggleFavorite(product.productId);
      notifyListeners();
    }
  }

  Future<void> removeFromFavorite(Product product) async {
    _favProducts.remove(product);
    await _apiService.toggleFavorite(product.productId);
    notifyListeners();
  }

  bool isFavorite(Product product) {
    return _favProducts.contains(product);
  }
}