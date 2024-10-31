import 'package:flutter/material.dart';
import 'package:pr3/pages/details.dart';
import 'package:pr3/models/product.dart';
import 'package:pr3/util/string_utils.dart';

class ProductComponent extends StatelessWidget {
  const ProductComponent({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => Details(product: product))),
        child: Container(
            padding: const EdgeInsets.all(8.0),
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05),
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5.0)),
            width: double.infinity,
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image(
                        image: AssetImage(product.photo),
                        height: MediaQuery.of(context).size.width * 0.9,
                        width: MediaQuery.of(context).size.width * 0.9,
                        fit: BoxFit.cover)),
                Text(
                  product.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFFFFFF)),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(1),
                        margin: const EdgeInsets.only(right: 10, top: 10),
                        width: MediaQuery.of(context).size.height * 0.12,
                        height: MediaQuery.of(context).size.height * 0.05,
                        alignment: Alignment.center,

                        child: Text(
                          "${product.price} р",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                              MediaQuery.of(context).size.height * 0.03,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ])
              ],
            )),
      ),
    );
  }
}
