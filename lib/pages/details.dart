import 'package:flutter/material.dart';
import 'package:pr3/models/product.dart';

class ItemPage extends StatefulWidget {
  final Product product;
  final int index;
  final Function(int) toggleFavorite;
  final Function(int) addToCart;
  final Function(int) removeProduct;

  const ItemPage({
    super.key,
    required this.product,
    required this.index,
    required this.toggleFavorite,
    required this.addToCart,
    required this.removeProduct,
  });

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.product.isFavorite;
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromRGBO(161, 13, 1, 1),
          title: const Text('Подтверждение удаления'),
          content: const Text('Вы уверены, что хотите удалить этот товар?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Отмена', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Удалить', style: TextStyle(color: Colors.black)),
              onPressed: () {
                widget.removeProduct(widget.index);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      widget.toggleFavorite(widget.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 28,
        ),
        backgroundColor: const Color.fromRGBO(161, 13, 1, 1),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
            onPressed: _toggleFavorite,
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: Colors.white,
            onPressed: () {
              widget.addToCart(widget.index);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Товар добавлен в корзину'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(
                widget.product.photo,
                height: 300,
                width: 300,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Text(
                widget.product.title,
                style: const TextStyle(color: Colors.black87, fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                '${widget.product.price}₽',
                style: const TextStyle(color: Colors.black87, fontSize: 20),
              ),
              const SizedBox(height: 16),
              Text(
                widget.product.description,
                style: const TextStyle(color: Colors.black87, fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _showDeleteConfirmationDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(161, 13, 1, 1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  minimumSize: const Size(300, 50),
                ),
                child: const Text(
                  "Удалить товар",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}