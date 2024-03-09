import "package:appathon/features/inventory/screens/inventory_item.dart";
import "package:flutter/material.dart";
import "dart:convert";
import "package:http/http.dart" as http;

class MyInventory extends StatefulWidget {
  @override
  State<MyInventory> createState() => _MyInventoryState();
}

class _MyInventoryState extends State<MyInventory> {
  var inven = [];
  var apiResponse;
  Future<void> apicall() async {
    http.Response response;
    try {
      response = await http.get(
        Uri.parse(
            "https://agri-barn-cf566b77ec9d.herokuapp.com/farmer/inventory"),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NWViMTIwYTI3Y2IzYzQ1NjVkOWQ1MjUiLCJlbWFpbCI6InRlc3Q0QHRlc3QuY29tIiwidmVyaWZpZWQiOmZhbHNlLCJpYXQiOjE3MDk5MDQzOTYsImV4cCI6MTcwOTk5MDc5Nn0.BV-NmQVu9xOtscvEm2FnbktO0roKCdn6ic5rs8AFlZ8',
          'Content-Type': 'application/json',
          // Add any additional headers as needed
        },
      );
      if (response.statusCode == 200) {
        apiResponse = json.decode(response.body);
        print(apiResponse);
      } else if (response.statusCode == 404) {
        throw Exception({"statusCode": 404, "message": "Not Found"});
      }
    } catch (error) {
      throw error;
    }
  }

  @override
  void initState() {
    initializeData();
    super.initState();
  }

  Future<void> initializeData() async {
    await apicall();
    if (apiResponse != null) {
      setState(() {
        inven = apiResponse["products"];
        print(inven);
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (apiResponse != null) {
      inven = apiResponse["products"];
      print(inven);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF208B3A),
        title: const Text('My Inventory'),
      ),
      body: Container(
        width: 450,
        padding: const EdgeInsets.all(15),
        child: apiResponse != null
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return InventoryItem(
                    inven[index]["product"]["name"].toString(),
                    inven[index]["type"].toString(),
                    inven[index]["unit"]?.toDouble() ?? 0.0,
                    inven[index]["product"]["purchasePrice"]?.toDouble() ?? 0.0,
                    inven[index]["product"]["image"].toString(),
                    inven[index]["product"]["_id"].toString(),
                  );
                },
                itemCount: apiResponse!["products"].length,
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
