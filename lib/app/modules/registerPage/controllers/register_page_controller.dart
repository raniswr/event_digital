import 'package:event_digital/app/data/services/api_services.dart';
import 'package:event_digital/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPageController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void register(BuildContext context) async {
    var result =
        await ApiServices.register(email: emailController.text, password: passwordController.text, username: usernameController.text, address: alamatController.text, phone: phoneController.text);

    if (result != null) {
      Get.offAllNamed(Routes.LOGIN_PAGE);
    }
  }
}
