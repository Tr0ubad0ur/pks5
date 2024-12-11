import 'package:flutter/material.dart';
import 'package:pr3/models/product.dart';
import 'package:pr3/pages/details.dart';

class FavouritePage extends StatefulWidget {
  final List<Product> favoriteEntries;
  final Function(int) removeFromFavorites;
  final Function(int) toggleFavorite;
  final Function(int) removeProduct;
  final Function(int) addToCart;

  const FavouritePage({
    super.key,
    required this.favoriteEntries,
    required this.removeFromFavorites,
    required this.toggleFavorite,
    required this.removeProduct,
    required this.addToCart,
  });

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Избранное',
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
        ),
        backgroundColor: const Color.fromRGBO(161, 13, 1, 1),
      ),
      backgroundColor:  Colors.white,
      body: widget.favoriteEntries.isEmpty
          ? const Center(
        child: Text(
          "Нет избранных инструментов",
          style: TextStyle(color: Color.fromRGBO(161, 13, 1, 1), fontSize: 18),
        ),
      )
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.62,
        ),
        itemCount: widget.favoriteEntries.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemPage(
                    product: widget.favoriteEntries[index],
                    index: index,
                    toggleFavorite: widget.toggleFavorite,
                    removeProduct: widget.removeProduct,
                    addToCart: widget.addToCart,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: const Color.fromRGBO(34, 34, 36, 1),
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          widget.favoriteEntries[index].title,
                          style: const TextStyle(color: Color.fromRGBO(246, 247, 235, 1), fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Image.asset(
                      widget.favoriteEntries[index].photo,
                      height: 160,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite),
                      color: const Color.fromRGBO(161, 13, 1, 1),
                      onPressed: () {
                        widget.removeFromFavorites(index);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}