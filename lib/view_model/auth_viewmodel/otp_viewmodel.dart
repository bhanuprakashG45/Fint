import 'package:fint/core/repository/auth_rep/otp_repository.dart';
import 'package:fint/core/constants/exports.dart';
import 'package:fint/core/exceptions/app_exceptions.dart';
import 'package:fint/core/storage/shared_preference.dart';
import 'package:fint/model/auth_model/otp_model.dart';

class OtpViewModel with ChangeNotifier {
  final OtpRepository _repository = OtpRepository();
  SharedPref pref = SharedPref();

  OtpData? _otpData;
  OtpData? get otpData => _otpData;

  bool _isOtpLoading = false;
  bool get isOtpLoading => _isOtpLoading;

  void setOtpLoading(bool value) {
    _isOtpLoading = value;
    notifyListeners();
  }

  Future<void> verifyOtp(
    String phoneNumber,
    String otp,
    BuildContext context,
  ) async {
    setOtpLoading(true);

    try {
      final result = await _repository.verifyOtp(context, phoneNumber, otp);

      if (result.success) {
        _otpData = result.data;
        final accesstoken = otpData?.accessToken;
        final refreshtoken = otpData?.refreshToken;
        final firebaseToken = otpData?.firebaseToken;
        await pref.clearAccessToken();
        await pref.clearRefreshToken();
        await pref.clearFirebaseToken();
        await pref.storeAccessToken(accesstoken);
        await pref.storeRefreshToken(refreshtoken);
        await pref.storeFirebaseToken(firebaseToken);
        print("Access:$accesstoken");
        print("Refresh:$refreshtoken");
        print("FIrebase:$firebaseToken");

        notifyListeners();

        ToastHelper.show(
          context,
          result.message.isNotEmpty
              ? result.message
              : "OTP verified successfully",
          type: ToastificationType.success,
          duration: const Duration(seconds: 3),
        );

        Navigator.pushNamed(context, RoutesName.homescreen);
      } else {
        ToastHelper.show(
          context,
          result.message.isNotEmpty
              ? result.message
              : "Invalid Otp",
          type: ToastificationType.error,
          duration: const Duration(seconds: 3),
        );
        throw Exception("Otp Verified Failed :${result.statusCode}");
      }
    } catch (e) {
      if (e is AppException) {
        ToastHelper.show(
          context,
          e.message?? '',
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
      setOtpLoading(false);
      notifyListeners();
    }
  }
}
