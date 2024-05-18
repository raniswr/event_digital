import 'package:event_digital/app/data/model/model_user.dart';
import 'package:event_digital/app/data/services/api_services.dart';
import 'package:event_digital/app/data/storage_method.dart';
import 'package:event_digital/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(BuildContext context) async {
    var result = await ApiServices.login(email: usernameController.text, password: passwordController.text);

    if (result != null) {
      var user = ModelUser(
        token: result.jwt,
        username: result.user?.username,
        phone: result.user?.phoneNo,
        id: result.user?.id,
        email: result.user?.email,
        alamat: result.user?.address,
        isLogin: true,
        password: passwordController.text,
      );

      await StorageMethod.saveUserToLocal(user);
      update();
      Get.offAllNamed(Routes.HOME);
    }
  }
}
