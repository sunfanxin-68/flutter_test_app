import 'package:flutter/material.dart';

class CouponItem extends StatelessWidget {
  final String title;
  final String amount;
  final String count;

  CouponItem({required this.title, required this.amount, required this.count});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      child: ListTile(
        title: Text(title),
        subtitle: Text(amount + ' ' + count),
        trailing: IconButton(
          icon: Icon(Icons.chevron_right),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(title)),
            );
          },
        ),
      ),
    );
  }
}
