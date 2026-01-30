import 'dart:async';

import 'package:fint/core/constants/exports.dart';
import 'package:fint/model/home_model/transactionhistory_model.dart';
import 'package:fint/view/main_screens/homescreen/filter_bottomsheet.dart';
import 'package:fint/view_model/home_viewmodel/home_viewmodel.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final ScrollController _scrollController = ScrollController();

  int _selectedIndex = 0;
  Timer? _debounce;

  final List<String> _filters = ['All', 'Received', 'Sent', 'Failed'];
  String searchQuery = '';

  @override
  void initState() {
    _tabController = TabController(length: _filters.length, vsync: this);
    _scrollController.addListener(_onScroll);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((value) async {
      final homevm = Provider.of<HomeViewmodel>(context, listen: false);
      homevm.clearSearchData();

      await homevm.fetchTransactionHistory(context);

      if (homevm.isTransactionHistoryLoading) return;
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _tabController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final homevm = context.read<HomeViewmodel>();
      // if (query.isEmpty) {
      //   // homevm.fetchTransactionHistory(context);
      //   homevm.clearSearchData();
      // } else {
      homevm.filterTransactions(context, query, '', '');
      // }
    });
  }

  void _onScroll() async {
    if (_scrollController.position.userScrollDirection !=
        ScrollDirection.reverse)
      return;

    final homevm = context.read<HomeViewmodel>();

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (searchQuery.isNotEmpty ||
          homevm.selectedDate.isNotEmpty ||
          homevm.selectedMonth.isNotEmpty) {
        if (!homevm.isFilteringTransactions &&
            !homevm.isMoreFilteringTransactions) {
          await homevm.filterTransactions(
            context,
            searchQuery,
            homevm.selectedDate,
            homevm.selectedMonth,
            pageNumber: homevm.currentFilterPage + 1,
          );
        }
      } else {
        if (!homevm.isTransactionHistoryLoading &&
            !homevm.isMoreTransactionHistoryLoading) {
          await homevm.fetchTransactionHistory(
            context,
            pageNumber: homevm.currentTransactionPage + 1,
          );
        }
      }
    }
  }

  List<TransactionHistoryData> _getFilteredTransactions(
    List<TransactionHistoryData> transactions,
    String filter,
  ) {
    switch (filter) {
      case 'Received':
        return transactions
            .where((e) => e.type.toUpperCase() == 'CREDITED')
            .toList();

      case 'Sent':
        return transactions
            .where((e) => e.type.toUpperCase() == 'DEBITED')
            .toList();

      case 'Failed':
        return transactions
            .where((e) => e.type.toUpperCase() == 'FAILED')
            .toList();

      default:
        return transactions;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TRANSACTION HISTORY",
          style: TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorscheme.tertiary,
        foregroundColor: colorscheme.onPrimary,
      ),
      backgroundColor: colorscheme.secondaryContainer,
      body: SafeArea(
        top: false,
        child: Consumer<HomeViewmodel>(
          builder: (context, homevm, _) {
            if (homevm.isTransactionHistoryLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: colorscheme.tertiary,
                  strokeWidth: 3.w,
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.all(16.0.r),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: TextField(
                          onChanged: (value) async {
                            searchQuery = value;
                            _onSearchChanged(value);
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 12.h,
                              horizontal: 12.w,
                            ),
                            hintText: "Search by Name",
                            hintStyle: TextStyle(
                              color: colorscheme.onSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: colorscheme.tertiary,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(
                                color: colorscheme.onPrimary,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(
                                color: colorscheme.tertiary,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        height: 48.h,
                        width: 48.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            width: 1,
                            color: colorscheme.onPrimary,
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(
                            FontAwesomeIcons.filter,
                            color: colorscheme.onSecondary,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              builder: (_) => const FilterBottomSheet(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(_filters.length, (index) {
                      final isSelected = _selectedIndex == index;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? colorscheme.tertiary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: colorscheme.onPrimary,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                _filters[index],
                                style: TextStyle(
                                  color: isSelected
                                      ? colorscheme.onPrimary
                                      : colorscheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: 16.h),

                  Expanded(
                    child: Builder(
                      builder: (_) {
                        final transactions =
                            homevm.filteredTransactionData.isNotEmpty ||
                                searchQuery.isNotEmpty
                            ? homevm.filteredTransactionData
                            : homevm.transactionHistoryData;

                        final selectedFilter = _filters[_selectedIndex];
                        final filteredTxs = _getFilteredTransactions(
                          transactions,
                          selectedFilter,
                        );

                        if (filteredTxs.isEmpty) {
                          return Center(
                            child: Text(
                              'No transactions found',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                                color: colorscheme.tertiary,
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          controller: _scrollController,
                          itemCount: filteredTxs.length,
                          itemBuilder: (context, index) {
                            final tx = filteredTxs[index];

                            final isCredit =
                                tx.type.toUpperCase() == 'CREDITED';

                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 8.h),
                              child: ListTile(
                                leading: _buildLeadingIcon(
                                  context,
                                  isCredit ? 'received' : 'sent',
                                ),
                                title: Text(
                                  isCredit ? tx.from : tx.to,
                                  style: TextStyle(
                                    color: colorscheme.tertiary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text(
                                    //   isCredit
                                    //       ? 'From  ${tx.from}'
                                    //       : 'To  ${tx.to}',
                                    //   style: TextStyle(
                                    //     color: colorscheme.onSecondary,
                                    //     fontWeight: FontWeight.bold,
                                    //     fontSize: 15.sp,
                                    //   ),
                                    // ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      tx.date != null
                                          ? DateFormat(
                                              'dd MMM yyyy : hh:mm a',
                                            ).format(tx.date!.toLocal())
                                          : '--',
                                      style: TextStyle(
                                        color: colorscheme.primary.withValues(
                                          alpha: 0.8,
                                        ),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),

                                trailing: _buildAmountWidget(
                                  isCredit: isCredit,
                                  amount: tx.amount,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget _buildAmountWidget({required bool isCredit, required int amount}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        isCredit ? "+" : "-",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
          color: isCredit ? Colors.green : Colors.red,
        ),
      ),
      SizedBox(width: 2.w),
      Icon(
        isCredit ? Icons.currency_rupee : Icons.currency_rupee,
        size: 18.sp,
        color: isCredit ? Colors.green : Colors.red,
      ),

      Text(
        amount.toString(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
          color: isCredit ? Colors.green : Colors.red,
        ),
      ),
    ],
  );
}

Widget _buildLeadingIcon(BuildContext context, String type) {
  String image;
  Color color;
  final colorscheme = Theme.of(context).colorScheme;

  switch (type.toLowerCase()) {
    case 'received':
      image = 'assets/icons/recievemoney.png';
      color = Colors.green.shade400;
      break;
    case 'sent':
      image = "assets/icons/sentmoney.png";
      color = AppColor.appcolor;
      break;
    case 'failed':
      image = "assets/icons/failmoney.png";
      color = Colors.red.shade300;
      break;
    default:
      image = '';
      color = Colors.grey;
  }

  return Container(
    padding: EdgeInsets.all(10).r,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10).r,
      color: colorscheme.onSecondaryContainer,
    ),
    child: Image.asset(image, color: color),
  );
}
