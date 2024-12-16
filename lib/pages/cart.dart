import 'package:flutter/material.dart';
import 'package:pr3/components/cart_product.dart';
import 'package:pr3/models/cartManager.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatefulWidget {

  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {

  @override
  Widget build(BuildContext context) {
    final cartManager = Provider.of<CartManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Корзина",
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
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index){
          return CartProduct(product: cartManager.cartProducts[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: cartManager.cartProducts.length,
      ),
    );
  }
}