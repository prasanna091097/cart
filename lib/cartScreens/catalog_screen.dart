import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;

import 'package:get/get.dart';

import '../CartWidgets/catalog.dart';
import '../model/cart_model.dart';
import '../resuable_widgets/reusable.dart';
import 'cart_screen.dart';

class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
          Color(0XFFA1282A),
          Color.fromARGB(255, 164, 53, 52),
          Color(0XFF711F2C)
        ]))),
        actions: [
          IconButton(
            onPressed: () {
              // Get.to(SearchView());
              // method to show the search bar
              // showSearch(
              //     context: context,
              //     // delegate to customize the search bar
              //     delegate: SearchView());
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const FilterPage()));
            },
            icon: const Icon(
              Icons.filter_list_alt,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Get.to(() => const CartScreen());
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: ReadJsonData(),
            builder: (context, data) {
              if (data.hasError) {
                return Center(child: Text("${data.error}"));
              } else if (data.hasData) {
                var product = data.data as List<Product>;
                return Column(
                  children: [
                    const CatalogProducts(),
                    uiButton(context, "Go To Cart",
                        (() => Get.to(() => const CartScreen())))
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                  // child: SpinKitWave(
                  //   color: Color(0XFF711F2C),
                  //   size: 50.0,
                  // ),
                );
              }
            }),
      ),
    );
  }

  Future<List<Product>> ReadJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/products.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => Product.fromjson(e)).toList();
  }
}
