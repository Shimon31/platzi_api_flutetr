import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiServices {
  static Future<List<ProductModel>?> fetchData() async {
    final url = Uri.parse("https://api.escuelajs.co/api/v1/products");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("Success");

      final jsonData = jsonDecode(response.body) as List;

      List<ProductModel> productList = [];
      for (var product in jsonData) {
        productList.add(ProductModel.fromJson(product));
      }

      return productList;

    } else {
      print("Failed");
    }
    return null;
  }
}