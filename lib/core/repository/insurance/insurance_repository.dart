import 'package:fint/core/constants/exports.dart';

class InsuranceRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<PetInsuranceModel> applyPetInsurance(
    String url,
    String name,
    String email,
    String password,
    String phoneNumber,
    String address,
    String pincode,
    String parentAge,
    String petName,
    String petBreed,
    String petAge,
    String petAddress,
  ) async {
    try {
      final body = {
        "name": name,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
        "address": address,
        "pinCode": pincode,
        "parentAge": parentAge,
        "petName": petName,
        "petBreed": petBreed,
        "petAge": petAge,
        "petAddress": petAddress,
        "petNoseImg": null,
      };
      final response = await _apiServices.postApiResponse(url, body);

      Map<String, dynamic> jsonMap;
      if (response is Map<String, dynamic>) {
        jsonMap = response;
      } else if (response is String) {
        jsonMap = json.decode(response);
      } else {
        throw AppException('Unexpected response format', '');
      }

      print("Registration JSON: $jsonMap");

      return PetInsuranceModel.fromJson(jsonMap);
    } catch (e) {
      print("Registration Error: $e");
      if (e is AppException) {
        rethrow;
      } else {
        throw AppException('Signup Error', 'Failed to sign up: $e');
      }
    }
  }
}
