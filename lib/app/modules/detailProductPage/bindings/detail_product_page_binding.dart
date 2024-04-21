import 'package:get/get.dart';

import '../controllers/detail_product_page_controller.dart';

class DetailProductPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailProductPageController>(
      () => DetailProductPageController(),
    );
  }
}
