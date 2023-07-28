import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TopSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.account_circle),
                SizedBox(width: 8.0),
                Text('用户名'),
              ],
            ),
            Text(DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 53, 93, 226), // 替换 primary 为 backgroundColor
              ),
              child: Text('登录'),
            ),
          ],
        ),
      ),
    );
  }
}
