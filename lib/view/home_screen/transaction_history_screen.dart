import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final List<Transaction> _allTransactions = [
    Transaction(id: '1', type: 'Received', amount: '₹500', date: '2025-06-17'),
    Transaction(id: '2', type: 'Sent', amount: '₹200', date: '2025-06-16'),
    Transaction(id: '3', type: 'Failed', amount: '₹100', date: '2025-06-15'),
    Transaction(id: '4', type: 'Received', amount: '₹300', date: '2025-06-14'),
  ];

  List<Transaction> _filteredTransactions = [];
  String _selectedFilter = 'All';
  String _searchQuery = '';

  final List<String> _filters = ['All', 'Received', 'Sent', 'Failed'];

  @override
  void initState() {
    super.initState();
    _filteredTransactions = _allTransactions;
  }

  void _filterTransactions() {
    setState(() {
      _filteredTransactions =
          _allTransactions.where((transaction) {
            final matchesType =
                _selectedFilter == 'All' ||
                transaction.type.toLowerCase() == _selectedFilter.toLowerCase();
            final matchesSearch = transaction.id.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            );
            return matchesType && matchesSearch;
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TRANSACTION HISTORY",
          style: TextStyle(
            color: colorscheme.primary,
            fontSize: 20.0.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorscheme.secondaryContainer,
      ),
      backgroundColor: colorscheme.secondaryContainer,
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
                _filterTransactions();
              },
              decoration: InputDecoration(
                labelText: 'Search by ID',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2.0,
                  ),
                ),
              ),
            ),

            SizedBox(height: 16.h),

            SizedBox(
              height: 40.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                separatorBuilder: (_, __) => SizedBox(width: 40.w),
                itemBuilder: (context, index) {
                  final filter = _filters[index];
                  final isSelected = _selectedFilter == filter;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFilter = filter;
                      });
                      _filterTransactions();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          filter,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight:
                                isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            color:
                                isSelected
                                    ? colorscheme.primary
                                    : Colors.grey.shade700,
                            decoration:
                                isSelected
                                    ? TextDecoration.underline
                                    : TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 16.h),
            Expanded(
              child:
                  _filteredTransactions.isEmpty
                      ? Center(child: Text('No transactions found.'))
                      : ListView.builder(
                        itemCount: _filteredTransactions.length,
                        itemBuilder: (context, index) {
                          final tx = _filteredTransactions[index];
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8.h),
                            child: ListTile(
                              title: Text(tx.type),
                              subtitle: Text('ID: ${tx.id} • ${tx.date}'),
                              trailing: Text(
                                tx.amount,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      tx.type == 'Sent'
                                          ? Colors.red
                                          : tx.type == 'Received'
                                          ? Colors.green
                                          : Colors.orange,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}

class Transaction {
  final String id;
  final String type;
  final String amount;
  final String date;

  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
  });
}
