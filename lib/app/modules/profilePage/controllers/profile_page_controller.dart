import 'dart:developer';

import 'package:event_digital/app/data/model/model_profile.dart';
import 'package:event_digital/app/data/model/model_user.dart';
import 'package:event_digital/app/data/services/api_services.dart';
import 'package:event_digital/app/data/services/user_services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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

  updateImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
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
