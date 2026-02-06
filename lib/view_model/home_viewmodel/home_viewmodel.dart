import 'package:fint/core/constants/exports.dart';
import 'package:fint/core/repository/home_rep/home_repository.dart';
import 'package:fint/model/home_model/notification_model.dart';
import 'package:fint/model/home_model/transactionhistory_model.dart';

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

  List<TransactionHistoryData> _transactionHistotyData = [];
  List<TransactionHistoryData> get transactionHistoryData =>
      _transactionHistotyData;

  bool _isTransactionHistoryLoading = false;
  bool get isTransactionHistoryLoading => _isTransactionHistoryLoading;

  set isTransactionHistoryLoading(bool value) {
    _isTransactionHistoryLoading = value;
    notifyListeners();
  }

  int _currentTransactionPage = 1;
  int get currentTransactionPage => _currentTransactionPage;

  set currentTransactionPage(int value) {
    _currentTransactionPage = value;
    notifyListeners();
  }

  int _totalTransactionPage = 1;
  int get totalTransactionPage => _totalTransactionPage;

  set totalTransactionPage(int value) {
    _totalTransactionPage = value;
    notifyListeners();
  }

  bool _isMoreTransactionHistoryLoading = false;
  bool get isMoreTransactionHistoryLoading => _isMoreTransactionHistoryLoading;

  set isMoreTransactionHistoryLoading(bool value) {
    _isMoreTransactionHistoryLoading = value;
    notifyListeners();
  }

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  set searchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  List<TransactionHistoryData> _filteredTransactionData = [];
  List<TransactionHistoryData> get filteredTransactionData =>
      _filteredTransactionData;

  int _currentFilterPage = 1;
  int get currentFilterPage => _currentFilterPage;

  set currentFilterPage(int value) {
    _currentFilterPage = value;
    notifyListeners();
  }

  int _totalFilterPage = 1;
  int get totalFilterPage => _totalFilterPage;

  set totalFilterPage(int value) {
    _totalFilterPage = value;
    notifyListeners();
  }

  bool _isFilteringTransactions = false;
  bool get isFilteringTransactions => _isFilteringTransactions;

  set isFilteringTransactions(bool value) {
    _isFilteringTransactions = value;
    notifyListeners();
  }

  bool _isMoreFilteringTransactions = false;
  bool get isMoreFilteringTransactions => _isMoreFilteringTransactions;

  set isMoreFilteringTransactions(bool value) {
    _isMoreFilteringTransactions = value;
    notifyListeners();
  }

  bool _isEchangeClaiming = false;
  bool get isEchangeClaiming => _isEchangeClaiming;

  set isEchangeClaiming(bool value) {
    _isEchangeClaiming = value;
    notifyListeners();
  }

  void clearSearchData() {
    _filteredTransactionData.clear();
    notifyListeners();
  }

  String _selectedDate = '';
  String get selectedDate => _selectedDate;
  set selectedDate(String date) {
    _selectedDate = date;
    notifyListeners();
  }

  String _selectedMonth = '';
  String get selectedMonth => _selectedMonth;
  set selectedMonth(String date) {
    _selectedMonth = date;
    notifyListeners();
  }

  void resetFilters() {
    _selectedDate = '';
    _selectedMonth = '';
    _filteredTransactionData.clear();
    notifyListeners();
  }

  Future<void> fetchNotifications(BuildContext context) async {
    isNotificationsLoading = true;
    try {
      final response = await _repository.fetchNotifications();
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

  Future<void> fetchTransactionHistory(
    BuildContext context, {
    int pageNumber = 1,
  }) async {
    debugPrint("Transaction Current page Number:$pageNumber");
    pageNumber == 1
        ? isTransactionHistoryLoading = true
        : isMoreTransactionHistoryLoading = true;
    try {
      debugPrint("Transaction page Numbers:$pageNumber ,$totalTransactionPage");
      if (pageNumber > totalTransactionPage) return;
      if (pageNumber == 1) {
        _transactionHistotyData.clear();
        totalTransactionPage = 1;
      }
      debugPrint(
        "Transaction History Data Length:${transactionHistoryData.length}",
      );
      final response = await _repository.fetchTransactionHistory(pageNumber);

      if (response.success) {
        _transactionHistotyData.addAll(response.data);
        debugPrint(
          "Transaction History Data Length:${transactionHistoryData.length}",
        );
        currentTransactionPage = pageNumber;
        totalTransactionPage = response.meta?.totalPages ?? 1;
        debugPrint(
          " page Numbers:$currentTransactionPage ,$totalTransactionPage",
        );

        notifyListeners();
        debugPrint("Fetched Transaction History SuccessFully");
      } else {
        ToastHelper.show(
          context,
          "Failed to Fetch Transaction History",
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
          duration: const Duration(seconds: 3),
        );
      }
      debugPrint(e.toString());
    } finally {
      isTransactionHistoryLoading = false;
      isMoreTransactionHistoryLoading = false;
    }
  }

  Future<void> filterTransactions(
    BuildContext context,
    String name,
    String date,
    String month, {
    int pageNumber = 1,
  }) async {
    selectedDate = date;
    selectedMonth = month;
    debugPrint("Filter Current page Number:$pageNumber");
    pageNumber == 1
        ? isFilteringTransactions = true
        : isMoreFilteringTransactions = true;
    try {
      final url;
      if (name.isNotEmpty) {
        url =
            "${AppUrls.transactionHistoryUrl}?name=$name&page=$pageNumber&limit=10";
      } else if (month.isNotEmpty) {
        url =
            "${AppUrls.transactionHistoryUrl}?month=$month&page=$pageNumber&limit=10";
      } else {
        url =
            "${AppUrls.transactionHistoryUrl}?date=$date&page=$pageNumber&limit=10";
      }

      debugPrint("Filter Data :$date , Month :$month, name:$name");

      debugPrint("Filter page Numbers:$pageNumber ,$totalFilterPage");
      if (pageNumber == 1) {
        _filteredTransactionData.clear();
        totalFilterPage = 1;
      }
      if (pageNumber > totalFilterPage) return;

      debugPrint(
        "Filter History Data Length:${filteredTransactionData.length}",
      );
      final response = await _repository.filterTransactionHistory(url);

      if (response.success) {
        _filteredTransactionData.addAll(response.data);
        debugPrint(
          "Filter History Data Length:${filteredTransactionData.length}",
        );
        currentFilterPage = pageNumber;
        totalFilterPage = response.meta?.totalPages ?? 1;
        debugPrint("Filter page Numbers:$currentFilterPage ,$totalFilterPage");

        notifyListeners();
        debugPrint("Fetched Filter History SuccessFully");
      } else {
        ToastHelper.show(
          context,
          "Failed to Fetch Filter History",
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
          duration: const Duration(seconds: 3),
        );
      }
      debugPrint(e.toString());
    } finally {
      isFilteringTransactions = false;
      isMoreFilteringTransactions = false;
    }
  }

  Future<void> claimEChange(BuildContext context, dynamic body) async {
    isEchangeClaiming = true;
    try {
      debugPrint("Entered into VM of Echange");
      final response = await _repository.claimEChange(body);
      if (response.success) {
        ToastHelper.show(
          context,
          response.message,
          type: ToastificationType.success,
          duration: Duration(seconds: 3),
        );
        Navigator.pop(context);
      } else {
        ToastHelper.show(
          context,
          response.message,
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
          duration: const Duration(seconds: 3),
        );
      }
      debugPrint(e.toString());
    } finally {
      isEchangeClaiming = false;
    }
  }
}
