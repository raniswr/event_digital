import 'package:event_digital/app/modules/profilePage/controllers/profile_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfilePageController>(
        init: ProfilePageController(),
        builder: (controller) {
          return SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    controller.profile?.image ?? '',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const CircleAvatar(
                        backgroundImage: AssetImage(
                          "assets/images/Profile Image.png",
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  right: -16,
                  bottom: 0,
                  child: SizedBox(
                    height: 46,
                    width: 46,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: const BorderSide(color: Colors.white),
                        ),
                        backgroundColor: const Color(0xFFF5F6F9),
                      ),
                      onPressed: () {
                        controller.updateImage();
                      },
                      child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
