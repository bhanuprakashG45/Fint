import 'package:fint/core/constants/exports.dart';
import 'package:fint/model/profile_model/bank_accounts/add_bankaccount_model.dart';
import 'package:fint/model/profile_model/bank_accounts/banknamesandtypes_model.dart';
import 'package:fint/model/profile_model/bank_accounts/delete_bankaccount_model.dart';
import 'package:fint/model/profile_model/bank_accounts/get_allbankaccounts_model.dart';
import 'package:fint/model/profile_model/bank_accounts/update_bankaccount_model.dart';

class BankAccountsRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<AddBankAccountModel> addBankAccount(Map<String, dynamic> body) async {
    try {
      const url = AppUrls.addBankAccountUrl;
      final response = await _apiServices.postApiResponse(url, body);

      Map<String, dynamic> jsonMap;
      if (response is Map<String, dynamic>) {
        jsonMap = response;
      } else if (response is String) {
        jsonMap = json.decode(response);
      } else {
        throw AppException('Unexpected response format', '');
      }

      print("Add Bank Account : $jsonMap");

      return AddBankAccountModel.fromJson(jsonMap);
    } catch (e) {
      print(" Add Bank Account Error: $e");
      if (e is AppException) {
        rethrow;
      } else {
        throw AppException(
          'Add Bank Account Error',
          'Failed to Add Bank Account: $e',
        );
      }
    }
  }

  Future<GetAllBankAccountsModel> getAllBankAccounts() async {
    try {
      final url = AppUrls.getAllBankAccountsUrl;
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
      return GetAllBankAccountsModel.fromJson(jsonMap);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('', 'Fetch All Bank Accounts failed: $e');
    }
  }

  Future<UpdateBankAccountModel> updateBankAccount(
    String bankID,
    dynamic data,
  ) async {
    try {
      final url = "${AppUrls.updateBankAccountUrl}/$bankID";
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
      return UpdateBankAccountModel.fromJson(jsonMap);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('', 'Update failed: $e');
    }
  }

  Future<DeleteBankAccountModel> deleteBankAccount(String bankID) async {
    try {
      final url = "${AppUrls.deleteBankAccountUrl}/$bankID";
      final response = await _apiServices.deleteApiResponse(url);
      print("${response}");

      Map<String, dynamic> jsonMap;

      if (response is Map<String, dynamic>) {
        jsonMap = response;
      } else if (response is String) {
        jsonMap = json.decode(response);
      } else {
        throw AppException('Unexpected response format', '');
      }
      return DeleteBankAccountModel.fromJson(jsonMap);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('', 'Update failed: $e');
    }
  }

  Future<BankNamesAndTypesModel> getBankNamesandCardTypes() async {
    try {
      final url = AppUrls.getBankNamesAndTypesUrl;
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
      return BankNamesAndTypesModel.fromJson(jsonMap);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('', 'Fetch Bank Names and CardTypes failed: $e');
    }
  }
}
