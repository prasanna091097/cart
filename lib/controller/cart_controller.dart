import 'package:get/get.dart';

import '../model/cart_model.dart';
// import '../model/product_model.dart';

class CartController extends GetxController {
  final _products = {}.obs;

  void addProduct(Product product) {
    if (_products.containsKey(product)) {
      _products[product] += 1;
    } else {
      _products[product] = 1;
    }

    Get.snackbar(
      "PRODUCT IS ADDED",
      "You have added the ${product.name} ",
      duration: const Duration(seconds: 1),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void removeProduct(Product product) {
    if (_products.containsKey(product) && _products[product] == 1) {
      _products.removeWhere((key, value) => key == product);
    } else {
      _products[product] -= 1;
    }
  }

  get products => _products;

  get productSubtotals => _products.entries
      .map((product) => product.key.price * product.value)
      .toList();

  get totals => _products.entries
      .map((product) => product.key.price * product.value)
      .toList()
      .reduce((value, element) => value + element)
      .toStringAsFixed(2);
}

class SearchController extends GetxController {
  final List<Map<String, dynamic>> allProductss = [
    {"name": "Sofa", "category": "Furniture"},
    {"name": "Bed ", "category": "Furniture"},
    {"name": "DoubleCot", "category": "Furniture"},
    {"name": "Table", "category": "Furniture"},
    {"name": "Chair", "category": "Furniture"},
    {"name": "ArmChair", "category": "Furniture"},
    {"name": "Bench", "category": "Furniture"},
    {"name": "Stool", "category": "Furniture"},
  ];
  Rx<List<Map<String, dynamic>>> foundProductss =
      Rx<List<Map<String, dynamic>>>([]);

  @override
  void onInit() {
    super.onInit();
    foundProductss.value = allProductss;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void filterProduct(String productName) {
    List<Map<String, dynamic>> results = [];
    if (productName.isEmpty) {
      results = allProductss;
    } else {
      results = allProductss
          .where((element) => element["name"]
              .toString()
              .toLowerCase()
              .contains(productName.toLowerCase()))
          .toList();
    }
    foundProductss.value = results;
  }
}
