import 'package:fint/core/constants/exports.dart';
import 'package:fint/model/advertisement_model/advertisement_model.dart';

class AdvertisementRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<AdvertisementModel> fetchAdvertisements() async {
    try {
      const url = AppUrls.getAdvUrl;
      final response = await _apiServices.getApiResponse(url);
      Map<String, dynamic> jsonMap;

      if (response is Map<String, dynamic>) {
        jsonMap = response;
      } else if (response is String) {
        jsonMap = json.decode(response);
      } else {
        throw AppException('Unexpected response format', '');
      }
      return AdvertisementModel.fromJson(jsonMap);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('', 'Fetch Advertisement failed: $e');
    }
  }
}
