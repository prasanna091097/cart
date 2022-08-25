import 'package:flutter/material.dart';

import 'package:get/instance_manager.dart';
import 'package:get/get.dart';

import 'dart:async' show Future;
import 'dart:convert';
// ignore: library_prefixes
import 'package:flutter/services.dart' as rootBundle;

import '../controller/cart_controller.dart';
import '../model/cart_model.dart';

class CatalogProducts extends StatelessWidget {
  const CatalogProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FutureBuilder(
          future: ReadJsonData(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else if (data.hasData) {
              var product = data.data as List<Product>;
              return ListView.builder(
                  itemCount: product == null ? 0 : product.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CatalogProductsCard(
                      index: index,
                      product: product,
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Future<List<Product>> ReadJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/products.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => Product.fromjson(e)).toList();
  }
}

class CatalogProductsCard extends StatelessWidget {
  final cartController = Get.put(CartController());
  final int index;
  var product;
  CatalogProductsCard({Key? key, required this.index, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(product[index].imageURL.toString())),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  product[index].name.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Text.rich(TextSpan(
                        text: product[index].oldPrice.toString(),
                        style: const TextStyle(
                            fontSize: 18,
                            decoration: TextDecoration.lineThrough))),
                    Text('\$${product[index].price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ))
                  ],
                ),
              ),
            ),
            IconButton(
                onPressed: (() {
                  cartController.addProduct(product[index]);
                }),
                icon: const Icon(Icons.add_circle))
          ],
        ),
      ),
    );
  }
}
