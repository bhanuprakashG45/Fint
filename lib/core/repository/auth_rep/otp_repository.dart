import 'package:fint/core/constants/exports.dart';

class OtpRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<OtpModel> verifyOtp(
    BuildContext context,
    String phone,
    String otp,
  ) async {
    try {
      final body = {"identifier": phone, "otp": otp, "firebaseToken": ''};

      final response = await _apiServices.postApiResponse(
        context,
        AppUrls.otpUrl,
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

      return OtpModel.fromJson(jsonMap);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('', 'OTP verification failed: $e');
    }
  }
}
