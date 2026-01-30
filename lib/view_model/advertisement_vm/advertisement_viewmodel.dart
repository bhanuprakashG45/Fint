import 'package:fint/core/repository/advertisement_rep/advertisement_repository.dart';
import 'package:fint/model/advertisement_model/advertisement_model.dart';
import 'package:flutter/widgets.dart';

class AdvertisementViewmodel with ChangeNotifier {
  final AdvertisementRepository _repository = AdvertisementRepository();

  AdvData _advData = AdvData(title: '', img: '', description: '');

  AdvData get advData => _advData;

  bool _isAdvLoading = false;
  bool get isAdvLoading => _isAdvLoading;

  set isAdvLoading(bool value) {
    _isAdvLoading = value;
    notifyListeners();
  }

  Future<void> fetchAds() async {
    isAdvLoading = true;
    try {
      final response = await _repository.fetchAdvertisements();

      if (response.success) {
        _advData = response.data;
      } else {
        debugPrint("failed to Fetch Adv :${response.statusCode}");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isAdvLoading = false;
    }
  }
}
