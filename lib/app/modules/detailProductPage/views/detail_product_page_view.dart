import 'package:event_digital/app/routes/app_pages.dart';
import 'package:event_digital/core/assets.dart';
import 'package:event_digital/core/colors.dart';
import 'package:event_digital/core/style.dart';
import 'package:event_digital/utils/sqlite_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/detail_product_page_controller.dart';

class DetailProductPageView extends GetView<DetailProductPageController> {
  const DetailProductPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.secondary,
      appBar: AppBar(
        // backgroundColor: AppColors.secondary,
        title: Text(
          'Detail Produk',
          style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const AnimatedBottomBar(),
      body: SingleChildScrollView(
        child: GetBuilder<DetailProductPageController>(builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              controller.image != null
                  ? Image.network(
                      // productImage,
                      'http://localhost:1337${controller.image}',

                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ).marginOnly(bottom: 10)
                  : SizedBox.shrink(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.detailProduct?.data?.attributes?.name ?? '',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                  Text(
                    controller.formatPrice(controller.detailProduct?.data?.attributes?.price ?? 0),
                    style: AppStyle.styleTextBody16(fontWeight: FontWeight.w700),
                  ),
                ],
              ).marginSymmetric(horizontal: 20),
              const Divider(
                thickness: 1,
                // color: AppColors.dividerColor,
              ).marginSymmetric(horizontal: 20, vertical: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Deskripsi',
                    style: AppStyle.styleTextBody16(fontWeight: FontWeight.w600),
                  ).marginOnly(top: 20).marginSymmetric(vertical: 5),
                  Text(
                    controller.detailProduct?.data?.attributes?.description ?? '',
                    // style: AppStyle.styleTextBody16(fontWeight: FontWeight.w600),
                  ).marginOnly(top: 20).marginSymmetric(vertical: 5),
                ],
              ).marginSymmetric(horizontal: 10),
              const SizedBox(height: 120),
            ],
          );
        }),
      ),
    );
  }
}

class AnimatedBottomBar extends StatelessWidget {
  const AnimatedBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailProductPageController>(builder: (controller) {
      return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 75,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 5),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.grayBottomNav,
              borderRadius: BorderRadius.circular(35),
            ),
            child: GetBuilder<DetailProductPageController>(
              init: DetailProductPageController(),
              builder: (controller) {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        showModal(context);
                      },
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: AppColors.blue, width: 1),
                          color: AppColors.blueSoft,
                        ),
                        child: Center(
                            child: SvgPicture.asset(
                          Assets.icShop,
                          color: AppColors.blue,
                          width: 20,
                        )),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          showModal(context);
                        },
                        style: AppStyle.styleButton(borderRadius: 23),
                        child: Text(
                          'Beli Sekarang',
                          textAlign: TextAlign.center,
                          style: AppStyle.styleTextBody16(colorText: AppColors.textLightYellow, fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ));
    });
  }
}

showModal(context) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return GetBuilder<DetailProductPageController>(builder: (controller) {
        return Container(
          height: 280,
          decoration: const BoxDecoration(
            // color: AppColors.bgBottomSheets,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              // SvgPicture.asset(
              //   Assets.icShowModal,
              //   width: 88,
              // ).marginSymmetric(vertical: 10),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 93,
                      // color: AppColors.white,
                      child: SingleChildScrollView(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                              child: Image.asset(
                                'assets/images/ps4_console_white_1.png',
                                width: 93,
                                height: 93,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.detailProduct?.data?.attributes?.name ?? '',
                                    style: AppStyle.styleTextBody16(fontWeight: FontWeight.w700, colorText: AppColors.blue),
                                  ),
                                  Text(
                                    controller.formatPrice(controller.detailProduct?.data?.attributes?.price ?? 0),
                                    style: AppStyle.styleTextBody14(fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ).marginOnly(top: 10, left: 15),
                            ),
                          ],
                        ),
                      ),
                    ).marginAll(20),
                    GetBuilder<DetailProductPageController>(builder: (controller) {
                      return Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 75,
                            margin: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: AppColors.grayBottomNav,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: GetBuilder<DetailProductPageController>(
                              init: DetailProductPageController(),
                              builder: (controller) {
                                return Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        if (controller.detailProduct != null) {
                                          var sqlHelper = await SqlLiteHelper.instance.cartTable;
                                          var productId = controller.detailProduct?.data?.id.toString() ?? '';
                                          var data = await sqlHelper.getCartById(productId);
                                          if (data == null) {
                                            await sqlHelper.insertCart(controller.detailProduct!);
                                            Navigator.of(context).pop();
                                            showAlertDialog(context);
                                          } else {
                                            SizedBox.shrink();
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25),
                                          border: Border.all(color: AppColors.blue, width: 1),
                                          color: AppColors.blueSoft,
                                        ),
                                        child: Center(
                                            child: SvgPicture.asset(
                                          Assets.icShop,
                                          color: AppColors.blue,
                                          width: 20,
                                        )),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Get.offNamed(
                                            Routes.CHECKOUT_PAGE,
                                            arguments: {
                                              'product': [controller.detailProduct],
                                              'from': 'detail',
                                              // 'harga': controller.harga,
                                            },
                                          );
                                        },
                                        style: AppStyle.styleButton(borderRadius: 23),
                                        child: Text(
                                          'Beli Sekarang',
                                          textAlign: TextAlign.center,
                                          style: AppStyle.styleTextBody16(colorText: AppColors.textLightYellow, fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ));
                    }),
                  ],
                ),
              ),
            ],
          ),
        );
      });
    },
  );
}

class CustomBulletTitle extends StatelessWidget {
  const CustomBulletTitle({
    Key? key,
    required this.bulletColor,
    required this.text,
  }) : super(key: key);

  final Color bulletColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 3,
          backgroundColor: bulletColor,
        ).marginOnly(top: 5),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            // style: const TextStyle(fontSize: 13, color: AppColors.textBlack), // You can customize the style here
          ),
        ),
      ],
    );
  }
}

// class CustomToast {
//   static void showToast(BuildContext context, String message) {
//     final overlay = Overlay.of(context);
//     OverlayEntry overlayEntry;

//     overlayEntry = OverlayEntry(
//       builder: (BuildContext context) => Positioned(
//         top: 80,
//         left: 40,
//         right: 40,
//         child: Material(
//           color: Colors.transparent,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
//             decoration: BoxDecoration(
//               color: AppColors.yellowSoft,
//               border: Border.all(
//                 color: AppColors.yellow,
//                 width: 2.0,
//               ),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               message,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: AppColors.textBlack,
//                 fontSize: 12.0,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );

//     overlay.insert(overlayEntry);

//     // Display the toast for 3 seconds
//     Future.delayed(const Duration(seconds: 2), () {
//       overlayEntry.remove();
//     });
//   }
// }

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    backgroundColor: AppColors.white,
    surfaceTintColor: Colors.transparent,
    // title: SvgPicture.asset(
    //   Assets.icPopUpSuccess,
    // ),
    content: Text(
      "Produk Berhasil disimpan dikeranjang!",
      textAlign: TextAlign.center,
      style: AppStyle.styleTextBody20(fontWeight: FontWeight.w700, colorText: AppColors.yellow),
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
