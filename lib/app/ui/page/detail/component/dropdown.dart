import 'package:flutter/material.dart';

class DiscountDropdown extends StatefulWidget {
  final List<String> discountValues; // 折扣值列表
  final Function(String?) onChanged; // 选择更改时的回调

  DiscountDropdown({required this.discountValues, required this.onChanged});

  @override
  _DiscountDropdownState createState() => _DiscountDropdownState();
}

class _DiscountDropdownState extends State<DiscountDropdown> {
  String? currentDiscountValue; // 当前选中的折扣值
  Color discountBorderColor = Color.fromRGBO(152, 162, 173, 1); // 边框颜色
  Color discountBoxColor = Colors.white; // 盒子颜色
  FocusNode focusNode = FocusNode(); // 焦点节点

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {
        // 根据焦点改变边框和盒子的颜色
        discountBorderColor = focusNode.hasFocus
            ? Color.fromRGBO(55, 75, 186, 1)
            : Color.fromRGBO(152, 162, 173, 1);
        discountBoxColor = focusNode.hasFocus
            ? Color.fromRGBO(239, 245, 247, 1)
            : Colors.white;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(
          color: discountBorderColor, // 设置边框颜色
        ),
        borderRadius: BorderRadius.circular(5), // 圆角边框
        color: discountBoxColor, // 设置盒子颜色
        boxShadow: focusNode.hasFocus // 设置阴影
            ? [
                BoxShadow(
                  color: Color.fromRGBO(55, 75, 186, 0.35),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ]
            : [],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          focusNode: focusNode,
          // 焦点节点
          value: currentDiscountValue,
          // 当前选中值
          items: widget.discountValues.map((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 22,
                      color: Color.fromRGBO(69, 73, 78, 1), // 文本样式
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            // 选项更改时的回调
            setState(() {
              currentDiscountValue = value; // 更新选中值
            });
            widget.onChanged(value); // 调用外部更改回调
          },
          isExpanded: true,
          hint: Container(),
          icon: Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.expand_more), // 下拉图标
          ),
        ),
      ),
    );
  }
}
