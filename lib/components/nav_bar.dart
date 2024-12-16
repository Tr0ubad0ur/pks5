import 'package:flutter/material.dart';
import 'package:pr3/models/product.dart';
import 'package:pr3/pages/favorites.dart';
import 'package:pr3/pages/home.dart';
import 'package:pr3/pages/profile.dart';
import 'package:pr3/pages/cart.dart';
import 'package:pr3/models/cartManager.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class BNavBar extends StatefulWidget {
  const BNavBar({super.key});

  @override
  State<BNavBar> createState() => _BNavBarState();
}

class _BNavBarState extends State<BNavBar> {

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    FavPage(),
    ShoppingCart(),
    Profile(),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartManager = Provider.of<CartManager>(context);
    return Scaffold(
      body:
      _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Главная",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: "Избранное",
          ),
          BottomNavigationBarItem(
            icon: badges.Badge(
                badgeContent: Text(
                  "${cartManager.cartProducts.length}",
                ),
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: const Color.fromRGBO(161, 13, 1, 1),
                ),
                child: const Icon(Icons.shopping_cart_outlined)
            ),
            label: "Корзина",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: "Личный кабинет",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(161, 13, 1, 1),
        unselectedItemColor: const Color.fromARGB(100, 128, 128, 128),
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}