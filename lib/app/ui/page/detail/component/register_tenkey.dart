

import 'package:flutter/material.dart';

typedef OnKeyTap = void Function(String key);

class RegisterTenkey extends StatelessWidget {
  final OnKeyTap onKeyTap;

  RegisterTenkey({required this.onKeyTap});

  Widget buildKeyRow(List<String> keys, [int checkMarkSpan = 1]) {
    return Expanded(
      child: Flex(
        direction: Axis.horizontal,
        children: keys.map((key) {
          return Expanded(
            flex: key == "✔️" ? checkMarkSpan : 1,
            child: InkWell(
              onTap: () => onKeyTap(key),
              child: Container(
                decoration: BoxDecoration(
                  gradient: key == "✔️"
                      ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(86, 91, 98, 1),
                      Color.fromRGBO(14, 15, 16, 1),
                    ],
                  )
                      : null,
                  color: key == 'X'
                      ? Color.fromRGBO(239, 245, 247, 1)
                      : key == 'C'
                      ? Color.fromRGBO(255, 232, 229, 1)
                      : Color.fromRGBO(219, 231, 252, 1),
                  border: Border.all(
                    color: Color.fromRGBO(152, 162, 173, 1),
                  ),
                ),
                child: Center(
                  child: key == 'X'
                      ? Icon(Icons.backspace)
                      : key == '✔️'
                      ? Icon(
                    Icons.done,
                    color: Colors.white,
                  )
                      : Text(key, style: TextStyle(fontSize: 22)),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 其他代码不变
    return Container(
      width: 180,
      height: 288,
      decoration: BoxDecoration(
        color: Color.fromRGBO(219, 231, 252, 1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.0),
          bottomLeft: Radius.circular(5.0),
        ),
        border: Border.all(
          color: Color.fromRGBO(152, 162, 173, 1), // 外部边框颜色
          width: 5, // 外部边框宽度
        ),
      ),
      child: Flex(
        direction: Axis.vertical,
        children: [
          buildKeyRow(["7", "8", "9"]),
          buildKeyRow(["4", "5", "6"]),
          buildKeyRow(["1", "2", "3"]),
          buildKeyRow(["0", "00", "X"]),
          buildKeyRow(["C", "✔️"], 2),
        ],
      ),
    );
  }
}

