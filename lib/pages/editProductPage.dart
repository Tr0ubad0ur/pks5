import 'package:flutter/material.dart';
import 'package:pr3/models/product.dart';
import 'package:provider/provider.dart';
import 'package:pr3/models/productManager.dart';

class EditProductPage extends StatefulWidget {
  final Product product;

  const EditProductPage({super.key, required this.product});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final TextEditingController productTitleController = TextEditingController();
  final TextEditingController productImageController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productAboutController = TextEditingController();
  final TextEditingController productSpecificationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    productTitleController.text = widget.product.productTitle;
    productImageController.text = widget.product.productImage;
    productPriceController.text = widget.product.productPrice.toString();
    productAboutController.text = widget.product.productAbout;
    productSpecificationController.text = widget.product.productSpecifications;
  }

  @override
  void dispose() {
    productTitleController.dispose();
    productImageController.dispose();
    productPriceController.dispose();
    productAboutController.dispose();
    productSpecificationController.dispose();
    super.dispose();
  }

  Future<void> _updateProduct(BuildContext context) async {
    final productTitle = productTitleController.text;
    final productImage = productImageController.text;
    final productPrice = int.tryParse(productPriceController.text) ?? 0;
    final productAbout = productAboutController.text;
    final productSpecifications = productSpecificationController.text;

    if (productTitle.isNotEmpty && productImage.isNotEmpty && productPrice > 0 && productAbout.isNotEmpty && productSpecifications.isNotEmpty) {
      final updatedProduct = Product(
        productId: widget.product.productId,
        productTitle: productTitle,
        productImage: productImage,
        productName: productTitle,
        productPrice: productPrice,
        productAbout: productAbout,
        productSpecifications: productSpecifications,
      );

      final productManager = Provider.of<ProductManager>(context, listen: false);
      await productManager.updateProduct(widget.product.productId, updatedProduct);

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Пожалуйста, заполните все поля корректно.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Редактирование товара"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: productTitleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: "Введите название товара",
                  labelText: "Название",
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: productImageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: "Введите ссылку на изображение",
                  labelText: "Ссылка",
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: productPriceController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: "Введите стоимость товара",
                  labelText: "Стоимость",
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: productAboutController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: "Введите описание товара",
                  labelText: "Описание",
                ),
                maxLines: 7,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: productSpecificationController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: "Введите характеристики товара",
                  labelText: "Характеристики",
                ),
                maxLines: 7,
              ),
              const SizedBox(height: 16),


              ElevatedButton(
                onPressed: () => _updateProduct(context),
                child: const Text("Сохранить изменения",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(161, 13, 1, 1),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  minimumSize: const Size(300, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}