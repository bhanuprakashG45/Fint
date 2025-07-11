import 'dart:convert';
import 'package:fint/core/constants/exports.dart';
import 'package:fint/core/network/network_api_services.dart';
import 'package:fint/core/exceptions/app_exceptions.dart';
import 'package:fint/model/auth_model/login_model.dart';

class LoginRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<LoginModel> login(BuildContext context, String phone) async {
    print("Entered into Login repo");
    try {
      final body = {"phoneNumber": phone};

      final response = await _apiServices.postApiResponse(
        context,
        AppUrls.loginUrl,
        body,
      );

      Map<String, dynamic> jsonMap;

      if (response is Map<String, dynamic>) {
        jsonMap = response;
      } else if (response is String) {
        jsonMap = json.decode(response);
      } else {
        throw AppException('Unexpected response format', '');
      }

      return LoginModel.fromJson(jsonMap);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('', 'Login failed: $e');
    }
  }
}
