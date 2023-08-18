import 'package:flutter/material.dart';

class DiscountDropdown extends StatefulWidget {
  final List<String> discountValues; // 存放下拉菜单中的值的列表
  final Function(String?) onChanged; // 当值变化时调用的回调函数

  DiscountDropdown(
      {super.key, required this.discountValues, required this.onChanged});

  @override
  _DiscountDropdownState createState() => _DiscountDropdownState();
}

class _DiscountDropdownState extends State<DiscountDropdown> {
  final buttonHeight = 60.0;
  final buttonWidth = 190.0;
  final textColor = Color.fromRGBO(69, 73, 78, 1); // 定义文本和图标的颜色
  final Color dropdownBorderColor = Color.fromRGBO(152, 162, 173, 1); // 下拉菜单的边框颜色

  String? currentDiscountValue;

  OverlayEntry? overlayEntry;
  Color discountBorderColor1 = Color.fromRGBO(152, 162, 173, 1);
  Color discountBoxColor1 = Colors.white;

  final GlobalKey _keyButton = GlobalKey();
  final FocusNode _focusNode1 = FocusNode(); // 用于监听输入框是否获得焦点

  late FocusAttachment _focusAttachment;

  // 初始化函数
  @override
  void initState() {
    super.initState();
    _focusAttachment = _focusNode1.attach(context);
    _focusNode1.addListener(updateColor); // 添加焦点变化监听器
  }

  // 当焦点变化时，根据是否有焦点来更新颜色
  void updateColor() {
    print("更新颜色的函数: ${_focusNode1.hasFocus}");
    setState(() {
      if (_focusNode1.hasFocus) {
        discountBorderColor1 = Color.fromRGBO(55, 75, 186, 1);
        discountBoxColor1 = Color.fromRGBO(239, 245, 247, 1);
      } else {
        discountBorderColor1 = Color.fromRGBO(152, 162, 173, 1);
        discountBoxColor1 = Colors.white;
      }
    });
  }

  // 切换显示或隐藏下拉菜单
  void toggleDropdown(BuildContext context) {
    if (overlayEntry == null) {
      _focusAttachment.reparent();
      showDropdown(context); // 显示下拉菜单
    } else {
      hideDropdown(); // 隐藏下拉菜单
    }
  }

  // 在屏幕上显示下拉菜单
  void showDropdown(BuildContext context) {
    RenderBox? renderBox =
    _keyButton.currentContext?.findRenderObject() as RenderBox?;
    var buttonPosition = renderBox?.localToGlobal(Offset.zero);

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: buttonWidth,
        left: buttonPosition?.dx,
        top: buttonPosition!.dy + buttonHeight,
        child: Material(
          color: Colors.transparent,
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: widget.discountValues.map((e) {
                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(_focusNode1);
                    print("GestureDetector tapped");
                    hideDropdown();
                    widget.onChanged(e);
                    setState(() {
                      currentDiscountValue = e;
                    });
                  },
                  child: Container(
                    width: buttonWidth,
                    height: buttonHeight,
                    decoration: BoxDecoration(
                      border: Border.all(color: dropdownBorderColor),  // 使用新的颜色常量
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(right: 80),
                        child: Text(
                          e,
                          style: TextStyle(
                            fontSize: 22,
                            color: textColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  // 隐藏屏幕上的下拉菜单
  void hideDropdown() {
    overlayEntry?.remove(); // 移除下拉菜单的overlay
    overlayEntry = null;
    _focusAttachment.detach();
    setState(() {
      _focusNode1.unfocus(); // 取消焦点
    });
  }

  // 构建UI部分
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _keyButton,
      onTap: () {
        setState(() {
          _focusNode1.requestFocus(); // 请求焦点
          toggleDropdown(context); // 切换下拉菜单显示
        });
      },
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        decoration: BoxDecoration(
          border: Border.all(color: discountBorderColor1),
          borderRadius: BorderRadius.circular(5),
          color: discountBoxColor1,
          boxShadow: [
            if (_focusNode1.hasFocus)
              const BoxShadow(
                color: Color.fromRGBO(55, 75, 186, 0.35),
                blurRadius: 6.0,
              ),
          ],
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: currentDiscountValue,
            items: [],
            onChanged: (value) {},
            isExpanded: true,
            icon: Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(
                Icons.expand_more,
                color: textColor,
              ),
            ),
            hint: Center(
              child: Padding(
                padding: EdgeInsets.only(right: 50),
                child: Text(
                  currentDiscountValue ?? "",
                  style: TextStyle(
                    fontSize: 22,
                    color: textColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 销毁时的清理函数
  @override
  void dispose() {
    _focusNode1.dispose();
    super.dispose();
  }
}
