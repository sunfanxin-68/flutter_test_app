import 'package:get/get.dart';
import 'package:flutter/material.dart';


class RightSectionController extends GetxController {
  final promotions = [
    {"title": "子育て割引"},
    {"title": "シニア割引"},
    {"title": "小計値引き"},
    {"title": "小計割引き"},

  ].obs;



  final Map<String, IconData> icons = {
    "Money": Icons.money,
    "credit_score": Icons.credit_score,
    "account_balance_wallet": Icons.account_balance_wallet,
    "point_of_sale": Icons.point_of_sale,
    "credit_card": Icons.credit_card,
    "redeem": Icons.redeem,
  };

  final paymentMethods = [
    {"title": "現金", "icon": "Money"},
    {"title": "クレジット", "icon": "credit_score"},
    {"title": "電子マネー", "icon": "account_balance_wallet"},
    {"title": "ポイント利用", "icon": "point_of_sale"},
    {"title": "プリペイド", "icon": "credit_card"},
    ...List.generate(
        7,
            (index) => {"title": "品券${index + 1}", "icon": "redeem"}
    ),
  ].obs;

  final machines = [
    {"title": "精算機1", "status": ""},
    {"title": "精算機2", "status": "使用中"},
    {"title": "精算機3", "status": "休止中"},
    {"title": "精算機4", "status": "ニアエンド"},
  ].obs;

  //final showMorePromotions = false.obs;

  // void toggleShowMorePromotions() {
  //   showMorePromotions.value = !showMorePromotions.value;
  // }
  void gotoDiscountPage() {
    // Get.to(DiscountSection());
  }

}
