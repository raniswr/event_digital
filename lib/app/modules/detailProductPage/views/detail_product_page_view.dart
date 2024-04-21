import 'package:event_digital/core/assets.dart';
import 'package:event_digital/core/colors.dart';
import 'package:event_digital/core/style.dart';
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
          // style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
        ),
        // leading: IconButton(
        //   icon: SvgPicture.asset(
        //     Assets.icBack,
        //   ),
        //   onPressed: () {
        //     Get.back();
        //   },
        // ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const AnimatedBottomBar(),
      body: SingleChildScrollView(
        child: GetBuilder<DetailProductPageController>(builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/ps4_console_white_1.png",
                width: double.infinity,
                height: 320,
                fit: BoxFit.cover,
              ).marginSymmetric(vertical: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'halo',
                        // style: AppStyle.styleTextBody20(fontWeight: FontWeight.w700, colorText: AppColors.yellow),
                      ),
                      Text(
                        'aha',
                        // style: AppStyle.styleTextBody16(fontWeight: FontWeight.w400, colorText: AppColors.greyText),
                      )
                    ],
                  ),
                  Text(
                    'Rp.',
                    // style: AppStyle.styleTextBody24(fontWeight: FontWeight.w700, colorText: AppColors.greyText),
                  ),
                ],
              ).marginSymmetric(horizontal: 20),
              const Divider(
                thickness: 1,
                // color: AppColors.dividerColor,
              ).marginSymmetric(horizontal: 20, vertical: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Belanja di Marketplace',
                    // style: AppStyle.styleTextBody14(fontWeight: FontWeight.w400, colorText: AppColors.greyText),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        // onTap: () async {
                        //   if (await canLaunch(controller.detailProduct?.data?.shopee ?? '')) {
                        //     await launch(controller.detailProduct?.data?.shopee ?? '');
                        //   } else {
                        //     await launch('https://shopee.co.id/glamori_clinic');
                        //   }
                        // },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            // color: AppColors.yellowLight,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 1,
                              // color: AppColors.yellow,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                // color: AppColors.grey,
                                spreadRadius: 0.3,
                                blurRadius: 0.7,
                                offset: Offset(0, 0.4),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            "assets/images/ps4_console_white_1.png",
                            fit: BoxFit.cover,
                          ).marginAll(8),
                        ).marginOnly(right: 10),
                      ),
                      GestureDetector(
                        onTap: () async {},
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            // color: AppColors.yellowLight,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 1,
                              // color: AppColors.yellow,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                // color: AppColors.grey,
                                spreadRadius: 0.3,
                                blurRadius: 0.7,
                                offset: Offset(0, 0.4),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            "assets/images/ps4_console_white_1.png",
                            fit: BoxFit.contain,
                          ).marginAll(8),
                        ),
                      ),
                    ],
                  ),
                ],
              ).marginSymmetric(horizontal: 20),
              const Divider(
                thickness: 1,
                // color: AppColors.dividerColor,
              ).marginSymmetric(horizontal: 20, vertical: 20),
              Row(
                children: [
                  Text(
                    'Barang Dikirim dari',
                    // style: AppStyle.styleTextBody14(fontWeight: FontWeight.w400, colorText: AppColors.greyText),
                  ),
                  Text(
                    'jakarta',
                    // style: AppStyle.styleTextBody14(fontWeight: FontWeight.w700),
                  ).marginOnly(left: 5),
                ],
              ).marginSymmetric(horizontal: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Deskripsi',
                    // style: AppStyle.styleTextBody16(fontWeight: FontWeight.w600),
                  ).marginOnly(top: 20).marginSymmetric(vertical: 5),
                  Text(' description')
                ],
              ).marginSymmetric(horizontal: 20),
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
                          border: Border.all(color: AppColors.primary, width: 1),
                          color: AppColors.yellowLight,
                        ),
                        child: Center(
                            child: SvgPicture.asset(
                          Assets.icShop,
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
                                    'name',
                                    style: AppStyle.styleTextBody16(fontWeight: FontWeight.w700, colorText: AppColors.yellow),
                                  ),
                                  Text(
                                    'price',
                                    style: AppStyle.styleTextBody14(fontWeight: FontWeight.w700, colorText: AppColors.greyText),
                                  ),
                                  GetBuilder<DetailProductPageController>(builder: (controller) {
                                    return QtyButton(
                                      onMin: () {
                                        // controller.onMinus();
                                      },
                                      onPlus: () {
                                        // controller.onPlus();
                                      },
                                      qty: '1',
                                    );
                                  })
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
                                      onTap: () async {},
                                      child: Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25),
                                          border: Border.all(color: AppColors.primary, width: 1),
                                          color: AppColors.yellowLight,
                                        ),
                                        child: Center(
                                            child: SvgPicture.asset(
                                          Assets.icShop,
                                          width: 20,
                                        )),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {},
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

class QtyButton extends StatefulWidget {
  const QtyButton({
    Key? key,
    required this.onMin,
    required this.onPlus,
    required this.qty,
  }) : super(key: key);

  final VoidCallback onMin;
  final VoidCallback onPlus;
  final String qty;

  @override
  // ignore: library_private_types_in_public_api
  _QtyButtonState createState() => _QtyButtonState();
}

class _QtyButtonState extends State<QtyButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 15,
            child: GestureDetector(
              onTap: () {
                // Call the onPlus callback
                widget.onMin();
                // Manually update the TextField value
                // _updateTextFieldValue(1);
              },
              child: const CircleAvatar(
                radius: 12,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.remove,
                  size: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 18,
            child: Center(
                child: Text(
              widget.qty,
              style: const TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
            )
                // TextField(
                //   controller: widget.controller,
                //   keyboardType: TextInputType.number,
                //   onChanged: (newValue) {},
                //   style: const TextStyle(
                //     fontSize: 12,
                //     color: Colors.black,
                //   ),
                //   textAlign: TextAlign.center,
                //   decoration: const InputDecoration(
                //     border: InputBorder.none,
                //   ),
                // ),
                ),
          ),
          SizedBox(
            width: 15,
            child: GestureDetector(
              onTap: () {
                // Call the onPlus callback
                widget.onPlus();
                // Manually update the TextField value
                // _updateTextFieldValue(1);
              },
              child: const CircleAvatar(
                radius: 12,
                backgroundColor: AppColors.yellow,
                child: Icon(
                  Icons.add,
                  size: 12,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    ).marginOnly(right: 10);
  }

  // Helper function to update the TextField value
  // void _updateTextFieldValue(int increment) {
  //   final currentValue = int.tryParse(widget.controller.text) ?? 0;
  //   final newValue = currentValue + increment;
  //   if (newValue > 0) {
  //     widget.controller.text = newValue.toString();
  //   }
  // }
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

