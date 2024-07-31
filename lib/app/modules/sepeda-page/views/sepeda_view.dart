import 'package:event_digital/core/assets.dart';
import 'package:event_digital/core/colors.dart';
import 'package:event_digital/core/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/sepeda_controller.dart';

class SepedaView extends GetView<SepedaController> {
  const SepedaView({Key? key}) : super(key: key);
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
      body: GetBuilder<SepedaController>(
          init: SepedaController(),
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
                          'Kode sepeda',
                          style: AppStyle.styleTextBody16(fontWeight: FontWeight.w700),
                        ).marginOnly(left: 25, top: 10),
                        TextField(
                          decoration: AppStyle.inputDecorationFloating(
                            "kode sepeda",
                          ),
                          controller: controller.kodeSepedaController,
                        ).marginSymmetric(horizontal: 20),
                        Text(
                          'Nama Sepeda',
                          style: AppStyle.styleTextBody16(fontWeight: FontWeight.w700),
                        ).marginOnly(left: 25, top: 20),
                        TextFormField(
                          decoration: AppStyle.inputDecorationFloating(
                            "Nama Sepeda",
                          ),
                          controller: controller.namaController,
                        ).marginSymmetric(horizontal: 20).marginOnly(bottom: 20),
                        Text(
                          'Merk Sepeda',
                          style: AppStyle.styleTextBody16(fontWeight: FontWeight.w700),
                        ).marginOnly(left: 25, top: 10),
                        TextFormField(
                          decoration: AppStyle.inputDecorationFloating(
                            "Merk",
                          ),
                          controller: controller.merkController,
                        ).marginSymmetric(horizontal: 20),
                      ],
                    ).marginOnly(top: 10),
                    Text(
                      'Jenis Sepeda',
                      style: AppStyle.styleTextBody16(fontWeight: FontWeight.w700),
                    ).marginOnly(left: 25, top: 10),
                    DropdownButton<String>(
                      value: controller.selectedItem,
                      onChanged: (String? newValue) {
                        controller.setSelectedItem(newValue ?? '');
                      },
                      items: <String>['MTB', 'Road', 'Bike', 'Sepeda Anak'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ).marginOnly(left: 25, top: 10),
                    Text(
                      'Peruntukan',
                      style: AppStyle.styleTextBody16(fontWeight: FontWeight.w700),
                    ).marginOnly(left: 25, top: 10),
                    DropdownButton<String>(
                      value: controller.peruntukan,
                      onChanged: (String? newValue) {
                        controller.setSelectedPeruntukan(newValue ?? '');
                      },
                      items: <String>['pria', 'wanita'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ).marginOnly(left: 25, top: 10),
                    Text(
                      'Tanggal Launching',
                      style: AppStyle.styleTextBody16(fontWeight: FontWeight.w600),
                    ).marginSymmetric(horizontal: 20),
                    TextField(
                      onTap: () {
                        controller.selectDateStart(context);
                      },
                      decoration: AppStyle.inputDecorationFloating(
                        "Tanggal Launching",
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GestureDetector(
                            onTap: () {
                              controller.selectDateStart(context);
                            },
                            child: Icon(
                              Icons.date_range,
                            ),
                          ),
                        ),
                      ),
                      controller: controller.tanggalController,
                      readOnly: true,
                    ).marginSymmetric(horizontal: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            controller.uploadSepeda(context);
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
