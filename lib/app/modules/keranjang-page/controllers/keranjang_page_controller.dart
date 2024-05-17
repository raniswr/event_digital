import 'package:event_digital/app/data/model/model_detail.dart';
import 'package:event_digital/app/routes/app_pages.dart';
import 'package:event_digital/utils/sqlite_helper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class KeranjangPageController extends GetxController {
  bool isAllChecked = false;
  List<ModelDetail> carts = [];
  List<ModelDetail> cartsPengiriman = [];
  int? count;

  @override
  void onReady() async {
    getCart();
    // getProfile(UserService.find.user?.id ?? '');
    super.onReady();
  }

  checkListAll(bool? value) async {
    isAllChecked = value ?? false;
    update();

    var sqlHelper = await SqlLiteHelper.instance.cartTable;
    await sqlHelper.updateCheckedAllProduct(isAllChecked ? 1 : 0);

    getCart();
  }

  String calculateTotalPrice() {
    int totalPrice = 0;
    for (var cartPengirim in cartsPengiriman) {
      if (cartPengirim.checked != null) {
        // Assuming 'checked' is a property indicating whether the item is checked
        totalPrice += (cartPengirim.data!.attributes?.price ?? 0);
      }
    }
    return formatPrice(totalPrice);
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

  getCartCheck() async {
    var sqlHelper = await SqlLiteHelper.instance.cartTable;
    cartsPengiriman = await sqlHelper.getCheckedCart();
    update();
  }

  String formatPrice(int productPrice) {
    final formatter = NumberFormat.currency(
      symbol: 'Rp',
      decimalDigits: 0,
      locale: 'id_ID',
    );
    return formatter.format(productPrice);
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

  delete() async {
    var sqlHelper = await SqlLiteHelper.instance.cartTable;
    await sqlHelper.deleteCartProduct();
  }

  deleteCart() async {
    await delete();
    getCart();
    Get.back();
  }

  goToPengiriman() async {
    await getCartCheck();

    Get.toNamed(Routes.CHECKOUT_PAGE, arguments: {
      'product': cartsPengiriman,
      'from': 'keranjang',
      // 'harga': harga,
    });
  }
}

class CheckboxItem {
  bool value;
  CheckboxItem({required this.value});
}
