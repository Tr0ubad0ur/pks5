import 'package:flutter/material.dart';
import '../models/product.dart';

class Details extends StatelessWidget {
  final Product product;

  const Details({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF800000),
        titleTextStyle: const TextStyle(fontSize: 24, color: Color(0xFFFFFFFF)),
        title: const Center(child: Text('Troubadour`s')),
      ),
      body: Container(
        color: const Color(0xFF1A1A1D), //фон для всей страницы
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white), // Белый цвет текста
                ),
                Text(
                  product.description,
                  style: const TextStyle(fontSize: 16, color: Colors.white), // Белый цвет текста
                ),
                const SizedBox(height: 20),
                Center(
                  child: Image(
                    image: AssetImage(product.photo),
                    width: MediaQuery.of(context).size.width * 0.9,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(1),
                      margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                      width: MediaQuery.of(context).size.height * 0.1,
                      height: MediaQuery.of(context).size.height * 0.045,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1D),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        "${product.price} р",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(1),
                      margin: const EdgeInsets.only(right: 10, top: 10, bottom: 9),
                      height: MediaQuery.of(context).size.height * 0.05,
                      alignment: Alignment.center,
                      child: Text(
                        "В корзину!1",
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}