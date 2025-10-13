import 'package:fint/core/repository/home_rep/home_repository.dart';
import 'package:fint/model/home_model/notification_model.dart';
import 'package:flutter/material.dart';

class HomeViewmodel with ChangeNotifier {
  final HomeRepository _repository = HomeRepository();

  List<NotificationData> _notificationsData = [];
  List<NotificationData> get notificationData => _notificationsData;

  bool _isNotificationsLoading = false;
  bool get isNotificationsLoading => _isNotificationsLoading;

  set isNotificationsLoading(bool value) {
    _isNotificationsLoading = value;
    notifyListeners();
  }

  Future<void> fetchNotifications(BuildContext context) async {
    isNotificationsLoading = true;
    try {
      final response = await _repository.fetchNotifications(context);
      if (response.success) {
        _notificationsData = response.data;
      } else {
        debugPrint("Failed to Fetch Notifications: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isNotificationsLoading = false;
    }
  }
}
