import 'package:flutter/material.dart';
import 'package:pr3/models/product.dart';
import 'package:pr3/pages/home.dart';
import 'package:pr3/pages/favorites.dart';
import 'package:pr3/pages/profile.dart';
import 'package:pr3/pages/cart.dart';
import 'package:pr3/data/data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Troubadour`s',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List<Product> favoriteEntries = [];
  List<Product> cartEntries = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void removeFromFavorites(int index) {
    setState(() {
      favoriteEntries.removeAt(index);
    });
  }

  void toggleFavorite(int index) {
    setState(() {
      Product product = entries[index];
      product.isFavorite = !product.isFavorite;
      if (favoriteEntries.contains(product)) {
        favoriteEntries.remove(product);
      } else {
        favoriteEntries.add(product);
      }
    });
  }

  void removeProduct(int index) {
    setState(() {
      entries.removeAt(index);
    });
  }

  void addToCart(int index) {
    setState(() {
      Product product = entries[index];
      if (cartEntries.contains(product)) {
        product.quantity++;
      } else {
        product.quantity = 1;
        cartEntries.add(product);
      }
    });
  }

  void removeFromCart(int index) {
    setState(() {
      cartEntries.removeAt(index);
    });
  }

  void updateQuantity(int index, int quantity) {
    setState(() {
      cartEntries[index].quantity = quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      HomePage(
        removeProduct: removeProduct,
        toggleFavorite: toggleFavorite,
        addToCart: addToCart,
      ),
      FavouritePage(
        favoriteEntries: favoriteEntries,
        removeFromFavorites: removeFromFavorites,
        toggleFavorite: toggleFavorite,
        removeProduct: removeProduct,
        addToCart: addToCart,
      ),
      CartPage(
        cartEntries: cartEntries,
        removeFromCart: removeFromCart,
        updateQuantity: updateQuantity,
      ),
      ProfilePage(),
    ];

    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Color.fromRGBO(161, 13, 1, 1),
            unselectedItemColor: Colors.grey,
            backgroundColor: Color.fromRGBO(34, 34, 36, 1),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Главная',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              activeIcon: Icon(Icons.favorite),
              label: 'Избранное',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              activeIcon: Icon(Icons.shopping_cart),
              label: 'Корзина',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Профиль',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}