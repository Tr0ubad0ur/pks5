import 'package:flutter/material.dart';
import '../models/product.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});



  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController photoController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void createProduct() {
    int id = int.tryParse(idController.text) ?? 0;
    String title = titleController.text;
    String photo = photoController.text;
    int price = int.tryParse(priceController.text) ?? 0;
    String description = descriptionController.text;

    if (title.isNotEmpty && photo.isNotEmpty && price > 0 && id > 0 &&
        description.isNotEmpty){
      Product product = Product(
        id: id,
        title: title,
        photo: photo,
        description: description,
        price: price,
      );
      Navigator.pop(context, product);
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    photoController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Добавление инструмента", style: TextStyle(color: Color.fromRGBO(102, 155, 188, 0.7), fontSize: 24),),
        backgroundColor: const Color.fromRGBO(57, 62, 65, 1),
      ),
      backgroundColor: const Color.fromRGBO(57, 62, 65, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: idController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: "Введите id",
                  hintStyle: const TextStyle(color: Color.fromRGBO(102, 155, 188, 0.7)),
                  labelText: "id",
                  labelStyle: const TextStyle(color: Color.fromRGBO(102, 155, 188, 1)),
                ),
                maxLines: 1,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: "Введите название инструмента",
                  hintStyle: const TextStyle(color: Color.fromRGBO(102, 155, 188, 0.7)),
                  labelText: "Инструмент",
                  labelStyle: const TextStyle(color: Color.fromRGBO(102, 155, 188, 1)),
                ),
                maxLines: 1,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: photoController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: "Введите ссылку на фото",
                  hintStyle: const TextStyle(color: Color.fromRGBO(102, 155, 188, 0.7)),
                  labelText: "Фото",
                  labelStyle: const TextStyle(color: Color.fromRGBO(102, 155, 188, 1)),
                ),
                maxLines: 1,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: priceController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: "Введите стоимость инструмента",
                  hintStyle: const TextStyle(color: Color.fromRGBO(102, 155, 188, 0.7)),
                  labelText: "Стоимость",
                  labelStyle: const TextStyle(color: Color.fromRGBO(102, 155, 188, 1)),
                ),
                maxLines: 1,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: "Введите информацию об инструменте",
                  hintStyle: const TextStyle(color: Color.fromRGBO(102, 155, 188, 0.7)),
                  labelText: "Информация",
                  labelStyle: const TextStyle(color: Color.fromRGBO(102, 155, 188, 1)),
                ),
                maxLines: 7,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: createProduct,
                child: Text("Добавить инструмент",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(233, 79, 55, 1),
                  foregroundColor: Colors.black87,
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
