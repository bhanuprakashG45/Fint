import 'package:fint/core/constants/exports.dart';
import 'package:fint/model/home_model/notification_model.dart';

class HomeRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<NotificationsModel> fetchNotifications(BuildContext context) async {
    try {
      final url = AppUrls.notificationsUrl;
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
      return NotificationsModel.fromJson(jsonMap);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('', 'Fetch  Notifications failed: $e');
    }
  }
}
