import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'page2.dart';
import 'order.dart';

class Page1 extends StatefulWidget {
  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  Map<String, int> quantities = {
    'Burger': 0,
    'Pizza': 0,
    'Pasta': 0,
  };

  Map<String, double> prices = {
    'Burger': 5,
    'Pizza': 8,
    'Pasta': 7,
  };

  bool drink = false;
  String msg = '';

  static const String baseUrl =
      "https://techgadgetsliu.onlinewebshop.net/csci410/";

  double getTotal() {
    double total = 0;
    quantities.forEach((item, qty) {
      total += qty * prices[item]!;
    });
    if (drink) total += 2;
    return total;
  }

  String getItemsText() {
    String text = '';
    quantities.forEach((item, qty) {
      if (qty > 0) {
        text += '$item x$qty, ';
      }
    });
    return text.isEmpty ? 'No items' : text;
  }

  Future<int> createOrder(Order o) async {
    var url = Uri.parse(
      "${baseUrl}createOrder.php?item=${o.items}&quantity=1&price=${o.total}&drink=${drink ? 1 : 0}",
    );

    var res = await http.get(url);
    var data = jsonDecode(res.body);
    return int.parse(data["order_id"].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),

          ...quantities.keys.map((item) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("$item (\$${prices[item]})"),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (quantities[item]! > 0) quantities[item] = quantities[item]! - 1;
                    });
                  },
                ),
                Text(quantities[item].toString()),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      quantities[item] = quantities[item]! + 1;
                    });
                  },
                ),
              ],
            );
          }).toList(),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: drink,
                onChanged: (v) {
                  setState(() {
                    drink = v!;
                  });
                },
              ),
              Text("Add Drink (+2)"),
            ],
          ),

          SizedBox(height: 10),
          Text("Total: \$${getTotal()}"),

          ElevatedButton(
            onPressed: () async {
              setState(() {
                msg = "Saving...";
              });

              Order o = Order(getItemsText(), getTotal());
              int id = await createOrder(o);

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Page2(order: o, orderId: id),
                ),
              );
            },
            child: Text("Place Order"),
          ),

          SizedBox(height: 10),
          Text(msg),
        ],
      ),
    );
  }
}
