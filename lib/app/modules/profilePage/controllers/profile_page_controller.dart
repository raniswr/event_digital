import 'dart:developer';

import 'package:event_digital/app/data/model/model_profile.dart';
import 'package:event_digital/app/data/model/model_user.dart';
import 'package:event_digital/app/data/services/api_services.dart';
import 'package:event_digital/app/data/services/user_services.dart';
import 'package:event_digital/app/data/storage_name.dart';
import 'package:event_digital/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:html' as html;
// import 'package:flutter/foundation.dart' show kIsWeb;

class ProfilePageController extends GetxController {
  ModelProfile? profile;

  @override
  void onReady() {
    getProfile();
    super.onReady();
  }

  getProfile() async {
    log("getting profile...");
    ModelUser? user = UserService.find.user;
    profile = await ApiServices().getProfile(user?.id);
    update();
  }

  deleteAkun() async {
    ModelUser? user = UserService.find.user;
    var delete = await ApiServices().deleteAccount(user?.id);
    if (delete == true) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var logout = await prefs.remove(StorageName.userKey);
      if (logout) {
        Get.offAllNamed(Routes.LOGIN_PAGE);
      }
    }

    update();
  }

  Future<void> updateImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      ModelUser? user = UserService.find.user;
      var data = await ApiServices().editProfilePhoto(image: image.path, id: user?.id);
      if (data != null) {
        getProfile();
      }
    }
  }
}
