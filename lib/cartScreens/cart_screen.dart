import 'package:flutter/material.dart';

import '../CartWidgets/cart_product.dart';
import '../CartWidgets/cart_total.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
            Color(0XFFA1282A),
            Color.fromARGB(255, 164, 53, 52),
            Color(0XFF711F2C)
          ]))),
        ),
        body: Column(
          children: [
            CartProducts(),
            const Divider(
              thickness: 2,
            ),
            CartTotal(),
          ],
        ));
  }
}
