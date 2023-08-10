import 'package:flutter/material.dart';
import 'package:test_app/app/ui/page/detail/basepage/left_section.dart';
import 'package:test_app/app/ui/page/detail/basepage/right_section.dart';

import 'basepage/top_section.dart';

class SubtotalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   // double availableHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFDCDCDC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              SizedBox(height: 20.0),
              createHeader(context),
              Expanded( // 使用Expanded来占据可用空间
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      child: Flex(
                        direction: Axis.vertical,
                        children: <Widget>[
                          Flex(
                            direction: Axis.horizontal,
                            children: [
                              Expanded(
                                child: Container(),
                                flex: 2,
                              ),
                              Expanded(
                                child: FittedBox(
                                  child: SubTabWidget(),
                                  fit: BoxFit.contain,
                                ),
                                flex: 1,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createHeader(BuildContext context) {
    return Container(
      child: TopSection(),
    );
  }
}

