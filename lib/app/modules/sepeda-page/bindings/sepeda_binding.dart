import 'package:get/get.dart';

import '../controllers/sepeda_controller.dart';

class SepedaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SepedaController>(
      () => SepedaController(),
    );
  }
}
