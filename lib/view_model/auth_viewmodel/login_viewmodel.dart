import 'package:fint/core/constants/exports.dart';
import 'package:fint/core/exceptions/app_exceptions.dart';
import 'package:fint/core/repository/auth_rep/login_repository.dart';
import 'package:fint/model/auth_model/login_model.dart';

class LoginViewModel with ChangeNotifier {
  final LoginRepository _repository = LoginRepository();
  final SharedPref _pref = SharedPref();

  LoginData? _userLoginData;
  LoginData? get userLoginData => _userLoginData;

  bool _isLoginLoading = false;
  bool get isLoginLoading => _isLoginLoading;

  set isLoginLoading(bool value) {
    _isLoginLoading = value;
    notifyListeners();
  }

  Future<bool> loginUser(String phoneNumber, BuildContext context) async {
    isLoginLoading = true;

    try {
      final result = await _repository.login(phoneNumber);

      if (result.success) {
        _userLoginData = result.data;
        notifyListeners();

        ToastHelper.show(
          context,
          result.message.isNotEmpty ? result.message : "Login successful",
          type: ToastificationType.success,
          duration: const Duration(seconds: 3),
        );
        return true;
      } else {
        ToastHelper.show(
          context,
          result.message.isNotEmpty ? result.message : "Login Failed",
          type: ToastificationType.error,
          duration: const Duration(seconds: 3),
        );
        return false;
      }
    } catch (e) {
      if (e is AppException) {
        ToastHelper.show(
          context,
          e.userFriendlyMessage,
          type: ToastificationType.error,
          duration: const Duration(seconds: 3),
        );
        debugPrint(e.userFriendlyMessage);
      }
      return false;
    } finally {
      isLoginLoading = false;
    }
  }

  Future<void> sendDeviceToken(BuildContext context) async {
    final deviceToken = await _pref.fetchDeviceToken();
    debugPrint("$deviceToken");

    try {
      final response = await _repository.sendDeviceToken(deviceToken!);
      if (response.message == "Token subscribed to 'all' topic successfully") {
        debugPrint("Device Token Send SuccessFully");
      }
    } catch (e) {
      if (e is AppException) {
        ToastHelper.show(
          context,
          e.userFriendlyMessage,
          type: ToastificationType.error,
          duration: const Duration(seconds: 3),
        );
      }
    }
  }
}
