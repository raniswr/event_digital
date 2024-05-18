import 'package:event_digital/app/data/model/model_detail.dart';
import 'package:event_digital/app/data/model/model_product.dart';
import 'package:event_digital/app/data/services/api_services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailProductPageController extends GetxController {
  ModelDetail? detailProduct;
  ImageProduct? images;
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

  @override
  void onReady() {
    Map<String, dynamic>? arguments = Get.arguments;
    var arg1 = arguments?['productId'];
    images = arguments?['image'] as ImageProduct?;
    update();

    getDetailProduct(arg1);
    super.onReady();
  }
}
