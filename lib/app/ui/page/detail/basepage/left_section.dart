import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/app/ui/page/detail/component/coupon_item.dart';
import 'package:test_app/app/ui/page/detail/controller/left_section_controller.dart';

class SubTabWidget extends StatelessWidget {
  final controller = Get.put(LeftSectionController());

  SubTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 18),
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
    );
  }
}

class LeftSection extends StatelessWidget {
  final controller = Get.put(LeftSectionController());

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0.0, left: 10.0),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            color: Color.fromRGBO(242, 243, 244, 1),
            child: Flex(
              direction: Axis.vertical,
              children: [
                Obx(() => Padding(
                      padding: EdgeInsets.only(top: 27.0, right: 20),
                      // 设置距离顶部的间距
                      child: Flex(
                        direction: Axis.horizontal, // 设置方向为水平
                        mainAxisAlignment: MainAxisAlignment.end, // 从右到左排列
                        children: [
                          Text(
                            '値引き合計',
                            style: TextStyle(
                              color: Color.fromRGBO(193, 55, 30, 1),
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            '　${controller.discountAmount.value}',
                            style: TextStyle(
                              color: Color.fromRGBO(193, 55, 30, 1),
                              fontSize: 28,
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox(height: 40.0),
                Obx(
                  () => Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        //   flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '合計',
                                style: TextStyle(
                                  color: Color(0xFF45494E),
                                  fontSize: 22,
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${controller.totalItems.value} 点',
                                        style: TextStyle(
                                          color: Color(0xFF45494E),
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
                                            color: Color(0xFF45494E),
                                            fontSize: 34,
                                          ),
                                          textAlign: TextAlign.right,
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
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  // 左右边距为10
                  child: Divider(color: Colors.grey, thickness: 2.0),
                ),
                SizedBox(height: 15.0),
                Obx(
                  () => Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 20), // 左边距为20
                          child: Text(
                            'お預かり金額',
                            style: TextStyle(
                              color: Color.fromRGBO(69, 73, 78, 1),
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 20), // 右边距为20
                            child: Text(
                              '${controller.receivedAmount.value}',
                              style: TextStyle(
                                color: Color(0xFF45494E),
                                fontSize: 44,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.0),
                Obx(
                  () => Container(
                    color: Color.fromRGBO(255, 232, 229, 1),
                    width: double.infinity,
                    height: 90,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        const Expanded(
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 40, left: 20, bottom: 20),
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
                                  right: 20, top: 20, bottom: 15),
                              child: Text(
                                '${controller.insufficientAmount.value}',
                                style: const TextStyle(
                                    color: Color.fromRGBO(193, 55, 30, 1),
                                    fontSize: 44),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.0),

                  Container(
                    // 用 Container 给 ListView.builder 设定一个高度
                    height: 180, // 可以根据你的实际需要调整
                    child: Obx(
                      () => ListView.builder(
                        itemCount: controller.coupons.length,
                        itemBuilder: (context, index) => CouponItem(
                          title: controller.coupons[index]['title'] ?? '',
                          amount: controller.coupons[index]['amount'] ?? '',
                          count: controller.coupons[index]['count'] ?? '',
                        ),
                      ),
                    ),
                  ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
