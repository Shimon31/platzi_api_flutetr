import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> products = [];

  Future fetchData() async {
    final url = Uri.parse(
      "https://api.escuelajs.co/api/v1/products",
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("Success");
      print(response.body.runtimeType);

      final jsonData = jsonDecode(response.body);

      print(jsonData);
      //
      // final productList = jsonData["data"] as List;


      setState(() {
        products = jsonData;
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
            child: ListTile(
              leading: Image.network(data["images"][0]),
              title: Text(data["title"]),
            ),
          );
        },
      ),
    );
  }
}
