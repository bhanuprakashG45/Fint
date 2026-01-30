import 'package:fint/core/constants/exports.dart';

class SignupRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<SignUpModel> signUp({
    required String phone,
    required String name,
    required String email,
    required String bloodGroup,
    required String pinCode,
  }) async {
    print("Entered into SignUp repository");

    try {
      final Map<String, dynamic> requestBody = {
        "name": name,
        // "email": email,
        "phoneNumber": phone,
        "bloodGroup": bloodGroup,
        "pinCode": pinCode,
      };
      print("Signup Payload: ${jsonEncode(requestBody)}");

      final response = await _apiServices.postApiResponse(
        AppUrls.signUpUrl,
        requestBody,
      );

      Map<String, dynamic> jsonMap;
      if (response is Map<String, dynamic>) {
        jsonMap = response;
      } else if (response is String) {
        jsonMap = json.decode(response);
      } else {
        throw AppException('Unexpected response format', '');
      }

      print("Signup Response JSON: $jsonMap");

      return SignUpModel.fromJson(jsonMap);
    } catch (e) {
      print("SignUp Error: $e");
      if (e is AppException) {
        rethrow;
      } else {
        throw AppException('Signup Error', 'Failed to sign up: $e');
      }
    }
  }
}
