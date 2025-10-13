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

  set setLoginLoading(bool value) {
    _isLoginLoading = value;
    notifyListeners();
  }

  Future<void> loginUser(String phoneNumber, BuildContext context) async {
    setLoginLoading = true;

    try {
      await sendDeviceToken(context);
      final result = await _repository.login(context, phoneNumber);
      print("Entered into Login vm");

      if (result.success) {
        _userLoginData = result.data;
        notifyListeners();

        ToastHelper.show(
          context,
          result.message.isNotEmpty ? result.message : "Login successful",
          type: ToastificationType.success,
          duration: const Duration(seconds: 3),
        );

        Navigator.pushNamed(
          context,
          RoutesName.otpscreen,
          arguments: phoneNumber,
        );
      } else {
        ToastHelper.show(
          context,
          result.message.isNotEmpty ? result.message : "Login Failed",
          type: ToastificationType.error,
          duration: const Duration(seconds: 3),
        );
        throw Exception("Login Failed :${result.statusCode}");
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
    } finally {
      setLoginLoading = false;
    }
  }

  Future<void> sendDeviceToken(BuildContext context) async {
    final deviceToken = await _pref.fetchDeviceToken();
    debugPrint("$deviceToken");

    try {
      final response = await _repository.sendDeviceToken(context, deviceToken!);
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
