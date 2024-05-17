import 'package:event_digital/app/components/my_button.dart';
import 'package:event_digital/app/components/my_textfield.dart';
import 'package:event_digital/app/components/square_tile.dart';
import 'package:event_digital/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_page_controller.dart';

class RegisterPageView extends GetView<RegisterPageController> {
  const RegisterPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: GetBuilder<RegisterPageController>(builder: (controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),

                  // username textfield
                  MyTextField(
                    controller: controller.usernameController,
                    hintText: 'Username',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  MyTextField(
                    controller: controller.emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),
                  MyTextField(
                    controller: controller.alamatController,
                    hintText: 'Alamat',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: controller.phoneController,
                    hintText: 'No Telepon',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),
                  MyTextField(
                    controller: controller.passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  // forgot password?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // sign in button
                  MyButton(
                    onTap: () {
                      controller.register(context);
                    },
                  ),

                  const SizedBox(height: 50),

                  // or continue with

                  const SizedBox(height: 50),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sudah punya akun?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.LOGIN_PAGE);
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
