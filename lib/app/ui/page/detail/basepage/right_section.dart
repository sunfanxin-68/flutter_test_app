import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/app/ui/page/detail/component/promotion_item.dart';
import 'package:test_app/app/ui/page/detail/component/payment_method_item.dart';
import 'package:test_app/app/ui/page/detail/component/machine_item.dart';

import '../controller/subtotal2_controller.dart';
import 'discount_section.dart';

class RightSection extends StatelessWidget {
  final SubtotalController controller = Get.find();
  final ScrollController _scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.showDiscountSection.value) {
        return DiscountSection();
      } else {
        return _buildRightContent(context);  // 包含RightSection的原始内容
      }
    });
  }

  Widget _buildRightContent(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        _buildPromotionSection(),
        _buildPaymentMethodsSection(context),
        _buildMachinesSection(context),
      ],
    );
  }

  Widget _buildPromotionSection() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          for (var i = 0; i < 2; i++) // 只循环前两个项目
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 0),
              child: PromotionItem(
                title: controller.promotions[i]['title'] ?? '',
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
              onPressed: controller.toggleDiscountSection,
              icon: Icon(Icons.expand_more, color: Colors.blueAccent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodsSection(BuildContext context) {
    // 使用Padding作为父组件，添加顶部边距
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Card(
        // 创建一个Card组件
        child: Container(
          // 创建一个Container组件
          width: 536, // 设置Container的宽度
          child: Obx(
            // Obx用于响应式状态管理
            () => Container(
              height: 300, // 设置Container的高度
              child: Stack(
                // Stack组件，用于叠加多个子组件
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10, right: 10),
                    child: Scrollbar(
                      // Scrollbar组件，为滚动组件提供滚动条
                      controller: _scrollController, // 设置滚动控制器
                      thumbVisibility: true, // 设置滚动条始终可见
                      thickness: 20.0, // 设置滚动条的厚度
                      child: GridView.count(
                        // GridView组件，用于创建网格列表
                        controller: _scrollController, // 设置滚动控制器
                        // 设置滚动控制器
                        padding: const EdgeInsets.only(
                            top: 10, left: 20, right: 30.0),
                        // 设置GridView的内边距
                        shrinkWrap: true,
                        // 使GridView的尺寸尽可能小
                        physics: const AlwaysScrollableScrollPhysics(),
                        // 滚动效果
                        crossAxisCount: 4,
                        // 设置列数
                        childAspectRatio: 1,
                        // 设置子项的长宽比
                        mainAxisSpacing: 10,
                        // 设置行间距
                        crossAxisSpacing: 10,
                        // 设置列间距
                        // map函数遍历controller.paymentMethods列表，为每个元素创建一个Padding组件
                        children: controller.paymentMethods
                            .map(
                              (method) => Padding(
                                padding: const EdgeInsets.all(2.0), // 设置内边距
                                child: PaymentMethodItem(
                                  // 创建PaymentMethodItem组件
                                  title: method["title"] ?? '', // 设置标题
                                  icon: controller.icons[method["icon"]] ??
                                      Icons.error, // 设置图标
                                  onTap: () {},
                                ),
                              ),
                            )
                            .toList(), // 转换为List
                      ),
                    ),
                  ),
                  Positioned(
                    // Positioned组件，用于定位Stack中的子组件
                    bottom: 0, // 设置距离底部的位置
                    left: 0, // 设置距离左侧的位置
                    right: 0, // 设置距离右侧的位置
                    child: Container(
                      // 创建Container组件
                      height: 40, // 设置Container的高度
                      decoration: BoxDecoration(
                        // 设置装饰
                        gradient: LinearGradient(
                          // 线性渐变
                          begin: Alignment.bottomCenter, // 渐变的开始位置
                          end: Alignment.topCenter, // 渐变的结束位置
                          colors: [
                            // 渐变的颜色列表
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
    );
  }

  Widget _buildMachinesSection(BuildContext context) {
    double itemSize = MediaQuery.of(context).size.width * 0.45 / 3; // 3分之一的宽度
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 20.0),
        color: Colors.white,
        child: Container(
          width: 536,
          height: itemSize, // 设置高度以考虑顶部间距
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 5),
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
                padding: const EdgeInsets.only(top: 10, right: 20),

                // 距离顶部10
                children: controller.machines
                    .map(
                      (machine) => MachineItem(
                        width: 110, // 根据需求设置宽高
                        height: 110,
                        title: machine["title"] ?? '',
                        status: machine["status"] ?? '',
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPromotionItem(int index) {
    return Padding(
      padding: const EdgeInsets.only(left:10.0), // 添加10的间距
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
