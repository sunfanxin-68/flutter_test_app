import 'package:get/get.dart';

class LeftSectionController extends GetxController {
  // define your state variables as observable using `.obs`
  var discountAmount = (-100).obs;
  var totalItems = 10.obs;
  var totalAmount = 1000.obs;
  var receivedAmount = 2000.obs;
  var insufficientAmount = 1000.obs;

  var coupons = List<Map<String, String>>.generate(
    10,
    (index) => {
      'title': '优惠券${index + 1}',
      'amount': '100元',
      'count': '${10 - index}枚',
    },
  ).obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchCoupons();  // fetch coupons when controller is initialized
  // }

  // void fetchCoupons() {
  //   // here you can fetch your coupons from an API, database, etc.
  //   // and then assign them to your coupons list.
  //   // this is just a dummy data.
  //   coupons.assignAll([
  //     {'title': '优惠券1', 'amount': '100元', 'count': '10枚'},
  //     {'title': '优惠券2', 'amount': '200元', 'count': '5枚'},
  //     // more coupons...
  //   ]);
  // }
}
