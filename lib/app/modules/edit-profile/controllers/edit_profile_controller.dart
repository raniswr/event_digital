import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController teleponController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

  //  ModelGetProfile? users;
  // getProfile(String id) async {
  //   var data = await ApiServices().getProfile(id);
  //   if (data != null) {
  //     users = data;

  //     initEdit();

  //     update();
  //   }
  // }
}
