import 'package:event_digital/app/data/model/model_sepeda.dart';
import 'package:event_digital/app/data/services/api_services.dart';
import 'package:event_digital/app/data/services/user_services.dart';
import 'package:event_digital/app/routes/app_pages.dart';
import 'package:event_digital/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SepedaController extends GetxController {
  TextEditingController kodeSepedaController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController merkController = TextEditingController();
  TextEditingController jumlahSpeedController = TextEditingController();

  var selectedItem = "MTB";

  void setSelectedItem(String value) {
    selectedItem = value;
    update();
  }

  var peruntukan = "pria";

  void setSelectedPeruntukan(String value) {
    peruntukan = value;
    update();
  }

  void uploadSepeda(BuildContext context) async {
    var dataLogin = await UserService.find.getLocalUser();
    DataSepeda data = DataSepeda(
      kodeSepeda: kodeSepedaController.text != '' ? int.parse(kodeSepedaController.text) : 0,
      nama: namaController.text,
      merk: merkController.text,
      jenisSepeda: selectedItem,
      peruntukan: peruntukan,
      jumlahSpeed: jumlahSpeedController.text != '' ? int.parse(jumlahSpeedController.text) : 0,
      tanggalLaunching: tanggalController.text,
    );

    ModelSepeda pesanan = ModelSepeda(data: data);
    var createPesanan = await ApiServices.postSepeda(modelCard: pesanan);
    if (createPesanan == true) {
      EasyLoading.showSuccess("Successfully");
    } else {
      EasyLoading.showError("Failed");
    }
  }

  TextEditingController tanggalController = TextEditingController();

  Future<void> selectDateStart(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime lastDate = DateTime(now.year + 3, now.month, now.day, 23, 59, 59);

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: lastDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.blue,
            colorScheme: const ColorScheme.light(primary: AppColors.blue),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      tanggalController.text = formattedDate;
    }
  }
}
