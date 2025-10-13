import 'package:fint/core/constants/exports.dart';
import 'package:fint/core/repository/insurance/insurance_repository.dart';

class PetInsuranceViewmodel with ChangeNotifier {
  final InsuranceRepository _repository = InsuranceRepository();

  Future<void> applyPetInsurance(
    context,
    String name,
    String email,
    String password,
    String phoneNumber,
    String address,
    String pincode,
    String parentAge,
    String petName,
    String petBreed,
    String petAge,
    String petAddress,
  ) async {
    try {
      final url = AppUrls.applyPetInsuranceUrl;

      final result = await _repository.applyPetInsurance(
        context,
        url,
        name,
        email,
        password,
        phoneNumber,
        address,
        pincode,
        parentAge,
        petName,
        petBreed,
        petAge,
        petAddress,
      );
      if (result.success) {
        notifyListeners();
        ToastHelper.show(
          context,
          result.message,
          type: ToastificationType.success,
          duration: Duration(seconds: 3),
        );
        Navigator.pop(context);
      } else {
        ToastHelper.show(
          context,
          "Registration Failed",
          type: ToastificationType.error,
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      if (e is AppException) {
        ToastHelper.show(
          context,
          e.userFriendlyMessage,

          type: ToastificationType.error,
          duration: Duration(seconds: 3),
        );
      } else {
        ToastHelper.show(
          context,
          "An UnExcpected error",

          type: ToastificationType.error,
          duration: Duration(seconds: 3),
        );
      }
    }
  }
}
