import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/app/ui/page/detail/controller/right_section_controller.dart';
import 'package:test_app/app/ui/page/detail/component/promotion_item.dart';
import 'package:test_app/app/ui/page/detail/component/payment_method_item.dart';
import 'package:test_app/app/ui/page/detail/component/machine_item.dart';

class RightSection extends StatelessWidget {
  final RightSectionController controller = Get.put(RightSectionController());
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 10.0, right: 30),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                for (var i = 0; i < 2; i++) // 只循环前两个项目
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: PromotionItem(
                      title: controller.promotions[i]['title'] ?? '',
                      onTap: () => controller.gotoDiscountPage(),
                      width: 110,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(219, 231, 252, 1),
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: Color.fromRGBO(149, 162, 203, 1.0),
                          width: 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: GestureDetector(
                    onTap: () => controller.gotoDiscountPage(),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          bottomLeft: Radius.circular(5.0),
                        ),
                      ),
                      width: 220, // 宽度220
                      height: 70,
                      child: Flex(
                        direction: Axis.horizontal,

                        // 创建一个行布局，包含两个项目
                        children: [
                          _buildPromotionItem(2), // 第三个项目
                          _buildPromotionItem(3), // 第四个项目
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: const Color.fromRGBO(219, 231, 252, 1),
                  width: 50,
                  height: 70,
                  child: IconButton(
                    onPressed: () => controller.gotoDiscountPage(),
                    icon: Icon(Icons.expand_more, color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
          ),

          ///支払い方法一覧
          Flex(
            direction: Axis.vertical,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
                child: Card(
                  child: Container(
                   // width: MediaQuery.of(context).size.width * 0.45,
                    width: double.infinity,
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Obx(
                            () => Container(
                              height: 335, // 设置固定高
                              child: Stack(
                                children: [
                                  // 右侧显示滚动滑轮
                                  Scrollbar(
                                    controller: _controller,
                                    thumbVisibility: true,
                                    thickness: 20.0,
                                    child: GridView.count(
                                      controller: _controller,
                                      padding: const EdgeInsets.all(25.0),
                                      // 设置间隔
                                      shrinkWrap: true,
                                      crossAxisCount: 4,
                                      childAspectRatio: 1,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      children: controller.paymentMethods
                                          .map((method) => Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: PaymentMethodItem(
                                                  title: method["title"] ?? '',
                                                  icon: controller.icons[
                                                          method["icon"]] ??
                                                      Icons.error,
                                                  onTap: () {
                                                    controller
                                                        .gotoDiscountPage();
                                                  },
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                  // 底部渐变效果
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: 40, // 渐变效果的高度
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Colors.grey.withOpacity(0.3),
                                            // 底部30%透明度
                                            Colors.grey.withOpacity(0.0),
                                            // 顶部0%透明度
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 55.0), // 这里设置了15px的间隙
                        ///精算機一覧
                        Container(
                          margin: const EdgeInsets.only(top: 0.0),
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 150,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Obx(
                              () => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: controller.machines
                                    .map(
                                      (machine) => Expanded(
                                        child: MachineItem(
                                          width: 110, // 你可以根据需要调整这些参数
                                          height: 110,
                                          title: machine["title"] ?? '',
                                          status: machine["status"] ?? '',
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget _buildPromotionItem(int index) {
    return Expanded(
      child: Center(
        child: Text(
          controller.promotions[index]['title'] ?? '',
          style: const TextStyle(
            fontSize: 18,
            color: Color.fromRGBO(69, 73, 78, 1),
          ),
        ),
      ),
    );
  }
}
