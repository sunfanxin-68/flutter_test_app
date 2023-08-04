import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/app/ui/page/detail/controller/right_section_controller.dart';
import 'package:test_app/app/ui/page/detail/component/promotion_item.dart';
import 'package:test_app/app/ui/page/detail/component/payment_method_item.dart';
import 'package:test_app/app/ui/page/detail/component/machine_item.dart';

class RightSection extends StatelessWidget {
  final RightSectionController controller = Get.put(RightSectionController());
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Flex(
        direction: Axis.vertical,
        children: <Widget>[
          _buildPromotionSection(),
          _buildPaymentMethodsSection(context),
          _buildMachinesSection(context),
        ],
      );
    });
  }

  Widget _buildPromotionSection() {
    return Expanded(
      child: Flex(
        direction: Axis.horizontal,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          for (var i = 0; i < 2; i++) // 只循环前两个项目
            Padding(
              padding: const EdgeInsets.only(left:15,right: 0),
              child: PromotionItem(
                title: controller.promotions[i]['title'] ?? '',
                onTap: () => controller.gotoDiscountPage(),
                width: 110,
                height: 70,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(219, 231, 252, 1),
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: Color.fromRGBO(55, 75, 186, 0.5),
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
          Expanded(
              child: GestureDetector(
                onTap: () => controller.gotoDiscountPage(),
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      bottomLeft: Radius.circular(5.0),
                    ),
                  ),
                //  width: 150, // 宽度220
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
            width: 40,
            height: 70,
            child: IconButton(
              onPressed: () => controller.gotoDiscountPage(),
              icon: Icon(Icons.expand_more, color: Colors.blueAccent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodsSection(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 0),
          child: Card(
            child: Container(
              width: 536,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Obx(
                  () => Container(
                    height: 335,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10), // 设置右侧边距为10
                          child: Scrollbar(
                            controller: _scrollController,
                            isAlwaysShown: true,
                            thickness: 20.0,
                            child: GridView.count(
                              controller: _scrollController,
                              padding: const EdgeInsets.only(
                                  top: 10, left: 20, right: 30.0),
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              crossAxisCount: 4,
                              childAspectRatio: 1,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              children: controller.paymentMethods
                                  .map((method) => Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: PaymentMethodItem(
                                          title: method["title"] ?? '',
                                          icon: controller
                                                  .icons[method["icon"]] ??
                                              Icons.error,
                                          onTap: () {
                                            controller.gotoDiscountPage();
                                          },
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.grey.withOpacity(0.6),
                                  Colors.grey.withOpacity(0.0),
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
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMachinesSection(BuildContext context) {
    double itemSize = MediaQuery.of(context).size.width * 0.45 / 4; // 四分之一的宽度
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      color: Colors.white,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            //width: MediaQuery.of(context).size.width * 0.45,
            width: 536,
            height: itemSize + 50, // 设置高度以考虑顶部间距
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Obx(
                () => GridView.count(
                  crossAxisCount: 4,
                  // 一行四个
                  childAspectRatio: 1,
                  // 宽高比为1
                  mainAxisSpacing: 10,
                  // 每个item距离顶部10
                  crossAxisSpacing: 5,
                  // 每个间隔5
                  padding: const EdgeInsets.only(top: 10, right: 10),
                  // 距离顶部10
                  children: controller.machines
                      .map(
                        (machine) => MachineItem(
                          width: itemSize, // 根据需求设置宽高
                          height: itemSize,
                          title: machine["title"] ?? '',
                          status: machine["status"] ?? '',
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
