import 'dart:convert';

import 'package:api_practice/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ProductModel> products = [];

  Future fetchData() async {
    final url = Uri.parse("https://api.escuelajs.co/api/v1/products");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("Success");

      final jsonData = jsonDecode(response.body);

      setState(() {
        for (var product in jsonData) {
          products.add(ProductModel(
            id: product["id"],
            title: product["title"],
            description: product["description"],
            images: product["images"][0],
          ));
        }
      });

      print(products.length);
    } else {
      print("Failed");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: false, title: Text("Api Integration")),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (_, index) {
          final data = products[index];

          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Container(
                height: 70,
                width: 70,
                child: Image.network(data.images),
              ),
              title: Text(data.title),
              subtitle: Text(
                data.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        },
      ),
    );
  }
}
