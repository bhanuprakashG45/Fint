import 'package:fint/core/constants/exports.dart';
import 'package:fint/model/auth_model/devicetoken_model.dart';

class LoginRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<LoginModel> login(String phone) async {
    print("Entered into Login repo");
    try {
      final body = {"phoneNumber": phone};

      final response = await _apiServices.postApiResponse(
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

  Future<DeviceTokenModel> sendDeviceToken(String deviceToken) async {
    try {
      final body = {"token": deviceToken};

      final response = await _apiServices.postApiResponse(
        AppUrls.deviceTokenUrl,
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

      return DeviceTokenModel.fromJson(jsonMap);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('', 'Login failed: $e');
    }
  }
}
