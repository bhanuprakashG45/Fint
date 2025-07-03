import 'dart:convert';

import 'package:fint/core/exceptions/app_exceptions.dart';
import 'package:fint/core/network/network_api_services.dart';
import 'package:fint/model/profile_model/profile_model.dart';

class ProfileRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<ProfileModel> fetchProfile(context, String url) async {
    print("Entered into Profile repo");
    try {
      final response = await _apiServices.getApiResponse(context, url);

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

  Future<ProfileModel> updateprofileData(context, String url, dynamic data) async {
    try {
      final response = await _apiServices.patchApiResponse(context, url, data);
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
