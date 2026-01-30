import 'package:fint/core/constants/exports.dart';
import 'package:fint/model/expensetracker_model/expensetrackernames_model.dart';

class ExpensetrackerRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<ExpenseTrackerNamesModel> getExpenseTrackerNames() async {
    try {
      final url = AppUrls.expenseTrackerUrl;
      final response = await _apiServices.getApiResponse(url);
      Map<String, dynamic> jsonMap;

      if (response is Map<String, dynamic>) {
        jsonMap = response;
      } else if (response is String) {
        jsonMap = json.decode(response);
      } else {
        throw AppException('Unexpected response format', '');
      }
      return ExpenseTrackerNamesModel.fromJson(jsonMap);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('', 'Fetch Expense Tracker Names failed: $e');
    }
  }
}
