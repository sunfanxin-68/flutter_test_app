import 'package:get/get.dart';

class RightSectionController extends GetxController {
  final promotions = [
    {"title": "优惠1"},
    {"title": "优惠2"},
    {"title": "优惠3"},
    {"title": "优惠4"},
    {"title": "优惠5"},
  ].obs;

  final paymentMethods = List.generate(
    16,
    (index) => {"title": "支付方法${index + 1}", "image": ""},
  ).obs;

  final machines = [
    {"title": "机器1", "status": ""},
    {"title": "机器2", "status": "使用中"},
    {"title": "机器3", "status": ""},
    {"title": "机器4", "status": "停止中"},
  ].obs;

  final showMorePromotions = false.obs;

  void toggleShowMorePromotions() {
    showMorePromotions.value = !showMorePromotions.value;
  }
}
