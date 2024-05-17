import 'package:event_digital/app/data/services/user_services.dart';
import 'package:event_digital/app/routes/app_pages.dart';
import 'package:get/get.dart';

class IntroPageController extends GetxController {
  //TODO: Implement IntroPageController

  @override
  void onReady() async {
    var dataLogin = await UserService.find.getLocalUser();

    if (dataLogin != null) {
      Get.offAllNamed(Routes.HOME);
    }

    super.onReady();
  }
}
