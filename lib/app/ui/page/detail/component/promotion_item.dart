import 'package:flutter/material.dart';

class PromotionItem extends StatelessWidget {
  final String title;
  final bool isTriangle;
  final Function onTap;
  final double width;

  PromotionItem({
    required this.title, 
    this.isTriangle = false,
    required this.onTap,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: width,
        height: width,
        padding: const EdgeInsets.all(8.0),
        color: Colors.blue,
        child: Text(title, textAlign: TextAlign.center),
      ),
    );
  }
}