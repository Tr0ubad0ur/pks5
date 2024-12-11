import 'package:flutter/material.dart';
import 'package:pr3/models/product.dart';
import 'package:pr3/pages/details.dart';

class StoreItem extends StatelessWidget {
  final Product product;
  final int index;
  final Function(int) toggleFavorite;
  final Function(int) removeProduct;
  final Function(int) addToCart;

  const StoreItem({
    super.key,
    required this.product,
    required this.index,
    required this.toggleFavorite,
    required this.removeProduct,
    required this.addToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemPage(
              product: product,
              index: index,
              toggleFavorite: toggleFavorite,
              removeProduct: removeProduct,
              addToCart: addToCart,
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
                    product.title,
                    style: const TextStyle(color: Color.fromRGBO(246, 247, 235, 1), fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Image.asset(
                product.photo,
                height: 160,
                width: 150,
                fit: BoxFit.cover,
              ),

              IconButton(
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: const Color.fromRGBO(161, 13, 1, 1),
                ),
                onPressed: () {
                  toggleFavorite(index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}