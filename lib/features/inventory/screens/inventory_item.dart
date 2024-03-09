import 'package:flutter/material.dart';
import "dart:convert";
import "package:http/http.dart" as http;

class InventoryItem extends StatefulWidget {
  String name;
  String type;
  double quantity;
  double price;
  String img;
  String id;
  InventoryItem(
      this.name, this.type, this.quantity, this.price, this.img, this.id);

  @override
  State<InventoryItem> createState() => _InventoryItemState();
}

class _InventoryItemState extends State<InventoryItem> {
  TextEditingController qty = TextEditingController();
  Future<void> update(String id, String qty) async {
    http.Response response;
    try {
      print(id);
      print(qty);
      response = await http.patch(
          Uri.parse(
              "https://agri-barn-cf566b77ec9d.herokuapp.com/farmer/inventory/$id"),
          headers: {
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NWViMTIwYTI3Y2IzYzQ1NjVkOWQ1MjUiLCJlbWFpbCI6InRlc3Q0QHRlc3QuY29tIiwidmVyaWZpZWQiOnRydWUsImlhdCI6MTcwOTkzNDc5MCwiZXhwIjoxNzEwMDIxMTkwfQ.MD-Y7xnA9m-WDpasmdOWvFlI580pZ3RabqHSU-jUTWw',
            'Content-Type': 'application/json',
            // Add any additional headers as needed
          },
          body: jsonEncode({"quantity": double.parse(qty)}));
      if (response.statusCode == 200) {
      } else if (response.statusCode == 404) {
        throw Exception({"statusCode": 404, "message": "Not Found"});
      } else {
        print('Failed to update item. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
        throw Exception('Failed to update item');
      }
    } catch (error) {
      print('Error updating item: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(28),
          ),
          height: 150,
          padding: EdgeInsets.all(10),
          // margin: EdgeInsets.all(3.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(
                        widget.img), // Replace with your image asset
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name),
                  Text('Quantity : ' + widget.quantity.toString()),
                  Text('Purchase Type : ' + widget.type),
                  Text('Rs.' + widget.price.toString()),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              SizedBox(
                width: 20,
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        contentPadding: EdgeInsets.all(30),
                        titlePadding: EdgeInsets.all(15),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              await update(widget.id, qty.text);
                              Navigator.of(context).pop();
                              setState(() {
                                widget.quantity = double.parse(qty.text);
                              });
                            },
                            child: Text("Done"),
                          ),
                        ],
                        title: Text(
                          'Edit Item',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: TextField(
                          controller: qty,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Quantity',
                            hintText: 'Change quantity',
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.edit,
                  size: 30,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}
