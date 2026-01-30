import 'package:fint/core/constants/exports.dart';
import 'package:fint/core/repository/bank_rep/bank_accounts_repository.dart';
import 'package:fint/model/profile_model/bank_accounts/get_allbankaccounts_model.dart';

class BankaccountsViewmodel with ChangeNotifier {
  final BankAccountsRepository _repository = BankAccountsRepository();

  bool _isBankAccountAdding = false;
  bool get isBankAccountAdding => _isBankAccountAdding;

  set isBankAccountAdding(bool value) {
    _isBankAccountAdding = value;
    notifyListeners();
  }

  List<BankAccounts> _allBankAccounts = [];
  List<BankAccounts> get allBankAccounts => _allBankAccounts;

  bool _isAllBankAccountsLoading = false;
  bool get isAllBankAccountsLoading => _isAllBankAccountsLoading;

  set isAllBankAccountsLoading(bool value) {
    _isAllBankAccountsLoading = value;
    notifyListeners();
  }

  void removebankAccount(String bankId) {
    _allBankAccounts.removeWhere((bank) => bank.id == bankId);
    notifyListeners();
  }

  Future<bool> addBankAccount(BuildContext context, dynamic body) async {
    isBankAccountAdding = true;
    try {
      final result = await _repository.addBankAccount(body);

      if (result.success) {
        await getAllBankAccounts(context);
        ToastHelper.show(
          context,
          result.message,
          type: ToastificationType.success,
          duration: const Duration(seconds: 3),
        );

        return true;
      } else {
        ToastHelper.show(
          context,
          result.message,
          type: ToastificationType.error,
          duration: const Duration(seconds: 3),
        );
        return false;
      }
    } catch (e) {
      if (e is AppException) {
        ToastHelper.show(
          context,
          e.message ?? "Failed to Add Bank Account",
          type: ToastificationType.error,
          duration: const Duration(seconds: 3),
        );
      } else {
        ToastHelper.show(
          context,
          "An unexpected error occurred.",
          type: ToastificationType.error,
          duration: const Duration(seconds: 3),
        );
      }
      return false;
    } finally {
      isBankAccountAdding = false;
    }
  }

  Future<void> getAllBankAccounts(BuildContext context) async {
    isAllBankAccountsLoading = true;
    try {
      final response = await _repository.getAllBankAccounts();
      if (response.success) {
        _allBankAccounts = response.data.bankAccounts;
      } else {
        ToastHelper.show(
          context,
          response.message,
          type: ToastificationType.error,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      ToastHelper.show(
        context,
        e.toString(),
        type: ToastificationType.error,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isAllBankAccountsLoading = false;
    }
  }

  Future<void> updateBankAccount(BuildContext context, String bankId) async {
    for (final bank in _allBankAccounts) {
      bank.isActive = bank.id == bankId;
    }
    notifyListeners();
    try {
      final body = {"isActive": true};
      final response = await _repository.updateBankAccount(bankId, body);
      if (response.success) {
      } else {
        ToastHelper.show(
          context,
          response.message,
          type: ToastificationType.error,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      ToastHelper.show(
        context,
        e.toString(),
        type: ToastificationType.error,
        duration: const Duration(seconds: 3),
      );
    }
  }

  Future<void> deleteBankAccount(BuildContext context, String bankId) async {
    removebankAccount(bankId);
    try {
      final response = await _repository.deleteBankAccount(bankId);
      if (response.success) {
        notifyListeners();
      } else {
        ToastHelper.show(
          context,
          response.message,
          type: ToastificationType.error,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      ToastHelper.show(
        context,
        e.toString(),
        type: ToastificationType.error,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
