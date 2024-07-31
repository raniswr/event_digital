import 'package:event_digital/app/data/model/model_profile.dart';
import 'package:event_digital/app/data/services/api_services.dart';
import 'package:event_digital/app/data/services/user_services.dart';
import 'package:event_digital/app/modules/profilePage/controllers/profile_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController teleponController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

  ModelProfile? profile;
  getProfile(int? id) async {
    var data = await ApiServices().getProfile(id);
    if (data != null) {
      profile = data;

      update();
      namaController.text = profile?.username ?? '';
      emailController.text = profile?.email ?? '';
      teleponController.text = profile?.phoneNo ?? '';
      alamatController.text = profile?.address ?? '';
    }
  }

  editProfile(int? id) async {
    var dataLogin = await UserService.find.getLocalUser();
    var data = await ApiServices().editProfile(
      id: id,
      email: emailController.text,
      phone: teleponController.text,
      password: dataLogin?.password ?? '',
      address: alamatController.text,
      username: namaController.text,
    );
    if (data != null) {
      EasyLoading.showSuccess('Berhasil Edit');
      Get.back();
      var getPage = Get.find<ProfilePageController>();
      getPage.getProfile();
    }
  }

  @override
  void onReady() async {
    var dataLogin = await UserService.find.getLocalUser();
    getProfile(dataLogin?.id);

    update();
    super.onReady();
  }
}
