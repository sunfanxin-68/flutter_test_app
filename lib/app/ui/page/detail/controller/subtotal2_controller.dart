import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

String _formatAmount(int amount, [bool isCurrency = true]) {
  final formatter = NumberFormat('#,##0', 'ja_JP'); // 日本のカンマ区切りの書式設定
  return isCurrency
      ? '￥${formatter.format(amount)}' // 通貨記号付き
      : '${formatter.format(amount)}'; // 通貨記号なし
}

class SubtotalController extends GetxController {


  var registerNumber = "".obs; // 登録番号
  var discountAmount = "".obs; // 割引額
  var totalItems = "".obs; // 商品の合計数
  var totalAmount = "".obs; // 合計金額
  var receivedAmount = "".obs; // 受け取った金額
  var insufficientAmount = "".obs; // 不足金額

  // クーポンリストの生成
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
    discountAmount.value = _formatAmount(-1111111); // 割引額の初期化
    totalItems.value = _formatAmount(1111111, false); // 商品の合計数の初期化
    totalAmount.value = _formatAmount(1111111); // 合計金額の初期化
    receivedAmount.value = _formatAmount(1111111); // 受け取った金額の初期化
    insufficientAmount.value = _formatAmount(1111111); // 不足金額の初期化
    registerNumber.value = "1"; // 登録番号の初期化

    // fetchCoupons(); // 初期化時にクーポンを取得
  }

  // プロモーションリスト
  final promotions = [
    {"title": "子育て割引"},
    {"title": "シニア割引"},
    {"title": "小計値引き"},
    {"title": "小計割引き"},
  ].obs;

  // アイコンのマッピング
  final Map<String, IconData> icons = {
    "Money": Icons.money,
    "credit_score": Icons.credit_score,
    "account_balance_wallet": Icons.account_balance_wallet,
    "point_of_sale": Icons.point_of_sale,
    "credit_card": Icons.credit_card,
    "redeem": Icons.redeem,
  };

  // 支払い方法リスト
  final paymentMethods = [
    {"title": "現金", "icon": "Money"},
    {"title": "クレジット", "icon": "credit_score"},
    {"title": "電子マネー", "icon": "account_balance_wallet"},
    {"title": "ポイント利用", "icon": "point_of_sale"},
    {"title": "プリペイド", "icon": "credit_card"},
    ...List.generate(
        7, (index) => {"title": "品券${index + 1}", "icon": "redeem"}),
  ].obs;

  // 精算機リスト
  final machines = [
    {"title": "精算機1", "status": ""},
    {"title": "精算機2", "status": "使用中"},
    {"title": "精算機3", "status": "休止中"},
    {"title": "精算機4", "status": "ニアエンド"},
  ].obs;

  var showDiscountSection = false.obs; // 割引セクションの表示制御

  void toggleDiscountSection() {
    showDiscountSection.value = !showDiscountSection.value; // 割引セクションの表示を切り替え
  }

  // 割引値リスト
  final List<String> discountValues = [
    '  ',
    '10%',
    '20%',
    '30%',
    '40%',
    '50%',
  ];

  // 割引保存のダイアログ
  void discountSave(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('確定ボタンです'), // 確定ボタンのダイアログ
      ),
    );
  }

  // テキスト入力コントローラ
  final TextEditingController textEditingController = TextEditingController();

  // キーボードの表示

  bool isKeyboardVisible = false;
  // 在这个方法中切换键盘的可见性
  void toggleKeyboard() {
    isKeyboardVisible = !isKeyboardVisible;
    update(); // 如果你使用的是GetX的GetBuilder来构建UI，调用此方法通知观察者刷新
  }

  void onKeyTap(String key, FocusNode focusNode2) {

    if (key == "X") {
      // 如果点击的是 "x" 键，则删除输入框的最后一个字符
      if (textEditingController.text.isNotEmpty) {
        textEditingController.text = textEditingController.text.substring(0,
            textEditingController.text.length - 1);
      }
    } else if (key == "✔️") {
      toggleKeyboard();
      // 如果点击的是 "✔️" 键，则可以确认输入
      focusNode2.unfocus();
    } else if (key == "C") {
      // 如果点击的是 "c" 键，则可以清除输入框的内容
      textEditingController.text = "";
    } else {
      // 否则，假设点击的是数字键，将该数字添加到输入框的内容中
      textEditingController.text += key;
    }
    // 如果你想要在每次键入字符后将光标移动到文本末尾，可以使用以下代码：
    textEditingController.selection =
        TextSelection.collapsed(offset: textEditingController.text.length);
  }

}
