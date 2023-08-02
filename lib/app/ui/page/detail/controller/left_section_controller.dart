import 'package:get/get.dart';
import 'package:intl/intl.dart';

String _formatAmount(int amount, [bool isCurrency = true]) {
  final formatter = NumberFormat('#,##0', 'ja_JP');
  return isCurrency ? '￥${formatter.format(amount)}'
      : '${formatter.format(amount)}';
}


class LeftSectionController extends GetxController {
  var registerNumber = "".obs;
  var discountAmount = "".obs;
  var totalItems = "".obs;
  var totalAmount = "".obs;
  var receivedAmount = "".obs;
  var insufficientAmount = "".obs;

  var coupons = List<Map<String, String>>.generate(
    10,
        (index) => {
      'title': '品券${index + 1}',
      'amount': '￥10,000',
      'count': '${111 - index}枚',
    },
  ).obs;

  @override
  void onInit() {
    super.onInit();
    discountAmount.value = _formatAmount(-1111111);
    totalItems.value = _formatAmount(1111111, false);
    totalAmount.value = _formatAmount(1111111);
    receivedAmount.value = _formatAmount(1111111);
    insufficientAmount.value = _formatAmount(1111111);
    registerNumber.value = "1";

   // fetchCoupons();  // fetch coupons when controller is initialized
  }
  //
  // void fetchCoupons() {
  //   // here you can fetch your coupons from an API, database, etc.
  //   // and then assign them to your coupons list.
  //   // this is just a dummy data.
  //   coupons.assignAll([
  //     {'title': '优惠券1', 'amount': _formatAmount(100), 'count': '10枚'},
  //     {'title': '优惠券2', 'amount': _formatAmount(200), 'count': '5枚'},
  //     // more coupons...
  //   ]);
  // }
}

