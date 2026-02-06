import 'package:fint/core/repository/auth_rep/otp_repository.dart';
import 'package:fint/core/constants/exports.dart';

class OtpViewModel with ChangeNotifier {
  final OtpRepository _repository = OtpRepository();
  SharedPref pref = SharedPref();

  OtpData? _otpData;
  OtpData? get otpData => _otpData;

  bool _isOtpLoading = false;
  bool get isOtpLoading => _isOtpLoading;

  set isOtpLoading(bool value) {
    _isOtpLoading = value;
    notifyListeners();
  }

  Future<bool> verifyOtp(
    String phoneNumber,
    String otp,
    BuildContext context,
  ) async {
    isOtpLoading = true;

    try {
      final deviceToken = await pref.fetchDeviceToken();
      debugPrint("Device Token From OTP : $deviceToken");
      final result = await _repository.verifyOtp(
        phoneNumber,
        otp,
        deviceToken ?? '',
      );

      if (result.success) {
        await pref.clearAccessToken();
        await pref.clearRefreshToken();
        await pref.clearUserId();
        await pref.clearUserName();
        await pref.clearUserMobile();
        _otpData = result.data;
        final accesstoken = otpData?.accessToken;
        final refreshtoken = otpData?.refreshToken;
        final firebaseToken = otpData?.firebaseToken;
        await pref.storeUserId(otpData?.user?.id ?? '');
        await pref.storeUserName(otpData?.user?.name ?? '');
        await pref.storeUserMobile(otpData?.user?.phoneNumber ?? '');
        await pref.storeAccessToken(accesstoken);
        await pref.storeRefreshToken(refreshtoken);
        await pref.storeDeviceToken(firebaseToken ?? '');

        print("Access:$accesstoken");
        print("Refresh:$refreshtoken");
        print("FIrebase:$firebaseToken");
        // await context.read<BankaccountsViewmodel>().getAllBankAccounts(context);

        notifyListeners();

        ToastHelper.show(
          context,
          result.message.isNotEmpty
              ? result.message
              : "OTP verified successfully",
          type: ToastificationType.success,
          duration: const Duration(seconds: 3),
        );
        return true;
      } else {
        ToastHelper.show(
          context,
          result.message.isNotEmpty ? result.message : "Invalid Otp",
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
      isOtpLoading = false;
    }
  }
}
