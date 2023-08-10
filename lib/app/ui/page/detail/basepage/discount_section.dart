import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../component/dropdown.dart';
import '../component/register_tenkey.dart';
import '../controller/subtotal2_controller.dart';

// 这是一个 StatefulWidget，主要用于显示折扣部分。
class DiscountSection extends StatefulWidget {
  @override
  _DiscountSectionState createState() => _DiscountSectionState();
}

class _DiscountSectionState extends State<DiscountSection> {
  final SubtotalController controller = Get.put(SubtotalController());
  TextEditingController textEditingController = TextEditingController();
  bool isKeyboardVisible = false;

  String? currentDiscountValue1;

  // 这是一个布尔值，用于确定是否显示确认按钮。
  bool showConfirmButton = false;

  // 以下两个是用于监听输入框聚焦状态的 FocusNode。
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

  // 定义输入框的初始边框和背景颜色。
  Color discountBorderColor = Color.fromRGBO(152, 162, 173, 1);
  Color discountBoxColor = Colors.white;

  @override
  void initState() {
    super.initState();
    // 为 _focusNode1 添加监听器。
    focusNode1.addListener(() {
      setState(() {
        // 如果 _focusNode1 有焦点，将 borderColor1 和 boxColor1 设置为聚焦颜色，否则设置为默认颜色。
        // 通过三元运算符，如果 _focusNode1 有焦点，则选择聚焦颜色，否则选择默认颜色。
        discountBorderColor = focusNode1.hasFocus
            ? Color.fromRGBO(55, 75, 186, 1)
            : Color.fromRGBO(152, 162, 173, 1);
        discountBoxColor = focusNode1.hasFocus
            ? Color.fromRGBO(239, 245, 247, 1)
            : Colors.white;
      });
    });
    focusNode2.addListener(() {
      if (focusNode2.hasFocus) {
        // 焦点在输入框上时显示自定义键盘
        isKeyboardVisible = true;
      }
      setState(() {
        discountBorderColor = focusNode2.hasFocus
            ? Color.fromRGBO(55, 75, 186, 1)
            : Color.fromRGBO(152, 162, 173, 1);
        discountBoxColor = focusNode2.hasFocus
            ? Color.fromRGBO(239, 245, 247, 1)
            : Colors.white;
      });
    });
  }

  void handleKeyTap(String key) {
    controller.onKeyTap(key, focusNode2);
    // 只有在点击 "✔️" 时才隐藏键盘
    if (key == "✔️") {
      isKeyboardVisible = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80.0),
      child: Card(
        color: Colors.white,
        child: SizedBox(
          width: 535,
          height: 654,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 466,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 232, 229, 1),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                        ),
                      ),
                      child: Center(
                        child: Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "値引き対象額",
                              style: TextStyle(
                                color: Color.fromRGBO(193, 55, 30, 1),
                                fontSize: 18,
                              ),
                            ), // 您可以替换为真实的标题
                            SizedBox(width: 20),
                            Text(
                              '${controller.discountAmount.value}',
                              style: TextStyle(
                                color: Color.fromRGBO(193, 55, 30, 1),
                                fontSize: 28,
                              ),
                              //  textAlign: TextAlign.right,
                            ), // 您可以替换为真实的折扣金额
                          ],
                        ),
                      ),
                    ),
                    // 新增的Container，包含两个水平Text部件
                    Container(
                      padding: const EdgeInsets.only(left: 100, top: 15),
                      // 这里可以调整间距
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Text(
                            "変更後",
                            style: TextStyle(
                              color: Color.fromRGBO(193, 55, 30, 1),
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(width: 70), // 这里可以调整两个Text之间的间距
                          Text(
                            '${controller.discountAmount.value}',
                            style: TextStyle(
                              color: Color.fromRGBO(193, 55, 30, 1),
                              fontSize: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                top: 10, // 可以根据需要调整
                right: 15, // 距离右边的间距
                child: IconButton(
                  icon: Icon(Icons.clear),
                  color: Color.fromRGBO(69, 73, 78, 1),
                  iconSize: 40,
                  onPressed: controller.toggleDiscountSection,
                ),
              ),
              // 第一个 "割引" 文字和下拉菜单
              Positioned(
                top: 140, // 将其上移10像素以放置文字
                left: 40,
                child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "割引",
                      style: TextStyle(
                          color: Color.fromRGBO(69, 73, 78, 1), fontSize: 18),
                    ),
                    SizedBox(height: 10), // 为文本和下拉菜单之间添加间距
                    DiscountDropdown(
                      discountValues: controller.discountValues,
                      onChanged: (value) {
                        setState(() {
                          currentDiscountValue1 = value;
                          showConfirmButton = true;
                        });
                      },
                    ),
                  ],
                ),
              ),

              // 第二个 "値引" 文字和键盘
              Positioned(
                top: 140,
                right: 50,
                child: GestureDetector(
                  onTap: () {
                    // 点击输入框，打开键盘
                    isKeyboardVisible = true;
                    setState(() {});
                  },
                  child: Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "値引",
                        style: TextStyle(
                            color: Color.fromRGBO(69, 73, 78, 1), fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 190,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: discountBorderColor,
                          ),
                          borderRadius: BorderRadius.circular(5),
                          color: discountBoxColor,
                          boxShadow: focusNode2.hasFocus
                              ? [
                                  const BoxShadow(
                                    color: Color.fromRGBO(55, 75, 186, 0.35),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(0, 2),
                                  ),
                                ]
                              : [],
                        ),
                        alignment: Alignment.centerLeft,
                        child: TextField(
                          focusNode: focusNode2,
                          controller: controller.textEditingController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 40),
                          ),
                          style: TextStyle(
                            fontSize: 22,
                            color: Color.fromRGBO(69, 73, 78, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 269,
                right: 25,
                child: buildKeyboard(),
              ),

              ///确定按钮
              if (showConfirmButton && !isKeyboardVisible)
                Positioned(
                  right: 30, // 控制按钮距离右侧的位置
                  bottom: 30, // 控制按钮距离底部的位置
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      // 设置背景颜色为透明
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      // 设置内边距为0
                      shape:
                          MaterialStateProperty.all(RoundedRectangleBorder()),
                      // 设置按钮的形状
                      minimumSize: MaterialStateProperty.all(Size(200, 80)),
                      // 设置按钮的最小尺寸
                      shadowColor: MaterialStateProperty.all(
                          Color.fromRGBO(69, 73, 78, 0.35)), // 设置阴影颜色
                    ),
                    onPressed: () => controller.discountSave(context),
                    // 按钮的点击事件处理
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter, // 渐变开始位置
                          end: Alignment.bottomCenter, // 渐变结束位置
                          colors: [
                            // 渐变的颜色
                            Color.fromRGBO(86, 91, 98, 1),
                            Color.fromRGBO(14, 15, 16, 1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(5), // 按钮的圆角
                        boxShadow: [
                          // 按钮的阴影设置
                          BoxShadow(
                            color: Color.fromRGBO(69, 73, 78, 0.35),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Container(
                        alignment: Alignment.center, // 文本居中对齐
                        constraints: BoxConstraints(
                            maxWidth: 200, maxHeight: 80), // 设置容器的最大宽高
                        child: Text(
                          '確定', // 按钮的文本内容
                          style: TextStyle(
                              color: Colors.white, fontSize: 22), // 文本的样式
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildKeyboard() {
    return isKeyboardVisible
        ? RegisterTenkey(onKeyTap: handleKeyTap)
        : Container();
  }

// @override
// void dispose() {
//   focusNode1.dispose();
//   focusNode2.dispose();
//   super.dispose();
// }
}
