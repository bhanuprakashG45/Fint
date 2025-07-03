import 'package:fint/core/exceptions/app_exceptions.dart';
import 'package:fint/core/repository/auth_rep/signup_repository.dart';
import 'package:fint/core/constants/exports.dart';

class SignupViewmodel with ChangeNotifier {
  final SignupRepository _repository = SignupRepository();

  CreateUser? _userData;
  CreateUser? get userData => _userData;

  bool _isSignupLoading = false;
  bool get isSignupLoading => _isSignupLoading;

  void setsignupLoading(bool value) {
    _isSignupLoading = value;
    notifyListeners();
  }

  Future<void> signup(
    String name,
    String phoneNumber,
    String email,
    String bloodGroup,
    String pinCode,
    BuildContext context,
  ) async {
    setsignupLoading(true);
    print("Entered into SignUp Viewmodel");
    try {
      final result = await _repository.signUp(
        contex: context,
        name: name,
        phone: phoneNumber,
        email: email,
        bloodGroup: bloodGroup,
        pinCode: pinCode,
      );

      if (result.success) {
        _userData = result.data.createUser;
        notifyListeners();

        ToastHelper.show(
          context,
          result.message.isNotEmpty ? result.message : "Sign up successful",
          type: ToastificationType.success,
          duration: const Duration(seconds: 3),
        );

        Navigator.pushNamed(context, RoutesName.loginscreen);
      } else {
        throw Exception("Sign Up Failed :${result.statusCode}");
      }
    } catch (e) {
      if (e is AppException) {
        ToastHelper.show(
          context,
          e.userFriendlyMessage,
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
    } finally {
      setsignupLoading(false);
      notifyListeners();
    }
  }
}
