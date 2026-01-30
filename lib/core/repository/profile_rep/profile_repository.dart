import 'package:fint/core/constants/exports.dart';

class ProfileRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<ProfileModel> fetchProfile(String url) async {
    print("Entered into Profile repo");
    try {
      final response = await _apiServices.getApiResponse(url);

      print("${response}");

      Map<String, dynamic> jsonMap;

      if (response is Map<String, dynamic>) {
        jsonMap = response;
      } else if (response is String) {
        jsonMap = json.decode(response);
      } else {
        throw AppException('Unexpected response format', '');
      }
      return ProfileModel.fromJson(jsonMap);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('', 'Login failed: $e');
    }
  }

  Future<ProfileModel> updateprofileData(String url, dynamic data) async {
    try {
      final response = await _apiServices.patchApiResponse(url, data);
      print("${response}");

      Map<String, dynamic> jsonMap;

      if (response is Map<String, dynamic>) {
        jsonMap = response;
      } else if (response is String) {
        jsonMap = json.decode(response);
      } else {
        throw AppException('Unexpected response format', '');
      }
      return ProfileModel.fromJson(jsonMap);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('', 'Update failed: $e');
    }
  }
}
