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

int parseAmount(String amountString) {
  print("Original String: $amountString"); // 打印原始的字符串
  // 替换非数字字符
  String cleanString = amountString.replaceAll('￥', '').replaceAll(',', '');
  print("Cleaned String: $cleanString"); // 打印经过清洁处理的字符串
  int parsedInt = int.parse(cleanString);
  print("Parsed Integer: $parsedInt"); // 打印解析后的整数
  return int.parse(cleanString);
}

class SubtotalController extends GetxController {
  var selectedDiscount = ''.obs; // 折扣率，默认为1表示无折扣
  var keyboardAmount = ''.obs; // 从数字键盘获取的金额
  var discountAmount = ''.obs; // 割引額
  var registerNumber = "".obs; // 登録番号
  var totalItems = "".obs; // 商品の合計数
  var totalAmount = "".obs; // 合計金額
  var receivedAmount = "".obs; // 受け取った金額
  var insufficientAmount = "".obs; // 不足金額
  var totalDiscount = "".obs; //値引き合計額

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
    discountAmount.value = _formatAmount(1111111); // 割引額の初期化
    totalDiscount.value = _formatAmount(0); //値引き合計額の初期化
    totalItems.value = _formatAmount(1111111, false); // 商品の合計数の初期化
    totalAmount.value = _formatAmount(1111111); // 合計金額の初期化
    receivedAmount.value = _formatAmount(1111111); // 受け取った金額の初期化
    insufficientAmount.value = _formatAmount(1111111); // 不足金額の初期化
    registerNumber.value = "1"; // 登録番号の初期化
    selectedDiscount.value = _formatAmount(1); // 折扣率，默认为1表示无折扣
    keyboardAmount.value = _formatAmount(1111111); // 从数字键盘获取的金额

    // fetchCoupons(); // 初期化時にクーポンを取得
  }

  // 设置折扣率并重新计算折后金额
  void setDiscountRate(double rate) {
    // 更新selectedDiscount的值为传入的rate
    selectedDiscount.value = rate.toString();

    // 使用新的折扣率重新计算折后金额
    calculateDiscountAmount();
  }

// 设置从数字键盘输入的金额并重新计算折后金额
  void setKeyboardAmount(double amount) {
    // 更新keyboardAmount的值为传入的amount
    keyboardAmount.value = amount.toString();

    // 使用新的输入金额重新计算折后金额
    calculateDiscountAmount();
  }

  // 割引値リスト
  final List<String> discountValues = [
    '10%',
    '20%',
    '30%',
    '40%',
    '50%',
  ];

  int parseDiscount(String discountStr) {
    String cleanString = discountStr
        .replaceAll('%', '')
        .replaceAll('￥', '')
        .replaceAll(',', '')
        .trim();
    print("打印原始的字符串: $discountStr"); // 打印原始的字符串
    print("打印经过清洁处理的字符串: $cleanString"); // 打印经过清洁处理的字符串
    return int.parse(cleanString);
  }

// 计算折后金额
  void calculateDiscountAmount() {
    // 使用parseAmount方法转换字符串为整数
    int totalAmountInt = parseAmount(totalAmount.value);
    int selectedDiscountInt = parseDiscount(selectedDiscount.value);
    int keyboardAmountInt = parseAmount(keyboardAmount.value);

    // 计算discountedAmount
    double discountFactor = 1 - (selectedDiscountInt / 100.0);
    int finalAmount = (totalAmountInt * discountFactor).toInt(); // 这就是经过折扣后的最终金额

    // 考虑键盘输入金额
    finalAmount = finalAmount - keyboardAmountInt;

    // 计算总的折扣金额
    int totalDiscountValue = totalAmountInt - finalAmount;

    // 更新observable值
    totalDiscount.value = _formatAmount(totalDiscountValue);
    discountAmount.value = _formatAmount(finalAmount);

    print("Total Amount: $totalAmountInt");
    print("Discount: $selectedDiscountInt%");
    print("Discount Factor: $discountFactor");
    print("Discounted Amount (Final Amount before keyboard input): $finalAmount");
    print("keyboardAmount: $keyboardAmountInt");
    print("Total Discount: $totalDiscountValue");
  }




  //您可以在SubtotalController中定义一个新的公共方法，该方法内部调用_formatAmount。
  String formatAmountForOutside(int amount,
      [bool includeCurrencySymbol = true]) {
    return _formatAmount(amount, includeCurrencySymbol);
  }

  // 在 SubtotalController 控制器内添加一个触发金额计算的方法：
  void triggerDiscountCalculation() {
    calculateDiscountAmount();
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
        textEditingController.text = textEditingController.text
            .substring(0, textEditingController.text.length - 1);
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
