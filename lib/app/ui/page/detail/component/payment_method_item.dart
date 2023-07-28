import 'package:flutter/material.dart';

class PaymentMethodItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double imageSize;
  final double padding;

  PaymentMethodItem({
    required this.title, 
    required this.imageUrl, 
    this.imageSize = 50,
    this.padding = 8.0
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: EdgeInsets.all(padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (imageUrl != "")
            Image.network(
              imageUrl,
              width: imageSize,
              height: imageSize,
            ),
          Text(title),
        ],
      ),
    );
  }
}
