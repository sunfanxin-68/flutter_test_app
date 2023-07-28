import 'package:flutter/material.dart';
import 'package:test_app/app/ui/page/detail/basepage/top_section.dart';
import 'package:test_app/app/ui/page/detail/basepage/left_section.dart';
import 'package:test_app/app/ui/page/detail/basepage/right_section.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView( // 使用SingleChildScrollView来包裹Column
            child: Column(
              children: <Widget>[
                TopSection(),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    LeftSection(),
                    RightSection(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
