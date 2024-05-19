import 'package:event_digital/core/colors.dart';
import 'package:event_digital/core/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/checkout_page_controller.dart';

class CheckoutPageView extends GetView<CheckoutPageController> {
  const CheckoutPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Check-out',
          style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
        ),
      ),
      body: GetBuilder<CheckoutPageController>(
          init: CheckoutPageController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   children: [
                  //     SvgPicture.asset(
                  //       Assets.icPengiriman,
                  //     ),
                  //     Text(
                  //       'Informasi Pembelian',
                  //       style: AppStyle.styleTextBody16(fontWeight: FontWeight.w600),
                  //     ).marginOnly(left: 5),
                  //   ],
                  // ).marginOnly(left: 20, top: 20),
                  // controller.pilih == false
                  //     ? Text(
                  //         '*pilih informasi pembelian wajib diisi',
                  //         style: AppStyle.styleTextBody14(colorText: AppColors.red),
                  //       ).marginOnly(left: 25, top: 10)
                  //     : const SizedBox.shrink(),

                  const Divider(
                    thickness: 1,
                    color: AppColors.dividerColor,
                  ).marginSymmetric(horizontal: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rincian Pemesanan',
                        style: AppStyle.styleTextBody16(fontWeight: FontWeight.w700),
                      ).marginOnly(top: 10),
                      ListView.builder(
                        itemCount: controller.product?.length ?? 0,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (context, index) {
                          var item = controller.product?[index];
                          return Row(
                            children: [
                              // item?.data?.image != null
                              //     ? ClipRRect(
                              //         borderRadius: BorderRadius.circular(8),
                              //         child: Image.network(
                              //           item?.data?.image ?? '',
                              //           width: 80,
                              //           fit: BoxFit.cover,
                              //         ),
                              //       ).marginOnly(right: 10)
                              //     : const SizedBox.shrink(),
                              // Image.asset(
                              //   'assets/images/ps4_console_white_1.png',
                              //   width: 93,
                              //   height: 93,
                              //   fit: BoxFit.cover,
                              // ).marginOnly(right: 20),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      item?.data?.attributes?.name ?? '',
                                      style: AppStyle.styleTextBody16(fontWeight: FontWeight.w700, colorText: AppColors.blue),
                                    ),
                                    Text(
                                      controller.formatPrice(item?.data?.attributes?.price?.toDouble() ?? 0),
                                      style: AppStyle.styleTextBody14(colorText: AppColors.greyText, fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ).marginSymmetric(vertical: 10);
                        },
                      ),
                    ],
                  ).marginSymmetric(horizontal: 20),
                  const Divider(
                    thickness: 1,
                    color: AppColors.dividerColor,
                  ).marginSymmetric(horizontal: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Total Pesanan: ',
                            style: AppStyle.styleTextBody12(fontWeight: FontWeight.w400, colorText: AppColors.textGrey),
                          ),
                          Text(
                            controller.formatPrice(controller.totalPrice),
                            style: AppStyle.styleTextBody14(fontWeight: FontWeight.w700, colorText: AppColors.blue),
                          ),
                        ],
                      ),
                    ],
                  ).marginSymmetric(horizontal: 20, vertical: 10),

                  const Divider(
                    thickness: 1,
                    color: AppColors.dividerColor,
                  ).marginSymmetric(horizontal: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Pembayaran',
                        style: AppStyle.styleTextBody16(colorText: AppColors.greyTextLight),
                      ).marginOnly(top: 10),
                      Text(
                        controller.formatPrice(controller.totalPrice),
                        style: AppStyle.styleTextBody22(
                          fontWeight: FontWeight.w700,
                          colorText: AppColors.blue,
                        ),
                      )
                    ],
                  ).marginSymmetric(horizontal: 20).marginOnly(top: 10, bottom: 20),
                  CheckboxListTile(
                    title: Text(
                      'Dengan menekan tombol "Bayar", Anda mengonfirmasi pembelian barang di atas dan memahami bahwa pesanan Anda tidak dapat dibatalkan.',
                      style: AppStyle.styleTextBody12(colorText: AppColors.greyTextLight),
                    ),
                    side: const BorderSide(color: AppColors.gray),
                    value: controller.selectCheck,
                    onChanged: (bool? value) {
                      controller.onCheck(value);
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  controller.selectCheck == false
                      ? const SizedBox(
                          height: 50,
                        )
                      : GestureDetector(
                          onTap: () async {
                            controller.pay(context);
                          },
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: AppColors.primary,
                            ),
                            child: Center(
                              child: Text(
                                'Bayar',
                                style: AppStyle.styleTextBody16(colorText: AppColors.white, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ).marginSymmetric(horizontal: 20, vertical: 10),
                ],
              ),
            );
          }),
    );
  }
}
