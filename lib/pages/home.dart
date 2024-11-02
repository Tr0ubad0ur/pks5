import 'package:pr3/data/data.dart';
import 'package:flutter/material.dart';
import 'package:pr3/components/product_component.dart';
import 'package:pr3/models/product.dart';
import 'package:pr3/pages/addProductPage.dart';


final List<Product> products = <Product>[];

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  void navigateToAddProductPage(BuildContext context) async{
    final Product result = await Navigator.push(context,
      MaterialPageRoute(builder: (context) => const AddProductPage()),
    );

    if (result != null){
      setState(() {
        products.add(result);
      });
    }
  }

  void removeProduct(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromRGBO(102, 155, 188, 1),
          title: const Text('Подтверждение удаления'),
          content: const Text('Вы уверены, что хотите удалить этот интсрумент?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Отмена',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Удалить',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                setState(() {
                  products.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


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
      body: products.isEmpty
          ? const Center(child: Text("Нет добавленных инструментов", style: TextStyle(color: Color.fromRGBO(102, 155, 188, 1), fontSize: 18),),)
          : ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index){
            return ProductComponent(product: products[index], index: index, removeProduct: removeProduct,);
          }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(233, 79, 55, 1),
        onPressed: () => navigateToAddProductPage(context),
        child: Icon(Icons.add_box_sharp),
        tooltip: "Добавить инструмент",
      ),
    );
  }
}