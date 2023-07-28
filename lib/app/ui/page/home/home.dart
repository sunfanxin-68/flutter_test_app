import 'package:flutter/material.dart';
import 'package:test_app/app/ui/page/detail/detail.dart'; // 这里的 your_project 需要改为你项目的名称

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('结账'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailPage()),
            );
          },
        ),
      ),
    );
  }
}