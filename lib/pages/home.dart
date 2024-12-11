import 'package:flutter/material.dart';
import 'package:pr3/components/product_component.dart';
import 'package:pr3/models/product.dart';
import 'package:pr3/pages/addProductPage.dart';
import 'package:pr3/data/data.dart';

final List<Product> products = <Product>[];

class HomePage extends StatefulWidget {
  final Function(int) removeProduct;
  final Function(int) toggleFavorite;
  final Function(int) addToCart;

  const HomePage({
    super.key,
    required this.removeProduct,
    required this.toggleFavorite,
    required this.addToCart,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void navigateToAddProductPage(BuildContext context) async {
    final Product result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddProductPage()),
    );

    if (result != null) {
      setState(() {
        entries.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Troubadour`s',
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
        ),
        backgroundColor: const Color.fromRGBO(161, 13, 1, 1),
      ),
      backgroundColor: Colors.white,
      body: entries.isEmpty
          ? const Center(
        child: Text(
          "Нет добавленных товаров",
          style: TextStyle(color: Color.fromRGBO(161, 13, 1, 1), fontSize: 18),
        ),
      )
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.62,
        ),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return StoreItem(
            product: entries[index],
            index: index,
            toggleFavorite: widget.toggleFavorite,
            removeProduct: widget.removeProduct,
            addToCart: widget.addToCart,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(161, 13, 1, 1),
        onPressed: () => navigateToAddProductPage(context),
        tooltip: "Добавить товар",
        child: const Icon(Icons.add_box_sharp),
      ),
    );
  }
}