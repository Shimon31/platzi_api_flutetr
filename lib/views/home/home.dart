import 'dart:convert';

import 'package:api_practice/models/product_model.dart';
import 'package:api_practice/services/api_services.dart';
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



  @override
  void initState() {

    super.initState();
    fetchData();
  }
  
  fetchData() async{
    final data = await ApiServices.fetchData();
    
    print(data?.length);

    setState(() {
      products = data!;
    });
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
