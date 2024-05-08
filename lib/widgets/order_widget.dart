import 'package:flutter/material.dart';

class OrderWidget extends StatelessWidget {
  final Map<String, dynamic> orderData;

  OrderWidget({required this.orderData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF62BD5C)),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Number: ${orderData['orderNumber']}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Date: ${orderData['formattedDate']}'),
            SizedBox(height: 10),
            Text(
              'Items:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Divider(
              color: Color(0xFF62BD5C),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                orderData['items'].length,
                (index) {
                  final item = orderData['items'][index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Restaurant: ${item['restaurant']}'),
                      Text('Location: ${item['location']}'),
                      SizedBox(height: 10),
                      Text('Item: ${item['itemName']}'),
                      Text('Price: ${item['price']}'),
                      Text('Quantity: ${item['quantity']}'),
                      Divider(
                        color: Color(0xFF62BD5C),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Total Items: ${orderData['totalItems']}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Total Price: ${orderData['totalPrice']}',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF62BD5C)),
            ),
          ],
        ),
      ),
    );
  }
}
