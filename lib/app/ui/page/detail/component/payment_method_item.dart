import 'package:flutter/material.dart';

class PaymentMethodItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap; // 添加一个点击回调函数作为参数

  PaymentMethodItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // 当点击时调用传入的回调函数
      child: Container(
        width: 110, // 宽度110
        height: 110, // 高度110
        decoration: BoxDecoration(
          color: Color(0xFFDBE7FC), // 设置背景颜色
          borderRadius: BorderRadius.circular(5), // 圆角5
          border: Border.all(
              color: const Color(0xff374bba50), width: 1), // 蓝色边框线
          boxShadow: [
            BoxShadow(
              // 阴影
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(2, 2),
            ),
          ],
        ),

          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: onTap,
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 40,
                    color: Color(0xFF45494E), // 设置图标颜色
                  ),
                  SizedBox(height: 10), // 间距10
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF45494E), // 设置文本颜色
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
