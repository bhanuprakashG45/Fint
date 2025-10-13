import 'package:fint/core/constants/exports.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Transaction> _allTransactions = [
    Transaction(
      money: '200',
      type: 'Received',
      amount: '₹200',
      date: '2025-06-17',
    ),
    Transaction(money: '200', type: 'Sent', amount: '₹200', date: '2025-06-16'),
    Transaction(
      money: '100',
      type: 'Failed',
      amount: '₹100',
      date: '2025-06-15',
    ),
    Transaction(
      money: '500',
      type: 'process',
      amount: '₹500',
      date: '2025-08-10',
    ),
    Transaction(
      money: '400',
      type: 'Received',
      amount: '₹400',
      date: '2025-06-14',
    ),
  ];

  int _selectedIndex = 0;

  final List<String> _filters = ['All', 'Received', 'Sent', 'Failed'];
  String _searchQuery = '';

  @override
  void initState() {
    _tabController = TabController(length: _filters.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Transaction> _getFilteredTransactions(String type) {
    return _allTransactions.where((transaction) {
      final matchesType =
          type == 'All' || transaction.type.toLowerCase() == type.toLowerCase();
      final matchesSearch = transaction.money.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      return matchesType && matchesSearch;
    }).toList();
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
        child: Padding(
          padding: EdgeInsets.all(16.0.r),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12.h,
                          horizontal: 12.w,
                        ),
                        hintText: "Search by Amount",
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
                      onPressed: () {},
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

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
                  builder: (context) {
                    final selectedFilter = _filters[_selectedIndex];
                    final filteredTxs = _getFilteredTransactions(
                      selectedFilter,
                    );

                    if (filteredTxs.isEmpty) {
                      return Center(child: Text('No transactions found.'));
                    }

                    return ListView.builder(
                      itemCount: filteredTxs.length,
                      itemBuilder: (context, index) {
                        final tx = filteredTxs[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8.h),
                          child: ListTile(
                            leading: _buildLeadingIcon(context, tx.type),
                            title: Text(
                              tx.type,
                              style: TextStyle(
                                color: colorscheme.tertiary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Amount:${tx.money} | ${tx.date}',
                              style: TextStyle(
                                color: colorscheme.onSecondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Text(
                              tx.amount,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: tx.type == 'Sent'
                                    ? AppColor.appcolor
                                    : tx.type == 'Received'
                                    ? AppColor.neonGreen
                                    : tx.type == 'Failed'
                                    ? AppColor.danger
                                    : AppColor.warning,
                              ),
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
        ),
      ),
    );
  }
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
    case 'process':
      image = "assets/icons/processmoney.png";
      color = Colors.orange.shade300;
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

class Transaction {
  final String money;
  final String type;
  final String amount;
  final String date;

  Transaction({
    required this.money,
    required this.type,
    required this.amount,
    required this.date,
  });
}
