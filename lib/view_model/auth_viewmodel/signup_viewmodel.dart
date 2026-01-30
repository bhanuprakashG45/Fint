import 'package:fint/core/repository/auth_rep/signup_repository.dart';
import 'package:fint/core/constants/exports.dart';

class SignupViewmodel with ChangeNotifier {
  final SignupRepository _repository = SignupRepository();

  CreateUser? _userData;
  CreateUser? get userData => _userData;

  bool _isSignupLoading = false;
  bool get isSignupLoading => _isSignupLoading;

  set isSignupLoading(bool value) {
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
    isSignupLoading = true;
    print("Entered into SignUp Viewmodel");
    try {
      final result = await _repository.signUp(
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
        ToastHelper.show(
          context,
          result.message.isNotEmpty ? result.message : "Sign up Failed",
          type: ToastificationType.success,
          duration: const Duration(seconds: 3),
        );
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
      }
    } finally {
      isSignupLoading = false;
    }
  }
}
