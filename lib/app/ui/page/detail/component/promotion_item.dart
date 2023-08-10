import 'package:flutter/material.dart';

class PromotionItem extends StatelessWidget {
  final String title;
  //final Function onTap;
  final double width;
  final double height;
  final BoxDecoration decoration;

  PromotionItem({
    required this.title,
   // required this.onTap,
    required this.width,
    required this.height,
    required this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     // onTap: () => onTap(),
      child: Container(
       // margin: EdgeInsets.all(5),
        decoration: decoration,
        width: width,
        height: height,
        alignment: Alignment.center,
        //padding: EdgeInsets.all(12.0),
        child:  Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF45494E), // 设置文本颜色
          ),
        ),
      ),
    );
  }

}