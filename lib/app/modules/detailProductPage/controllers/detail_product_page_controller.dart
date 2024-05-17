import 'package:event_digital/app/data/model/model_detail.dart';
import 'package:event_digital/app/data/services/api_services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailProductPageController extends GetxController {
  ModelDetail? detailProduct;
  String? imageUrl;
  bool? isLogin;
  getDetailProduct(int id) async {
    var data = await ApiServices().getDetail(id);
    detailProduct = data;
    update();
  }

  String formatPrice(num productPrice) {
    final formatter = NumberFormat.currency(
      symbol: 'Rp',
      decimalDigits: 0,
      locale: 'id_ID',
    );
    return formatter.format(productPrice);
  }

  String? image;
  @override
  void onReady() {
    Map<String, dynamic>? arguments = Get.arguments;
    var arg1 = arguments?['productId'];
    var arg2 = arguments?['image'];
    image = arg2;
    update();

    getDetailProduct(arg1);
    super.onReady();
  }
}
