import 'package:flutter/material.dart';
import 'package:pr3/api/api.dart';
import 'package:pr3/models/product.dart';
import 'package:pr3/models/productManager.dart';
import 'package:pr3/pages/details.dart';
import 'package:pr3/models/favoriteManager.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatefulWidget {
  final Product product;
  final int index;

  const ProductItem({super.key, required this.product, required this.index});

  @override
  _ProductItemState createState() => _ProductItemState(product: product);
}

class _ProductItemState extends State<ProductItem> {
  final Product product;
  _ProductItemState({required this.product}) : super();

  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    _products = ApiService().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteManager = Provider.of<FavoriteManager>(context);

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductPage(product: widget.product)),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color.fromARGB(45, 237, 231, 246),
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(
                        widget.product.productImage,
                        height: 180,
                        width: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Center(
                    child: Text(
                      widget.product.productName,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Center(
                    child: Text(
                      '${widget.product.productPrice}₽',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(
                    favoriteManager.isFavorite(product) ? Icons.favorite : Icons.favorite_border,
                    color: favoriteManager.isFavorite(product) ? const Color.fromRGBO(161, 13, 1, 1) : Colors.grey,
                  ),
                  onPressed: () {
                    if (favoriteManager.isFavorite(product)) {
                      favoriteManager.removeFromFavorite(product);
                    } else {
                      favoriteManager.addToFavorite(product);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}