import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:test_app/app/ui/page/detail/controller/right_section_controller.dart';
import 'package:test_app/app/ui/page/detail/component/promotion_item.dart';
import 'package:test_app/app/ui/page/detail/component/payment_method_item.dart';
import 'package:test_app/app/ui/page/detail/component/machine_item.dart';

class RightSection extends StatelessWidget {
  final controller = Get.put(RightSectionController());

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() {
  final screenWidth = MediaQuery.of(context).size.width * 0.5;
  final itemWidth = (screenWidth - 100) / 3; // subtracting total padding (10*4)
  final totalPromotions = controller.promotions.length;
  final displayPromotionsCount = controller.showMorePromotions.value ? totalPromotions : min(3, totalPromotions);
  return Column(
    children: <Widget>[
      for (var i = 0; i < displayPromotionsCount; i += 3)
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0), // space between the rows
          child: Row(
            children: <Widget>[
              if (i < displayPromotionsCount) ...[
                PromotionItem(
                  title: controller.promotions[i]["title"] ?? '',
                  onTap: controller.toggleShowMorePromotions,
                  width: itemWidth,
                ),
                SizedBox(width: 10), // space between the boxes
              ],
              if (i + 1 < displayPromotionsCount) ...[
                PromotionItem(
                  title: controller.promotions[i+1]["title"] ?? '',
                  onTap: controller.toggleShowMorePromotions,
                  width: itemWidth,
                ),
                SizedBox(width: 10), // space between the boxes
              ],
              if (i + 2 < displayPromotionsCount)
                PromotionItem(
                  title: controller.promotions[i+2]["title"] ?? '',
                  onTap: controller.toggleShowMorePromotions,
                  width: itemWidth,
                ),
            ],
          ),
        ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          IconButton(
            onPressed: controller.toggleShowMorePromotions,
            icon: Icon(
              controller.showMorePromotions.value
                  ? Icons.expand_less
                  : Icons.expand_more,
            ),
          ),
        ],
      ),
    ],
  );
}),
            SizedBox(height: 16.0),
            Obx(() => ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 200.0), // 这个值设置为你想要的高度
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    childAspectRatio: 1, // 这个值设置为 1 可以保证网格中的每个子项是一个正方形
                    mainAxisSpacing: 10, // 主轴间距，可调整为你想要的值
                    crossAxisSpacing: 10, // 横轴间距，可调整为你想要的值
                    children: controller.paymentMethods
                        .map((method) => Padding(
                              padding: const EdgeInsets.all(8.0), // 设置每个项目的边距
                              child: PaymentMethodItem(
                                title: method["title"] ?? '',
                                imageUrl: method["imageUrl"] ?? '',
                              ),
                            ))
                        .toList(),
                  ),
                )),
            SizedBox(height: 16.0),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: controller.machines
                      .map((machine) => MachineItem(
                            title: machine["title"] ?? '',
                            status: machine["status"] ?? '',
                          ))
                      .toList(),
                )),
          ],
        ),
      ),
    );
  }
}
