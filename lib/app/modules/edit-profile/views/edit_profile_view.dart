import 'package:event_digital/core/colors.dart';
import 'package:event_digital/core/style.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
        ),
      ),
      body: GetBuilder<EditProfileController>(
          init: EditProfileController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Form(
                // key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
                      style: AppStyle.styleTextBody16(fontWeight: FontWeight.w700),
                    ).marginOnly(left: 25),
                    TextField(
                      decoration: AppStyle.inputDecorationFloating(
                        "Username",
                        // suffixIcon: const Icon(
                        //   Icons.edit,
                        //   color: AppColors.gray,
                        //   size: 20,
                        // ),
                      ),
                      controller: controller.namaController,
                    ).marginSymmetric(horizontal: 20),
                    Text(
                      'E-Mail',
                      style: AppStyle.styleTextBody16(fontWeight: FontWeight.w700),
                    ).marginOnly(left: 25, top: 10),
                    TextField(
                      decoration: AppStyle.inputDecorationFloating(
                        "Example.email@gomel.com",
                        // suffixIcon: Icon(
                        //   Icons.edit,
                        //   color: AppColors.gray,
                        //   size: 17,
                        // ),
                      ),
                      controller: controller.emailController,
                    ).marginSymmetric(horizontal: 20),
                    Text(
                      'No Telepon',
                      style: AppStyle.styleTextBody16(fontWeight: FontWeight.w700),
                    ).marginOnly(left: 25, top: 10),
                    TextField(
                      decoration: AppStyle.inputDecorationFloating(
                        "+62",
                        // suffixIcon: Icon(
                        //   Icons.edit,
                        //   color: AppColors.gray,
                        //   size: 17,
                        // ),
                      ),
                      controller: controller.teleponController,
                    ).marginSymmetric(horizontal: 20),
                    Text(
                      'Alamat',
                      style: AppStyle.styleTextBody16(fontWeight: FontWeight.w700),
                    ).marginOnly(left: 25).marginOnly(top: 20),
                    TextField(
                      maxLines: 3,
                      decoration: AppStyle.inputDecorationFloating(
                        "",
                        // suffixIcon: Icon(
                        //   Icons.edit,
                        //   color: AppColors.gray,
                        //   size: 17,
                        // ),
                      ),
                      controller: controller.alamatController,
                    ).marginSymmetric(horizontal: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              // showAlertDialog(context, "Yakin Ingin Keluar?", context);
                              Navigator.of(context).pop();
                            },
                            child: Container(
                                height: 40,
                                width: 130,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(color: AppColors.blue, width: 1),
                                  color: AppColors.blueSoft,
                                ),
                                child: Center(
                                  child: Text(
                                    'Batalkan',
                                    style: AppStyle.styleTextBody16(fontWeight: FontWeight.w700, colorText: AppColors.blue),
                                  ),
                                ))).marginOnly(right: 5),
                        ElevatedButton(
                          onPressed: () {
                            // showAlertDialogEdit(context, "Yakin ingin mengubah data di Profil Anda?");
                          },
                          style: AppStyle.styleButton(borderRadius: 18),
                          child: Text(
                            'Perbarui',
                            style: AppStyle.styleTextBody16(colorText: AppColors.white, fontWeight: FontWeight.w700),
                          ).marginSymmetric(horizontal: 10),
                        )
                      ],
                    ).marginAll(20).marginOnly(top: 10),
                  ],
                ).marginOnly(top: 20),
              ),
            );
          }),
    );
  }
}
