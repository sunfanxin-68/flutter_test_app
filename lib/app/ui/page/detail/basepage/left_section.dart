import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/app/ui/page/detail/component/coupon_item.dart';
import 'package:test_app/app/ui/page/detail/controller/subtotal2_controller.dart';

class SubTabWidget extends StatelessWidget {
  final controller = Get.put(SubtotalController());

  SubTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 50, right: 18),
        alignment: Alignment.centerRight,
        width: 144,
        height: 50,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(242, 243, 244, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 13.0),
              child: Center(
                child: Obx(
                  () => Text(
                    ' ${controller.registerNumber.value}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF45494E),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              // 左右边距为10
              child: Divider(color: Colors.grey, thickness: 1.0),
            ),
          ],
        ),
      ),
    );
  }
}

class LeftSection extends StatelessWidget {
  final controller = Get.put(SubtotalController());
  final ScrollController _controller = ScrollController();

  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: 0.0, left: 10.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.45,
          color: Color.fromRGBO(242, 243, 244, 1),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Obx(() => Padding(
                    padding: EdgeInsets.only(top: 30.0, right: 20),
                    // 设置距离顶部的间距
                    child: Flex(
                      direction: Axis.horizontal, // 设置方向为水平
                      mainAxisAlignment: MainAxisAlignment.end, // 从右到左排列
                      children: [
                        const Text(
                          '値引き合計',
                          style: TextStyle(
                            color: Color(0xffC1371E),
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 15),
                        Text(
                          '${controller.discountAmount.value}',
                          style: TextStyle(
                            color: Color(0xffC1371E),
                            fontSize: 28,
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: 50.0),

              Obx(
                () => Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '合計',
                        style: TextStyle(
                          color: Color(0xFF45494E),
                          fontSize: 22,
                        ),
                      ),
                       SizedBox(height: 15),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${controller.totalItems.value} 点',
                                style: TextStyle(
                                  color: Color.fromRGBO(69, 73, 78, 1),
                                  fontSize: 28,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Text(
                                  '${controller.totalAmount.value}',
                                  style: TextStyle(
                                    color: Color.fromRGBO(69, 73, 78, 1),
                                    fontSize: 34,
                                  ),
                                  //  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                // 左右边距为10
                child: Divider(color: Colors.grey, thickness: 2.0),
              ),

              SizedBox(height: 15.0),
              Obx(
                () => Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  // 同时设置左右边距为20
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      const Expanded(
                        child: Text(
                          'お預かり金額',
                          style: TextStyle(
                            color: Color.fromRGBO(69, 73, 78, 1),
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${controller.receivedAmount.value}',
                            style: TextStyle(
                              color: Color(0xFF45494E),
                              fontSize: 44,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

               SizedBox(height: 15.0),
              Obx(
                () => Container(
                  color: Color(0xffFFE8E5),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  width: double.infinity,
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisSize: MainAxisSize.min, // 使Flex适应其子项
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 40, bottom: 20), // 将上下边距应用于文本
                          child: Text(
                            '不足',
                            style: TextStyle(
                              color: Color.fromRGBO(193, 55, 30, 1),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20, bottom: 15), // 将上下边距应用于文本
                            child: Text(
                              '${controller.insufficientAmount.value}',
                              style: const TextStyle(
                                color: Color.fromRGBO(193, 55, 30, 1),
                                fontSize: 44,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 15.0),

              ///品券
              ScrollbarTheme(
                data: ScrollbarThemeData(
                  thickness: MaterialStateProperty.all(20.0), // 粗细
                  crossAxisMargin: 5.0, // 调整左右间距
                  mainAxisMargin: 0.5,
                  thumbVisibility: MaterialStateProperty.all(true),
                ),
                child: Expanded(
                  child: Container(
                    height: 180,
                    child: Scrollbar(
                      controller: _controller,
                      child: Obx(
                        () => ListView.builder(
                          controller: _controller,
                          itemCount: controller.coupons.length,
                          itemBuilder: (context, index) => CouponItem(
                            title: controller.coupons[index]['title'] ?? '',
                            amount: controller.coupons[index]['amount'] ?? '',
                            count: controller.coupons[index]['count'] ?? '',
                          ),
                        ),
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
}
