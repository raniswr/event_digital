import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:event_digital/app/data/model/model_category.dart';
import 'package:event_digital/app/data/model/model_detail.dart';
import 'package:event_digital/app/data/model/model_login.dart';
import 'package:event_digital/app/data/model/model_product.dart';
import 'package:event_digital/config/api_interface.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http_parser/http_parser.dart';

class ApiServices {
  static Future<ModelLogin?> login({required String email, required String password}) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'auth/local';
    Response? result;
    EasyLoading.show();
    try {
      result = await dio.post(url, data: {
        'identifier': email,
        'password': password,
      });
      EasyLoading.dismiss();
    } on DioException catch (e) {
      EasyLoading.dismiss();

      return null;
    }
    if (result.statusCode == 200 || result.statusCode == 201) {
      var modelAuth = ModelLogin.fromJson(result.data);
      EasyLoading.dismiss();
      return modelAuth;
    } else {
      EasyLoading.dismiss();
      return null;
    }
  }

  static Future<bool?> register({
    required String username,
    required String password,
    required String phone,
    required String email,
    required String address,
  }) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'auth/local/register';
    Response? result;
    EasyLoading.show();
    try {
      result = await dio.post(url, data: {
        'username': username,
        'email': email,
        'address': address,
        'phone_no': phone,
        'password': password,
      });
    } on DioException catch (e) {
      // EasyLoading.showError(e.response?.data['message']);
      EasyLoading.dismiss();
      print(e);
      return null;
    }
    if (result.statusCode == 200 || result.statusCode == 201) {
      EasyLoading.dismiss();
      return true;
    } else {
      EasyLoading.showError('Failed to Register');
      return null;
    }
  }

  Future<ModelProduct?> getAllProduct() async {
    Dio dio = ApiInterfaceToken.instance.api;
    String url = 'products?populate=%2A';

    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        var modelGetAllProduct = ModelProduct.fromJson(response.data);

        return modelGetAllProduct;
      } else {
        return null;
      }
    } catch (e) {
      // log(e);
      return null;
    }
  }

  Future<ModelCategory?> getCategory() async {
    Dio dio = ApiInterfaceToken.instance.api;
    String url = 'categories';

    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        var modelCategory = ModelCategory.fromJson(response.data);

        return modelCategory;
      } else {
        return null;
      }
    } catch (e) {
      // log(e);
      return null;
    }
  }

  Future<ModelDetail?> getDetail(int? id) async {
    Dio dio = ApiInterfaceToken.instance.api;
    String url = 'products/$id?populate=%2A';

    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        var modelCategory = ModelDetail.fromJson(response.data);

        return modelCategory;
      } else {
        return null;
      }
    } catch (e) {
      // log(e);
      return null;
    }
  }
}
