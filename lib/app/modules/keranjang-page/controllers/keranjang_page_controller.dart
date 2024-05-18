import 'package:event_digital/app/data/model/model_detail.dart';
import 'package:event_digital/app/routes/app_pages.dart';
import 'package:event_digital/utils/sqlite_helper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

String formatPrice(int productPrice) {
  final formatter = NumberFormat.currency(
    symbol: 'Rp',
    decimalDigits: 0,
    locale: 'id_ID',
  );
  return formatter.format(productPrice);
}

class KeranjangPageController extends GetxController {
  bool isAllChecked = false;
  List<ModelDetail> carts = [];
  List<ModelDetail> cartsSeletected = [];

  @override
  void onReady() async {
    getCart();
    super.onReady();
  }

  checkListAll(bool? value) async {
    isAllChecked = value ?? false;
    update();

    var sqlHelper = await SqlLiteHelper.instance.cartTable;
    await sqlHelper.updateCheckedAllProduct(isAllChecked ? 1 : 0);

    getCart();
  }

  void updateCheckboxValue(String id, int check) async {
    var sqlHelper = await SqlLiteHelper.instance.cartTable;
    var result = await sqlHelper.updateCheckedProduct(id, check);

    if (result == 1) {
      getCart();
    }
    if (check == 0) {
      isAllChecked = false;
    }
    update();
  }

  int getCheckedItemCount() {
    return carts.where((item) => item.checked == 1).length;
  }

  getCart() async {
    var sqlHelper = await SqlLiteHelper.instance.cartTable;
    carts = await sqlHelper.getAllCart();

    update();
  }

  delete() async {
    var sqlHelper = await SqlLiteHelper.instance.cartTable;
    await sqlHelper.deleteCartProduct();
  }

  deleteCart() async {
    await delete();
    getCart();
    Get.back();
  }

  String calculateTotalPrice() {
    int totalPrice = 0;
    for (var cartPengirim in carts) {
      if (cartPengirim.checked != null) {
        // Assuming 'checked' is a property indicating whether the item is checked
        totalPrice = totalPrice + (cartPengirim.data!.attributes?.price ?? 0);
      }
    }
    return formatPrice(totalPrice);
  }

  goToPengiriman() async {
    var sqlHelper = await SqlLiteHelper.instance.cartTable;
    var checked = await sqlHelper.getCheckedCart();

    Get.toNamed(Routes.CHECKOUT_PAGE, arguments: {
      'product': checked,
      'from': 'keranjang',
      // 'harga': harga,
    });
  }

  // ModelGetProfile? users;
  // getProfile(String id) async {
  //   var data = await ApiServices().getProfile(id);
  //   if (data != null) {
  //     users = data;
  //     update();
  //     delivery();
  //   }
  // }
}

class CheckboxItem {
  bool value;
  CheckboxItem({required this.value});
}
