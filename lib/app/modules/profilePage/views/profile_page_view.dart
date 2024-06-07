import 'package:event_digital/app/data/storage_name.dart';
import 'package:event_digital/app/modules/profilePage/views/components/profile_menu.dart';
import 'package:event_digital/app/modules/profilePage/views/components/profile_pic.dart';
import 'package:event_digital/app/routes/app_pages.dart';
import 'package:event_digital/core/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/profile_page_controller.dart';

class ProfilePageView extends GetView<ProfilePageController> {
  const ProfilePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfilePageController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile",
            style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const ProfilePic(),
              Text(
                controller.profile?.username ?? '',
                style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
              ).marginOnly(top: 15),

              Text(
                controller.profile?.phoneNo ?? '',
                style: AppStyle.styleTextBody14(),
              ).marginOnly(top: 5),
              const SizedBox(height: 20),
              ProfileMenu(
                text: "Edit Profile",
                icon: "assets/icons/User Icon.svg",
                press: () => {
                  Get.toNamed(Routes.EDIT_PROFILE),
                },
              ),
              // ProfileMenu(
              //   text: "Notifications",
              //   icon: "assets/icons/Bell.svg",
              //   press: () {},
              // ),
              ProfileMenu(
                text: "Reset Password",
                icon: "assets/icons/Settings.svg",
                press: () {
                  Get.toNamed(Routes.RESET_PASSWORD);
                },
              ),
              // ProfileMenu(
              //   text: "FAQ",
              //   icon: "assets/icons/Question mark.svg",
              //   press: () {},
              // ),
              ProfileMenu(
                text: "Log Out",
                icon: "assets/icons/Log out.svg",
                press: () async {
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  var logout = await prefs.remove(StorageName.userKey);
                  if (logout) {
                    Get.offAllNamed(Routes.LOGIN_PAGE);
                  }
                },
              ),

              ProfileMenu(
                text: "Delete Account",
                icon: "assets/icons/Close.svg",
                press: () async {
                  controller.deleteAkun();
                },
              ),

              // ProfileMenu(
              //   text: "Master Sepeda",
              //   icon: "assets/icons/User Icon.svg",

              //   press: () => {
              //     // Get.toNamed(Routes),
              //   },
              // ),
            ],
          ),
        ),
      );
    });
  }
}
