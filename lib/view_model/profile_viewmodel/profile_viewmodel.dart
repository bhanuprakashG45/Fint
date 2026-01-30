import 'package:fint/core/constants/exports.dart';
import 'package:fint/core/exceptions/app_exceptions.dart';
import 'package:fint/core/repository/profile_rep/profile_repository.dart';
import 'package:fint/core/storage/shared_preference.dart';
import 'package:fint/model/profile_model/profile_model.dart';

class ProfileViewmodel with ChangeNotifier {
  SharedPref prefs = SharedPref();

  final ProfileRepository _repository = ProfileRepository();

  bool _isFetchingProfile = false;
  bool get isFetchingProfile => _isFetchingProfile;

  set isFetchingProfile(bool value) {
    _isFetchingProfile = value;
    notifyListeners();
  }

  bool _isProfileUpdating = false;
  bool get isProfileUpdating => _isProfileUpdating;

  set isProfileUpdating(bool value) {
    _isProfileUpdating = value;
    notifyListeners();
  }

  UserProfile _profileData = UserProfile(
    id: '',
    name: '',
    phoneNumber: '',
    bloodGroup: '',
    email: '',
    pinCode: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    beADonor: false,
    avatar: '',
  );
  UserProfile get profileData => _profileData;

  Future<void> fetchProfileDetails(context) async {
    isFetchingProfile = true;

    try {
      final url = AppUrls.profileUrl;
      final result = await _repository.fetchProfile(url);
      if (result.success == true) {
        final responseData = result.data.user;
        _profileData = responseData;
        notifyListeners();
      } else {
        throw Exception("Failed to Fetch Profile Details:${result.statusCode}");
      }
    } catch (e) {
      if (e is AppException) {
        print(e.userFriendlyMessage);
      } else {
        ToastHelper.show(
          context,
          "An unexpected error occurred.",
          type: ToastificationType.error,
          duration: const Duration(seconds: 3),
        );
      }
    } finally {
      isFetchingProfile = false;
    }
  }

  Future<void> updateProfile(
    BuildContext context, {
    String? name,
    String? pinCode,
    bool? beADonor,
  }) async {
    isProfileUpdating = true;
    try {
      final url = AppUrls.updateProfileUrl;
      final Map<String, dynamic> data = {};

      if (name != null) data['name'] = name;
      if (pinCode != null) data['pinCode'] = pinCode;
      if (beADonor != null) data['beADonor'] = beADonor;
      print("Entered into update vm");

      final result = await _repository.updateprofileData(url, data);

      print("Updated Data :${result.data}");

      if (result.success == true) {
        notifyListeners();
        ToastHelper.show(
          context,
          result.message,
          type: ToastificationType.success,
          duration: Duration(seconds: 3),
        );
      } else {
        ToastHelper.show(
          context,
          result.message,
          type: ToastificationType.error,
          duration: Duration(seconds: 3),
        );
        throw Exception("Failed to update profile.");
      }
    } catch (e) {
      if (e is AppException) {
        print(e.userFriendlyMessage);
      } else {
        ToastHelper.show(
          context,
          "An exception occurred",
          type: ToastificationType.error,
        );
      }
    } finally {
      isProfileUpdating = false;
    }
  }
}
