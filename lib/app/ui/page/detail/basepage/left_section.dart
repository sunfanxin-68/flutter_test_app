import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/app/ui/page/detail/component/coupon_item.dart';
import 'package:test_app/app/ui/page/detail/controller/left_section_controller.dart';

class LeftSection extends StatelessWidget {
  final controller = Get.put(LeftSectionController());

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '优惠金额: ${controller.discountAmount.value}元',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            )),
            SizedBox(height: 8.0),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('总共'),
                    Text('${controller.totalItems.value}件'),
                  ],
                ),
                Text('${controller.totalAmount.value}元'),
              ],
            )),
            SizedBox(height: 8.0),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('收款金额'),
                Text('${controller.receivedAmount.value}元'),
              ],
            )),
            SizedBox(height: 8.0),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '不足',
                  style: TextStyle(color: Colors.red),
                ),
                Container(
                  color: Colors.red,
                  child: Text(
                    '${controller.insufficientAmount.value}元',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )),
            SizedBox(height: 8.0),
            Container( // 用 Container 给 ListView.builder 设定一个高度
              height: 200, // 可以根据你的实际需要调整
              child: Obx(() => ListView.builder(
                itemCount: controller.coupons.length,
                itemBuilder: (context, index) => CouponItem(
                  title: controller.coupons[index]['title'] ?? '',
                  amount: controller.coupons[index]['amount'] ?? '',
                  count: controller.coupons[index]['count'] ?? '',
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
