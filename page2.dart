import 'package:flutter/material.dart';
import 'order.dart';

class Page2 extends StatelessWidget {
  Order order;
  int orderId;

  Page2({required this.order, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Confirmation"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),

            Text(
              "Order Number",
              style: TextStyle(fontSize: 18),
            ),

            SizedBox(height: 5),

            Text(
              orderId.toString(),
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            Text("Items:", style: TextStyle(fontSize: 18)),
            SizedBox(height: 5),
            Text(order.items),

            SizedBox(height: 15),

            Text(
              "Total: \$${order.total}",
              style: TextStyle(fontSize: 18),
            ),

            SizedBox(height: 20),

            Text(
              "Status: Pending",
              style: TextStyle(fontSize: 18),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Back to Menu"),
            ),
          ],
        ),
      ),
    );
  }
}
