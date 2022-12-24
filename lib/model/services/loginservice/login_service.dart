import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:scotch/model/api/api_baseurl.dart';
import 'package:scotch/model/api/api_endpoints.dart';
import 'package:scotch/model/model/loginmodel/login_model.dart';
import 'package:scotch/model/model/loginmodel/login_token.dart';
import 'package:scotch/model/util/dio_exception.dart';

class LoginService {
  Dio dio = Dio();

  Future<LoginTokenModel?> loginUser(
      LoginModel value, BuildContext context) async {
    LoginModel? loginModel;
    try {
      Response response = await dio.post(
          ApiBaseUrl().baseUrl + ApiEndPoints.logIn,
          data: jsonEncode(value.toJson()));

      if (response.data == 200 || response.data == 201) {
        final loginModel = LoginTokenModel.fromJson(response.data);
        log(response.data.toString());
        return loginModel;
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e, context);
    }
    return null;
  }
}