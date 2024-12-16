import 'package:flutter/material.dart';
import 'package:pr3/models/product.dart';
import 'package:pr3/models/favoriteManager.dart';
import 'package:provider/provider.dart';
import 'package:pr3/models/cartManager.dart';
import 'package:badges/badges.dart' as badges;
import 'package:pr3/models/productManager.dart';
import 'package:pr3/pages/editProductPage.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    final favoriteManager = Provider.of<FavoriteManager>(context);
    final cartManager = Provider.of<CartManager>(context);
    final productManager = Provider.of<ProductManager>(context);

    return Scaffold(
      backgroundColor: Colors.white, // Фон всего экрана
      appBar: AppBar(
        title: Text(widget.product.productTitle),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              favoriteManager.isFavorite(widget.product) ? Icons.favorite : Icons.favorite_border,
              color: favoriteManager.isFavorite(widget.product) ? const Color.fromRGBO(161, 13, 1, 1) : Colors.black,
            ),
            onPressed: () {
              if (favoriteManager.isFavorite(widget.product)) {
                favoriteManager.removeFromFavorite(widget.product);
              } else {
                favoriteManager.addToFavorite(widget.product);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              await productManager.removeProduct(widget.product.productId);
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProductPage(product: widget.product),
                ),
              );
            },
          ),
        ],
        backgroundColor: const Color.fromRGBO(161, 13, 1, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              widget.product.productImage,
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 1,
              fit: BoxFit.fill,
            ),
            Center(
              child: Text(
                widget.product.productName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                '${widget.product.productPrice}₽',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "Описание:\n",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: widget.product.productAbout,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "Характеристики:\n",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: widget.product.productSpecifications,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white, // Фон нижней панели
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end, // Выравнивание по правому краю
            children: [
              ElevatedButton(
                onPressed: () {
                  cartManager.addToCart(widget.product);
                },
                child: const Text("В корзину"),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(14)),
                  backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(161, 13, 1, 1)),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(
                      fontSize: 23,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16), // Отступ справа (если нужно)
            ],
          ),
        ),
      ),
    );
  }
}