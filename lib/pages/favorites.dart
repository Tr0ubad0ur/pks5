import 'package:flutter/material.dart';
import 'package:pr3/models/favoriteManager.dart';
import 'package:provider/provider.dart';
import 'package:pr3/components/product_component.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {

  @override
  Widget build(BuildContext context) {
    final favoriteManager = Provider.of<FavoriteManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Избранное",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
              fontSize: 30,
                color: Colors.white
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(161, 13, 1, 1),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 2.0,
          childAspectRatio: 0.76,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ProductItem(product: favoriteManager.favProducts[index], index: index,);
        },
        itemCount: favoriteManager.favProducts.length,
      ),
    );
  }
}