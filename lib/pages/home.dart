import 'package:pr3/data/data.dart';
import 'package:flutter/material.dart';
import 'package:pr3/components/product_component.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF800000),
        title: const Center(
            child: Text('Troubadour`s')
        ),
        titleTextStyle: const TextStyle(
          fontSize: 24,
          color: Color(0xFFFFFFFF),
        ),
      ),
      body: Container(
        color: const Color(0xFF1A1A1D), //фон для всей страницы
        child: ListView.builder(
          itemCount: dataProducts.length,
          itemBuilder: (BuildContext context, int index) {
            return ProductComponent(product: dataProducts[index]);
          },
        ),
      ),
    );
  }
}