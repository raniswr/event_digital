import 'package:event_digital/app/modules/home/views/home_view.dart';
import 'package:event_digital/app/routes/app_pages.dart';
import 'package:event_digital/core/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/intro_page_controller.dart';

class IntroPageView extends GetView<IntroPageController> {
  const IntroPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Assets.icOnboarding,
                height: 250,
              ).marginOnly(top: 50),
              // big logo
              // Padding(
              //   padding: const EdgeInsets.only(
              //     left: 100.0,
              //     right: 100.0,
              //     top: 120,
              //     bottom: 20,
              //   ),
              //   child: SvgPicture.asset(
              //     Assets.icOnboarding,
              //   ),
              // ),

              const Padding(
                padding: const EdgeInsets.all(28.0),
                child: Text(
                  'Telusuri Acaramu Sekarang dan Temukan Pengalaman Tak Terlupakan!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),

              Text(
                'Pesan Sekarang!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ).marginOnly(bottom: 20),

              GestureDetector(
                onTap: () => Get.toNamed(Routes.LOGIN_PAGE),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.black,
                  ),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
