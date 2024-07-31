// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:event_digital/app/data/model/model_category.dart';
import 'package:event_digital/app/data/model/model_detail.dart';
import 'package:event_digital/app/data/model/model_edit_profile.dart';
import 'package:event_digital/app/data/model/model_login.dart';
import 'package:event_digital/app/data/model/model_pesanan.dart';
import 'package:event_digital/app/data/model/model_product.dart';
import 'package:event_digital/app/data/model/model_profile.dart';
import 'package:event_digital/app/data/model/model_promotion.dart';
import 'package:event_digital/app/data/model/model_sepeda.dart';
import 'package:event_digital/config/api_client.dart';
import 'package:event_digital/config/api_interface.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;

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
    } on DioException catch (_) {
      EasyLoading.dismiss();
      EasyLoading.showError('Gagal Login');

      return null;
    }
    if (result.statusCode == 200 || result.statusCode == 201) {
      var modelAuth = ModelLogin.fromJson(result.data);

      EasyLoading.dismiss();
      return modelAuth;
    } else {
      var modelAuth = ModelLogin.fromJson(result.data);
      EasyLoading.dismiss();
      EasyLoading.showError('Gagal Login');
      // EasyLoading.showError(modelAuth.)
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
    } on DioException catch (_) {
      // EasyLoading.showError(e.response?.data['message']);
      EasyLoading.dismiss();

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

  static Future<bool?> postTransaction({required ModelPesanan modelCard}) async {
    Dio dio = ApiInterfaceToken.instance.api;
    String url = 'orders';
    Response? result;

    EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
    );
    try {
      result = await dio.post(url, data: modelCard.toJson());
    } on DioException catch (e) {
      EasyLoading.showError('Gagal');
      return false;
    }
    if (result.statusCode == 200 || result.statusCode == 201) {
      EasyLoading.dismiss();

      return true;
    } else {
      EasyLoading.dismiss();
      var modelAuth = ModelPesanan.fromJson(result.data);
      // EasyLoading.showError(modelAuth.message.toString());
      return false;
    }
  }

  Future<ModelProduct?> filterCategory(String? category) async {
    Dio dio = ApiInterfaceToken.instance.api;
    String url = 'products?populate=%2A&filters%5Bcategory%5D[name]=$category';

    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        var modelCategory = ModelProduct.fromJson(response.data);
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

  Future<ModelProfile?> getProfile(int? id) async {
    Dio dio = ApiInterfaceToken.instance.api;
    String url = 'users/$id?populate=%2A';

    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        var modelProfile = ModelProfile.fromJson(response.data);

        return modelProfile;
      } else {
        return null;
      }
    } catch (e) {
      // log(e);
      return null;
    }
  }

  Future<ModelPromotion?> getPromotion() async {
    Dio dio = ApiInterfaceToken.instance.api;
    String url = 'promotions';

    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        var modelProfile = ModelPromotion.fromJson(response.data);

        return modelProfile;
      } else {
        return null;
      }
    } catch (e) {
      // log(e);
      return null;
    }
  }

  Future<bool?> deleteAccount(int? id) async {
    Dio dio = ApiInterfaceToken.instance.api;
    String url = '/users/$id';

    try {
      Response response = await dio.delete(url);
      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Successfully delete account');
        return true;
      } else {
        EasyLoading.showError('Failed to delete account');
        return false;
      }
    } catch (e) {
      EasyLoading.showError('Failed to delete account');
      return false;
    }
  }

  // Future<ModelEditProfile?> editProfilePhoto({required String image, required int? id}) async {
  //   Dio dio = ApiInterfaceToken.instance.api;
  //   String urlUpload = 'upload';
  //   String url = 'users/$id';
  //   String? imageUpload;
  //   Response? result;
  //   EasyLoading.show();
  //   try {
  //     FormData formData;
  //     formData = FormData.fromMap(
  //       {
  //         'files': await MultipartFile.fromFile(
  //           image,
  //           filename: image,
  //           contentType: MediaType('image', p.extension(image)),
  //         ),
  //       },
  //     );
  //     var data = await dio.post(urlUpload, data: formData);
  //     try {
  //       imageUpload = AppClient.baseUrlImage + data.data[0]['url'];
  //     } catch (_) {}
  //     EasyLoading.dismiss();
  //   } on DioException catch (_) {
  //     EasyLoading.dismiss();
  //     EasyLoading.showError('Gagal');
  //     return null;
  //   }
  //   try {
  //     FormData formData;
  //     formData = FormData.fromMap(
  //       {
  //         'image': imageUpload,
  //       },
  //     );
  //     result = await dio.put(url, data: formData);
  //     EasyLoading.dismiss();
  //   } on DioException catch (_) {
  //     EasyLoading.dismiss();
  //     EasyLoading.showError('Gagal');
  //     return null;
  //   }
  //   if (result.statusCode == 200) {
  //     var modelAuth = ModelEditProfile.fromJson(result.data);
  //     EasyLoading.dismiss();
  //     EasyLoading.showSuccess('Berhasil');
  //     return modelAuth;
  //   } else {
  //     EasyLoading.dismiss();
  //     EasyLoading.showError('Gagal');
  //     return null;
  //   }
  // }

  Future<ModelEditProfile?> editProfilePhoto({required String image, required int? id}) async {
    Dio dio = ApiInterfaceToken.instance.api;
    String urlUpload = 'upload';
    String url = 'users/$id';
    String? imageUpload;
    Response? result;

    try {
      // Show loading indicator
      EasyLoading.show();

      // Step 1: Upload image file
      FormData formData = FormData.fromMap({
        'files': await MultipartFile.fromFile(
          image,
          filename: 'image', // Use a fixed filename
          contentType: MediaType('image', p.extension(image)!), // Extract mime type using mime package
        ),
      });

      // Make the request to upload the image
      var uploadResponse = await dio.post(urlUpload, data: formData);

      // Extract the uploaded image URL
      imageUpload = AppClient.baseUrlImage + uploadResponse.data[0]['url'];

      // Step 2: Update user profile with the uploaded image URL
      FormData updateFormData = FormData.fromMap({
        'image': imageUpload,
      });

      // Make the request to update the user profile
      result = await dio.put(url, data: updateFormData);

      // Dismiss loading indicator
      EasyLoading.dismiss();
    } on DioError catch (e) {
      // Handle Dio errors
      EasyLoading.dismiss();
      EasyLoading.showError('Gagal: ${e.message}');
      return null;
    }

    // Process the response
    if (result?.statusCode == 200) {
      var modelAuth = ModelEditProfile.fromJson(result?.data);
      EasyLoading.showSuccess('Berhasil');
      return modelAuth;
    } else {
      EasyLoading.showError('Gagal');
      return null;
    }
  }

  Future<ModelEditProfile?> editProfile({required String email, required String password, required String address, required String phone, required String username, int? id}) async {
    Dio dio = ApiInterfaceToken.instance.api;
    String url = 'users/$id';
    Response? result;
    EasyLoading.show();
    try {
      result = await dio.put(url, data: {
        'username': username,
        'email': email,
        'password': password,
        'address': address,
        'phone_no': phone,
      });
      EasyLoading.dismiss();
    } on DioException catch (_) {
      EasyLoading.dismiss();
      EasyLoading.showError('Gagal');
      return null;
    }
    if (result.statusCode == 200) {
      var modelAuth = ModelEditProfile.fromJson(result.data);
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Berhasil');
      return modelAuth;
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError('Gagal');
      return null;
    }
  }

  static Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmationPassword,
    String? id,
  }) async {
    Dio dio = ApiInterfaceToken.instance.api;
    String url = 'auth/change-password';

    EasyLoading.show();
    try {
      await dio.post(url, data: {
        'currentPassword': oldPassword,
        'password': newPassword,
        'passwordConfirmation': confirmationPassword,
      });
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Berhasil Mengubah Password');
      return true;
    } on DioException catch (_) {
      EasyLoading.dismiss();
      EasyLoading.showError('Gagal Mengubah Password');

      return false;
    }
  }

  static Future<bool?> postSepeda({required ModelSepeda modelCard}) async {
    Dio dio = ApiInterfaceToken.instance.api;
    String url = 'master-sepedas';
    Response? result;

    EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
    );
    try {
      result = await dio.post(url, data: modelCard.toJson());
    } on DioException catch (e) {
      EasyLoading.showError('Gagal');
      return false;
    }
    if (result.statusCode == 200 || result.statusCode == 201) {
      EasyLoading.dismiss();

      return true;
    } else {
      EasyLoading.dismiss();
      var modelAuth = ModelPesanan.fromJson(result.data);
      // EasyLoading.showError(modelAuth.message.toString());
      return false;
    }
  }
}
