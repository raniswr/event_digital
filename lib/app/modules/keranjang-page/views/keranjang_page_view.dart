import 'package:event_digital/core/colors.dart';
import 'package:event_digital/core/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../controllers/keranjang_page_controller.dart';

class KeranjangPageView extends GetView<KeranjangPageController> {
  const KeranjangPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<KeranjangPageController>(
      init: KeranjangPageController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.secondary,
          appBar: AppBar(
            backgroundColor: AppColors.secondary,
            title: Text(
              'Keranjang Saya',
              style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: const AnimatedBottomBar(),
          body: controller.carts.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      Text(
                        'Belum ada produk',
                        style: AppStyle.styleTextBody16(fontWeight: FontWeight.bold),
                        maxLines: 3,
                      ).marginSymmetric(vertical: 10),
                      GestureDetector(
                        onTap: () async {
                          // Get.offNamedUntil(Routes.rootPage, (route) => false);
                          // var getPage = Get.isRegistered<RootPageController>() ? Get.find<RootPageController>() : Get.put(RootPageController());
                          // getPage.onItemTapped(2);
                          Get.back();
                        },
                        child: Container(
                          height: 30,
                          width: 220,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: AppColors.primary,
                          ),
                          child: Center(
                            child: Text(
                              'Temukan Produk!',
                              style: AppStyle.styleTextBody16(colorText: AppColors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).marginOnly(top: 50),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                fillColor: MaterialStatePropertyAll(controller.carts.isEmpty
                                    ? AppColors.grey
                                    : controller.isAllChecked
                                        ? AppColors.blue
                                        : AppColors.grey),
                                activeColor: AppColors.blue,
                                value: controller.carts.isEmpty ? false : controller.isAllChecked,
                                side: BorderSide.none,
                                onChanged: (bool? value) async {
                                  controller.checkListAll(value);
                                },
                                visualDensity: VisualDensity.compact,
                              ),
                              Text(
                                'Pilih Semua',
                                style: AppStyle.styleTextBody12(colorText: AppColors.greyText),
                              ),
                            ],
                          ).marginOnly(right: 5),
                          GestureDetector(
                            onTap: () {
                              controller.carts.isEmpty ? const SizedBox.shrink() : EasyLoading.showInfo('Harap pilih produk!');
                            },
                            child: Container(
                              height: 38,
                              width: 87,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: AppColors.blue, width: 1),
                                color: AppColors.blueSoft,
                              ),
                              child: Center(
                                child: Text(
                                  'Hapus',
                                  style: AppStyle.styleTextBody16(colorText: AppColors.blue, fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ).marginSymmetric(horizontal: 10),
                        ],
                      ).marginSymmetric(horizontal: 15),
                      GetBuilder<KeranjangPageController>(
                        builder: (controller) {
                          return ListView.builder(
                            itemCount: controller.carts.length,
                            primary: true,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final item = controller.carts[index];

                              return CheckboxListTileWidget(
                                checkboxValue: item.checked == 1,
                                isThreeLine: false,
                                onChanged: (bool? value) async {
                                  controller.updateCheckboxValue(item.data?.id.toString() ?? '', value == true ? 1 : 0);
                                },
                                title: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(bottom: 10, top: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          // ExtendedImage.network(
                                          //   item.data?.image ?? '',
                                          //   width: 60,
                                          //   fit: BoxFit.fill,
                                          //   shape: BoxShape.rectangle,
                                          //   borderRadius: BorderRadius.circular(5),
                                          // ).marginOnly(right: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  item.data?.attributes?.name ?? '-',
                                                  style: AppStyle.styleTextBody16(fontWeight: FontWeight.w700),
                                                  maxLines: 3,
                                                ),
                                                Text(
                                                  formatPrice(item.data?.attributes?.price ?? 0),
                                                  style: AppStyle.styleTextBody14(fontWeight: FontWeight.w700, colorText: AppColors.greyText),
                                                ),
                                              ],
                                            ).marginOnly(top: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ).marginOnly(bottom: controller.carts.length - 1 == index ? 100 : 0);
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class AnimatedBottomBar extends StatelessWidget {
  const AnimatedBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<KeranjangPageController>(builder: (controller) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            height: 141,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 5),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.inputColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Divider(
                  thickness: 1,
                  color: AppColors.dividerColor,
                ).marginSymmetric(horizontal: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${controller.getCheckedItemCount()} Produk',
                      style: AppStyle.styleTextBody12(colorText: AppColors.greyText),
                    ),
                    Row(
                      children: [
                        Text(
                          'Total Pesanan: ',
                          style: AppStyle.styleTextBody12(colorText: AppColors.greyText),
                        ),
                        Text(
                          controller.calculateTotalPrice(),
                          style: AppStyle.styleTextBody14(colorText: AppColors.blue, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                  color: AppColors.dividerColor,
                ).marginSymmetric(horizontal: 10, vertical: 5),
                SizedBox(
                  width: 350,
                  child: GestureDetector(
                    onTap: () {
                      if (controller.carts.isEmpty) {
                        const SizedBox.shrink();
                      } else if (controller.getCheckedItemCount() == 0) {
                        EasyLoading.showInfo('Harap pilih product!');
                      } else {
                        controller.goToPengiriman();
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: controller.carts.isEmpty ? AppColors.gray : AppColors.blue,
                      ),
                      child: Center(
                        child: Text(
                          'Beli Sekarang',
                          style: AppStyle.styleTextBody16(colorText: AppColors.white, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      );
    });
  }
}

class CheckboxListTileWidget extends StatelessWidget {
  final bool checkboxValue;
  final void Function(bool?)? onChanged;
  final Widget title;
  final bool isThreeLine;

  const CheckboxListTileWidget({
    required this.checkboxValue,
    required this.onChanged,
    required this.title,
    this.isThreeLine = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: checkboxValue,
      onChanged: onChanged,
      side: BorderSide.none,
      fillColor: MaterialStatePropertyAll(checkboxValue ? AppColors.blue : AppColors.grey),
      title: title,
      activeColor: AppColors.blue,
      isThreeLine: isThreeLine,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
