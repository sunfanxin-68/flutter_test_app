import 'package:flutter/material.dart';

class MachineItem extends StatelessWidget {
  final String title;
  final String status;
  final double width;
  final double height;

  MachineItem({
    required this.title,
    required this.status,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    Color containerColor = Color(0xffC1371E);
    Color textColor = Colors.white;

    if (status == '使用中' || status == '休止中') {
      containerColor = Colors.white;
      textColor = Color(0xffC1371E);
    }
    double opacity = (status == '使用中' || status == '休止中') ? 0.4 : 1.0;

    return Container(
      width: 110,
      height: 110,
      margin: const EdgeInsets.all(5.0),
      child: Stack(
        children: [
          // 设置背景和阴影的透明部分
          Opacity(
            opacity: opacity,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFDBE7FC),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                border: Border.all(color: Color.fromRGBO(55, 75, 186, 0.5), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // 调整阴影透明度
                    spreadRadius: 0,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
          // 设置状态部分
          if (status != "")
            Container(
              width: width,
              height: 30,
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                border: Border.all(color: Color(0xffC1371E), width: 2),
              ),
              child: Center(
                child: Text(
                  status,
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
              ),
            ),
          // 设置标题部分
          Align(
            alignment: Alignment.bottomCenter,
            child: Opacity(
              opacity: opacity,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF45494E),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
