import 'package:flutter/material.dart';

class CouponItem extends StatelessWidget {
  final String title;
  final String amount;
  final String count;

  CouponItem({required this.title, required this.amount, required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      child: Container(
        width: 402,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0x0D45494E),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Color(0xFF98A2AD)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(69, 73, 78, 1),
                  ),
                ),
              ),
              Expanded(
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      amount,
                      style: TextStyle(
                        fontSize: 28,
                        color: Color.fromRGBO(69, 73, 78, 1),
                      ),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(width: 20),  // 设置 amount 与 count 之间的间距
                    Text(
                      count,
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(69, 73, 78, 1),
                      ),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(width: 10),  // 设置 count 与 IconButton 之间的间距
                    IconButton(
                      icon: Icon(Icons.chevron_right),
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: true, // 设置点击对话框外部关闭对话框
                          builder: (BuildContext context) {
                            return AlertDialog(

                              content: Text(title),
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),

    );
  }
}
