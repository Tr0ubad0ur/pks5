import 'package:flutter/material.dart';
import 'package:pr3/models/product.dart';

class FavoriteManager with ChangeNotifier{
  final List<Product> _favProducts = <Product>[];

  List<Product> get favProducts => _favProducts;

  void addToFavorite(Product product){
    if (!_favProducts.contains(product)){
      _favProducts.add(product);
      notifyListeners();
    }
  }

  void removeFromFavorite(Product product){
    _favProducts.remove(product);
    notifyListeners();
  }

  bool isFavorite(Product product){
    return _favProducts.contains(product);
  }
}