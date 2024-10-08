import 'dart:io';

import 'package:dio/dio.dart';
import 'package:event_digital/app/data/services/user_services.dart';
import 'package:event_digital/app/routes/app_pages.dart';
import 'package:event_digital/config/api_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;

class ApiInterface {
  late Dio api;
  static final ApiInterface _instance = ApiInterface._privateConstructor();
  factory ApiInterface() => _instance;

  static ApiInterface get instance => _instance;
  ApiInterface._privateConstructor() {
    BaseOptions options = BaseOptions(
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      baseUrl: AppClient.baseUrl,
    );
    api = Dio(options);

    api.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          handler.next(options);
        },
        onError: (e, handler) => _onError(e, handler),
        onResponse: (e, handler) {
          api.options.queryParameters.clear();
          return handler.next(e);
        },
      ),
    );
  }

  //FUNCTION ON ERROR INTERFACE
  Future<dynamic> _onError(DioException e, ErrorInterceptorHandler handler) async {
    Response? response = e.response;
    api.options.queryParameters.clear();
    if (response?.statusCode == HttpStatus.unauthorized || response?.statusCode == HttpStatus.forbidden) {
      getx.Get.toNamed(Routes.LOGIN_PAGE);
      try {
        handler.next(e);
      } catch (e) {
        // log("error internet");
      }
    }
    try {
      handler.next(e);
    } catch (e) {
      // log("error internet");
    }
  }
}

class ApiInterfaceToken {
  late Dio api;
  static final ApiInterfaceToken _instance = ApiInterfaceToken._privateConstructor();
  factory ApiInterfaceToken() => _instance;

  static ApiInterfaceToken get instance => _instance;
  ApiInterfaceToken._privateConstructor() {
    BaseOptions options = BaseOptions(
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      baseUrl: AppClient.baseUrl,
    );
    api = Dio(options);

    api.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          var dataLogin = await UserService.find.getLocalUser();

          options.headers.addAll({"Authorization": "Bearer ${dataLogin?.token}"});

          handler.next(options);
        },
        onError: (e, handler) => _onError(e, handler),
        onResponse: (e, handler) {
          api.options.queryParameters.clear();
          return handler.next(e);
        },
      ),
    );
  }

  //FUNCTION ON ERROR INTERFACE
  Future<dynamic> _onError(DioException e, ErrorInterceptorHandler handler) async {
    Response? response = e.response;
    api.options.queryParameters.clear();
    if (response?.statusCode == HttpStatus.unauthorized || response?.statusCode == HttpStatus.forbidden) {
      getx.Get.toNamed(Routes.LOGIN_PAGE);
      try {
        handler.next(e);
      } catch (e) {
        // log("error internet");
      }
    }
    try {
      handler.next(e);
    } catch (e) {
      // log("error internet");
    }
  }
}
