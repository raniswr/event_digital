import 'package:event_digital/core/assets.dart';
import 'package:event_digital/core/colors.dart';
import 'package:event_digital/core/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          'Ubah Kata Sandi',
          style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
        ),
      ),
      body: GetBuilder<ResetPasswordController>(
          init: ResetPasswordController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kata Sandi Lama',
                          style: AppStyle.styleTextBody16(fontWeight: FontWeight.w700),
                        ).marginOnly(left: 25, top: 10),
                        TextField(
                          decoration: AppStyle.inputDecorationFloating(
                            "Kata Sandi Lama",
                            suffixIcon: GestureDetector(
                              onTap: () {
                                controller.passwordVisibility();
                              },
                              child: controller.passwordVisible
                                  ? Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: SvgPicture.asset(
                                        Assets.icInvisiblePass,
                                        color: AppColors.greyText,
                                        width: 20,
                                        height: 20,
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: SvgPicture.asset(
                                        Assets.icVisiblePass,
                                        color: AppColors.greyText,
                                      ),
                                    ),
                            ),
                          ),
                          controller: controller.passwordController,
                          obscureText: controller.passwordVisible,
                        ).marginSymmetric(horizontal: 20),
                        Text(
                          'Kata Sandi Baru',
                          style: AppStyle.styleTextBody16(fontWeight: FontWeight.w700),
                        ).marginOnly(left: 25, top: 20),
                        TextFormField(
                          decoration: AppStyle.inputDecorationFloating(
                            "Kata Sandi Baru",
                            suffixIcon: GestureDetector(
                              onTap: () {
                                controller.passwordKataSandiBaruVisibility();
                              },
                              child: controller.passwordKataSandiBaruVisible
                                  ? Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: SvgPicture.asset(
                                        Assets.icInvisiblePass,
                                        color: AppColors.greyText,
                                        width: 20,
                                        height: 20,
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: SvgPicture.asset(
                                        Assets.icVisiblePass,
                                        color: AppColors.greyText,
                                      ),
                                    ),
                            ),
                          ),
                          validator: (val) {
                            if (val?.isEmpty == true) return 'Mohon isi password';
                            return null;
                          },
                          controller: controller.passwordKataSandiBaruController,
                          obscureText: controller.passwordKataSandiBaruVisible,
                        ).marginSymmetric(horizontal: 20).marginOnly(bottom: 20),
                        Text(
                          'Konfirmasi Kata Sandi Baru',
                          style: AppStyle.styleTextBody16(fontWeight: FontWeight.w700),
                        ).marginOnly(left: 25, top: 10),
                        TextFormField(
                          decoration: AppStyle.inputDecorationFloating(
                            "Konfirmasi Kata Sandi Baru",
                            suffixIcon: GestureDetector(
                              onTap: () {
                                controller.passwordKonfirmasiVisibility();
                              },
                              child: controller.passwordKonfirmasiVisible
                                  ? Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: SvgPicture.asset(
                                        Assets.icInvisiblePass,
                                        color: AppColors.greyText,
                                        width: 20,
                                        height: 20,
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: SvgPicture.asset(
                                        Assets.icVisiblePass,
                                        color: AppColors.greyText,
                                      ),
                                    ),
                            ),
                          ),
                          validator: (val) {
                            if (val?.isEmpty == true) return 'Mohon isi konfirmasi password';
                            if (val != controller.passwordKataSandiBaruController.text) return 'Konfirmasi password salah';
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (v) {
                            controller.update();
                          },
                          controller: controller.passwordKonfirmasiController,
                          obscureText: controller.passwordKonfirmasiVisible,
                        ).marginSymmetric(horizontal: 20),
                      ],
                    ).marginOnly(top: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              // showAlertDialog(context, "Yakin ingin Keluar?", context);
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
                            if (formKey.currentState?.validate() == true) {
                              controller.changePassword(context);
                            }
                          },
                          style: AppStyle.styleButton(borderRadius: 18),
                          child: Text(
                            'Perbarui',
                            style: AppStyle.styleTextBody16(colorText: AppColors.white, fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ).marginAll(20).marginOnly(top: 10),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
