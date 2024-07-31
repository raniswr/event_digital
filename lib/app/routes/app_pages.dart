import 'package:event_digital/app/modules/sepeda-page/bindings/sepeda_binding.dart';
import 'package:event_digital/app/modules/sepeda-page/views/sepeda_view.dart';
import 'package:get/get.dart';

import '../modules/checkout-page/bindings/checkout_page_binding.dart';
import '../modules/checkout-page/views/checkout_page_view.dart';
import '../modules/detailProductPage/bindings/detail_product_page_binding.dart';
import '../modules/detailProductPage/views/detail_product_page_view.dart';
import '../modules/edit-profile/bindings/edit_profile_binding.dart';
import '../modules/edit-profile/views/edit_profile_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/introPage/bindings/intro_page_binding.dart';
import '../modules/introPage/views/intro_page_view.dart';
import '../modules/keranjang-page/bindings/keranjang_page_binding.dart';
import '../modules/keranjang-page/views/keranjang_page_view.dart';
import '../modules/loginPage/bindings/login_page_binding.dart';
import '../modules/loginPage/views/login_page_view.dart';
import '../modules/profilePage/bindings/profile_page_binding.dart';
import '../modules/profilePage/views/profile_page_view.dart';
import '../modules/registerPage/bindings/register_page_binding.dart';
import '../modules/registerPage/views/register_page_view.dart';
import '../modules/reset-password/bindings/reset_password_binding.dart';
import '../modules/reset-password/views/reset_password_view.dart';

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
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT_PAGE,
      page: () => const CheckoutPageView(),
      binding: CheckoutPageBinding(),
    ),
    GetPage(
      name: _Paths.KERANJANG_PAGE,
      page: () => const KeranjangPageView(),
      binding: KeranjangPageBinding(),
    ),
    GetPage(
      name: _Paths.sepeda,
      page: () => const SepedaView(),
      binding: SepedaBinding(),
    ),
  ];
}
