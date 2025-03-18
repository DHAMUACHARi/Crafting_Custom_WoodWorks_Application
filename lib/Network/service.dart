import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:crafting_custom_woodworks/models/user_model.dart';
import 'api_urls.dart';

class Service {
  final Dio dio = Dio();

  // Sign Up API
  Future<UserResponse?> signUp(UserRequest user) async {
    try {
      Response response = await dio.post(
        ApiUrls.signUpUrl,
        data: user.toJson(),
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );

      print('API Response: ${response.data}'); // Debugging log

      if (response.statusCode == 201 && response.data != null) {
        return UserResponse.fromJson(response.data);
      } else {
        print("Unexpected Response: ${response.data}");
        return null;
      }
    } catch (e) {
      print("API Error: $e");
      return null;
    }
  }

  // Login API
  Future<LoginResponseModel?> login(String email, String password) async {
    try {

      Response response = await dio.post(
        ApiUrls.loginUrl,
        data: {"email": email, "password": password},
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        return LoginResponseModel.fromJson(response.data);
      } else {
        print("Unexpected Response: ${response.data}");
        return null;
      }
    } catch (e) {
      print("Login Error: $e");
      return null;
    }
  }
}
