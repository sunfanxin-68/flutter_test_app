import 'package:flutter/material.dart';

class PromotionItem extends StatelessWidget {
  final String title;
  final Function onTap;
  final double width;
  final double height;
  final BoxDecoration decoration;

  PromotionItem({
    required this.title,
    required this.onTap,
    required this.width,
    required this.height,
    required this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        decoration: decoration,
        width: width,
        height: height,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10.0),
        child:  Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF45494E), // 设置文本颜色
          ),
        ),
      ),
    );
  }

}