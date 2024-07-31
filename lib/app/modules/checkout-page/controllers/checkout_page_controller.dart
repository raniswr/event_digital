import 'package:event_digital/app/data/model/model_detail.dart';
import 'package:event_digital/app/data/model/model_pesanan.dart';
import 'package:event_digital/app/data/services/api_services.dart';
import 'package:event_digital/app/data/services/user_services.dart';
import 'package:event_digital/app/routes/app_pages.dart';
import 'package:event_digital/config/api_client.dart';
import 'package:event_digital/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckoutPageController extends GetxController {
  List<ModelDetail?>? product;

  String? idUser;
  bool? isLogin;
  double subTotal = 0;
  double totalPrice = 0;
  double? totalPricePoin;
  double? totalPricePoinFinal;
  bool isButtonClicked = false;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController notesController = TextEditingController();

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
      startDateController.text = formattedDate;
    }
  }

  List<String> productIdsAsString = [];

  List<String> getProductIdsAsString(List<ModelDetail?>? product) {
    // Check if the product list is not null
    if (product == null) {
      return []; // Return an empty list if product is null
    }

    // Use map() to transform each ModelDetail? object into its ID
    return product
        .where((detail) => detail != null) // Filter out null elements
        .map((detail) => detail!.data?.id) // Map each ModelDetail? to its ID
        .where((id) => id != null) // Filter out null IDs
        .map((id) => id.toString()) // Convert each ID to a string
        .toList(); // Convert to a list
  }

  Future<void> selectDateEnd(BuildContext context) async {
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
      endDateController.text = formattedDate;
    }
  }

  pay(BuildContext context) async {
    print("pay");
    final request = BraintreeDropInRequest(
      clientToken: "sandbox_hcj3d3tc_qn876f359gxd77qf",
      collectDeviceData: true,
      googlePaymentRequest: BraintreeGooglePaymentRequest(
        totalPrice: "$totalPrice",
        currencyCode: 'IDR',
        billingAddressRequired: false,
      ),
    );

    BraintreeDropInResult? result = await BraintreeDropIn.start(request);
    if (result != null) {
      // EasyLoading.showSuccess("Successfully buy, lanjut simpan pesannan ke API dengan status PAID @rani");

      var dataLogin = await UserService.find.getLocalUser();
      DataPesanan data = DataPesanan(
        usersPermissionsUser: '${dataLogin?.id}',
        products: productIdsAsString,
        status: "paid",
        dueDate: startDateController.text,
        endDate: endDateController.text,
        notes: notesController.text,
      );

      ModelPesanan pesanan = ModelPesanan(data: data);
      var createPesanan = await ApiServices.postTransaction(modelCard: pesanan);
      if (createPesanan == true) {
        EasyLoading.showSuccess("Successfully buy");
        startDateController.text = '';
        endDateController.text = '';
        notesController.text = '';
        isButtonClicked = false;

        Get.toNamed(Routes.HOME);
      } else {
        EasyLoading.showError("Failed to buy");
        startDateController.text = '';
        endDateController.text = '';
        notesController.text = '';
        isButtonClicked = false;
      }
    } else {
      EasyLoading.showError("Failed to buy");
      startDateController.text = '';
      endDateController.text = '';
      notesController.text = '';
      isButtonClicked = false;
    }
    // var dataLogin = await UserService.find.getLocalUser();
    // DataPesanan data = DataPesanan(
    //   usersPermissionsUser: '${dataLogin?.id}',
    //   products: productIdsAsString,
    //   status: "unpaid",
    //   dueDate: startDateController.text,
    //   endDate: endDateController.text,
    //   notes: notesController.text,
    // );

    // ModelPesanan pesanan = ModelPesanan(data: data);
    // var createPesanan = await ApiServices.postTransaction(modelCard: pesanan);
    // if (createPesanan == true) {
    //   EasyLoading.showSuccess("Berhasil Pesan");
    //   Get.toNamed(Routes.HOME);
    // }
  }

  // Future<String?> postTransaction(BuildContext context) async {
  //   if (idUser != null) {
  //     List<ProductItems> listItem = [];
  //     product?.forEach((element) {
  //       listItem.add(ProductItems(
  //         category: 'product',
  //         name: element?.data?.name ?? '',
  //         price: element?.data?.price ?? 0,
  //         qty: element?.qty ?? 1,
  //         discount: 0,
  //         subname: element?.data?.subname ?? '',
  //         discountPrice: 0,
  //         image: element?.data?.image ?? '',
  //         sId: element?.data?.sId,
  //       ));
  //     });
  //     var dataLokasi = await UserService.find.getLocationUser();

  //     ModelCardUpload cardUpload = ModelCardUpload(
  //       consultationPrice: 0,
  //       tax: 0,
  //       patient: idUser,
  //       payment: "cash",
  //       deliveryPrice: selectedIndex == 1 ? harga : 0,
  //       totalPrice: totalPricePoin != null && totalPrice2 != 0 && usePoint == true
  //           ? totalPricePointDiscount
  //           : totalPrice2 != 0 && usePoint == false
  //               ? totalPrice2
  //               : totalPricePoin != null && usePoint == true && totalPricePointDiscount == 0 && selectedIndex == 0
  //                   ? totalPricePoin
  //                   : selectedIndex == 1 && usePoint == true && totalPricePointDiscount == 0
  //                       ? totalPriceDeliveryPoin
  //                       : selectedIndex == 1 && usePoint == false
  //                           ? totalPriceDelivery
  //                           : totalPrice,
  //       mobileOrder: true,
  //       items: listItem,
  //       discount: totalPrice2 != 0 && discount1 != null ? discount1 : 0,
  //       discountPrice: data ?? 0,
  //       voucher: voucher?.first?.voucherId ?? '',
  //       branch: dataLokasi == 'JAKARTA' ? 'jakarta' : 'lampung',
  //       point: totalPoin >= 0 && usePoint == true ? totalPoin : 0,
  //       isDelivery: selectedIndex == 1 ? true : false,
  //       pointCurrency: usePoint == true ? totalPricePoinFinal ?? 0 : 0,
  //     );

  //     var result = await ApiServices.postTransaction(modelCard: cardUpload);

  //     if (result != null) {
  //       log('berhasil');
  //       var id = result.data?.transactionId ?? '';

  //       if (selectedIndex == 1) {
  //         var idResult = result.data?.sId ?? '';

  //         if (idResult != '') {
  //           var resultPayment = await ApiServices.postPayment(idResult);
  //           if (resultPayment?.invoiceUrl != null) {
  //             Get.offNamed(Routes.WEB_VIEW_PAGE, arguments: {
  //               'url': resultPayment?.invoiceUrl,
  //               'from': 'product',
  //             });
  //           }
  //         }
  //       } else {
  //         Get.back();
  //         Get.back();

  //         var getPage = Get.find<RootPageController>();
  //         getPage.onItemTapped(3);
  //         getPage.getBelumDibayar();
  //       }

  //       return id;
  //     }
  //   } else {
  //     log("Belum login");
  //   }
  //   return null;
  // }

  int? selectedIndex;
  bool selectCheck = false;
  bool pilih = true;
  void onCheck(bool? value) async {
    selectCheck = value ?? false;

    update();
  }

  onClick(value) {
    selectedIndex != null ? onCheck(value) : pilih = false;
    update();
  }

  String formatPrice(double productPrice) {
    final formatter = NumberFormat.currency(
      symbol: 'Rp',
      decimalDigits: 0,
      locale: 'id_ID',
    );

    return formatter.format(productPrice);
  }

  String formatPriceNoRp(double productPrice) {
    final formatter = NumberFormat.currency(
      symbol: '',
      decimalDigits: 0,
      locale: 'id_ID',
    );
    return formatter.format(productPrice);
  }

  bool usePoint = false;
  void pointRedeem(bool value) {
    usePoint = value ?? false;
    update();
    if (value == true && totalPricePoin == 0) {
      update();
    }

    update();
  }

  var dataLokasi;
  var from;
  @override
  void onReady() async {
    try {
      Map<String, dynamic>? arguments = Get.arguments;
      product = arguments?['product'] as List<ModelDetail?>?;
      from = arguments?['from'];

      product?.forEach((element) {
        subTotal = subTotal + (element?.data?.attributes?.price ?? 0);
      });
      totalPrice = subTotal;

      update();
    } catch (e) {
      // log(e.toString());
    }

    productIdsAsString = getProductIdsAsString(product);
    super.onReady();
  }
}
