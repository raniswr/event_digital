import 'package:event_digital/app/data/services/api_services.dart';
import 'package:event_digital/app/data/services/user_services.dart';
import 'package:event_digital/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  TextEditingController passwordControllerProfile = TextEditingController();
  bool passwordVisible = true;
  TextEditingController passwordKonfirmasiController = TextEditingController();
  // bool autoValidate = false;
  bool passwordKonfirmasiVisible = true;
  TextEditingController passwordKataSandiBaruController = TextEditingController();
  bool passwordKataSandiBaruVisible = true;
  TextEditingController passwordController = TextEditingController();
  passwordVisibility() {
    passwordVisible = !passwordVisible;
    update();
  }

  passwordKonfirmasiVisibility() {
    passwordKonfirmasiVisible = !passwordKonfirmasiVisible;
    update();
  }

  passwordKataSandiBaruVisibility() {
    passwordKataSandiBaruVisible = !passwordKataSandiBaruVisible;
    update();
  }

  void changePassword(BuildContext context) async {
    var result = await ApiServices.changePassword(
      oldPassword: passwordController.text,
      newPassword: passwordKataSandiBaruController.text,
      confirmationPassword: passwordKonfirmasiController.text,
    );
  }
}
