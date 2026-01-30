import 'package:fint/core/constants/exports.dart';
import 'package:fint/model/home_model/claimechange_model.dart';
import 'package:fint/model/home_model/notification_model.dart';
import 'package:fint/model/home_model/transactionhistory_model.dart';

class HomeRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<NotificationsModel> fetchNotifications() async {
    try {
      final url = AppUrls.notificationsUrl;
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
      return NotificationsModel.fromJson(jsonMap);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('', 'Fetch  Notifications failed: $e');
    }
  }

  Future<TransactionHistoryModel> fetchTransactionHistory(
    int pageNumber,
  ) async {
    try {
      final url = "${AppUrls.transactionHistoryUrl}?page=$pageNumber&limit=10";

      final response = await _apiServices.getApiResponse(url);
      debugPrint("Url :$url");

      Map<String, dynamic> jsonMap;

      if (response is Map<String, dynamic>) {
        jsonMap = response;
      } else if (response is String) {
        jsonMap = json.decode(response);
      } else {
        throw AppException('Unexpected response format', 'Exception');
      }
      return TransactionHistoryModel.fromJson(jsonMap);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException(" Fetch Transaction History", "Failed");
    }
  }

  Future<TransactionHistoryModel> filterTransactionHistory(String url) async {
    try {
      final response = await _apiServices.getApiResponse(url);
      debugPrint("Url :$url");

      Map<String, dynamic> jsonMap;

      if (response is Map<String, dynamic>) {
        jsonMap = response;
      } else if (response is String) {
        jsonMap = json.decode(response);
      } else {
        throw AppException('Unexpected response format', 'Exception');
      }
      return TransactionHistoryModel.fromJson(jsonMap);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException("Fetch Filter Transaction History", "Failed");
    }
  }

  Future<ClaimEChangeModel> claimEChange(dynamic body) async {
    try {
      final url = AppUrls.claimEChangeUrl;
      final response = await _apiServices.postApiResponse(url, body);
      print("${response}");

      Map<String, dynamic> jsonMap;

      if (response is Map<String, dynamic>) {
        jsonMap = response;
      } else if (response is String) {
        jsonMap = json.decode(response);
      } else {
        throw AppException('Unexpected response format', '');
      }
      return ClaimEChangeModel.fromJson(jsonMap);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('', 'Claim EChange failed: $e');
    }
  }
}
