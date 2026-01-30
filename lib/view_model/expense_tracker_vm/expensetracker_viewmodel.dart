import 'package:fint/core/constants/exports.dart';
import 'package:fint/core/repository/expensetracker_rep/expensetracker_repository.dart';
import 'package:fint/model/expensetracker_model/expensetrackernames_model.dart';

class ExpensetrackerViewmodel with ChangeNotifier {
  final ExpensetrackerRepository _repository = ExpensetrackerRepository();

  String _phoneNumber = '';

  String get phoneNumber => _phoneNumber;

  bool get isPhoneValid => _phoneNumber.length == 10;

  void updatePhone(String value) {
    if (_phoneNumber == value) return;
    _phoneNumber = value;
    notifyListeners();
  }

  void clear() {
    _phoneNumber = '';
    notifyListeners();
  }

  List<ExpenseTrackerData> _expenseTrackerData = [];
  List<ExpenseTrackerData> get expenseTrackerData => _expenseTrackerData;

  bool _isExpenseTrackerNamesLoading = false;
  bool get isExpenseTrackerNamesLoading => _isExpenseTrackerNamesLoading;

  set isExpenseTrackerNamesLoading(bool value) {
    _isExpenseTrackerNamesLoading = value;
    notifyListeners();
  }

  Future<void> fetchExpenseTrackerNames(BuildContext context) async {
    isExpenseTrackerNamesLoading = true;
    try {
      final response = await _repository.getExpenseTrackerNames();
      if (response.success) {
        _expenseTrackerData = response.data;
        notifyListeners();
      } else {
        ToastHelper.show(
          context,
          response.message,
          type: ToastificationType.error,
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isExpenseTrackerNamesLoading = false;
    }
  }
}
