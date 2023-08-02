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
                flex: 3, // 设置 title 占据更多的空间
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(69, 73, 78, 1),
                  ),
                ),
              ),
              Expanded(
                flex: 4, // 你可以调整这些 flex 值以达到所需的分配比例
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        amount,
                        style: TextStyle(
                          fontSize: 28,
                          color: Color.fromRGBO(69, 73, 78, 1),
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        count,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(69, 73, 78, 1),
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
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
                      ),
                    ),
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
