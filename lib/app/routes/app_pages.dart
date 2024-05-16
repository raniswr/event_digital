import 'package:get/get.dart';

import '../modules/detailProductPage/bindings/detail_product_page_binding.dart';
import '../modules/detailProductPage/views/detail_product_page_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/introPage/bindings/intro_page_binding.dart';
import '../modules/introPage/views/intro_page_view.dart';
import '../modules/loginPage/bindings/login_page_binding.dart';
import '../modules/loginPage/views/login_page_view.dart';
import '../modules/profilePage/bindings/profile_page_binding.dart';
import '../modules/profilePage/views/profile_page_view.dart';

import '../modules/registerPage/bindings/register_page_binding.dart';
import '../modules/registerPage/views/register_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.INTRO_PAGE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INTRO_PAGE,
      page: () => const IntroPageView(),
      binding: IntroPageBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PAGE,
      page: () => const ProfilePageView(),
      binding: ProfilePageBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PRODUCT_PAGE,
      page: () => const DetailProductPageView(),
      binding: DetailProductPageBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_PAGE,
      page: () => const LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_PAGE,
      page: () => const RegisterPageView(),
      binding: RegisterPageBinding(),
    ),
  ];
}
