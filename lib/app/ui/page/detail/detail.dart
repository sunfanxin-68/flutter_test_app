import 'package:flutter/material.dart';
import 'package:test_app/app/ui/page/detail/basepage/left_section.dart';
import 'package:test_app/app/ui/page/detail/basepage/right_section.dart';

class SubtotalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDCDCDC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            child:Flex(
              direction: Axis.vertical,
              children: <Widget>[
                SizedBox(height: 200.0),
                Flex(
                  direction: Axis.horizontal, // 横向布局
                  children: <Widget>[
                    Expanded(
                      child: Flex(
                        direction: Axis.vertical, // 列表布局
                        children: <Widget>[
                          Flex(
                            direction: Axis.horizontal, // 横向布局
                            children: [
                              Expanded(
                                child: Container(),  // 这是一个空的 Expanded widget，占据了左边的空间
                                flex: 2,  // 设置 flex 为 3
                              ),
                              Expanded(
                                child: FittedBox(
                                  child: SubTabWidget(), // 这里使用 FittedBox 包裹了 TabWidget
                                  fit: BoxFit.contain, // 设置 FittedBox 的 fit 属性
                                ),
                                flex: 1,  // 设置 flex 为 1
                              ),
                            ],
                          ),
                          LeftSection(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: RightSection(),
                    ),
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




