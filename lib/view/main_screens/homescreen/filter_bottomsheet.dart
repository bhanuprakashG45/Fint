import 'package:fint/view_model/home_viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  bool isDateSelected = true;

  DateTime? selectedDate;
  DateTime? selectedMonth;

  late final List<DateTime> last12Months;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    last12Months = List.generate(
      12,
      (index) => DateTime(now.year, now.month - index, 1),
    );
    WidgetsBinding.instance.addPostFrameCallback((value) async {
      final homevm = Provider.of<HomeViewmodel>(context, listen: false);

      setState(() {
        selectedDate = homevm.selectedDate.isNotEmpty
            ? DateTime.parse(homevm.selectedDate)
            : null;

        if (homevm.selectedMonth.isNotEmpty) {
          selectedMonth = parseSavedMonth(homevm.selectedMonth);
          isDateSelected = false;
        }
      });
      debugPrint(
        "Selected Date: $selectedDate, Selected Month: $selectedMonth",
      );
    });
  }

  DateTime? parseSavedMonth(String month) {
    try {
      return DateFormat("MMMM-yyyy").parse(month);
    } catch (e) {
      return null;
    }
  }

  Future<void> _pickDate() async {
    final today = DateTime.now();
    final twoYearsAgo = DateTime(today.year - 2, today.month, today.day);

    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? today,
      firstDate: twoYearsAgo,
      lastDate: today,
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        selectedMonth = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(10).r,
            width: double.infinity,
            decoration: BoxDecoration(
              color: cs.tertiary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ).r,
            ),
            child: Text(
              "Filter Transactions",
              style: TextStyle(
                color: cs.onPrimary,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 10.h),
          SizedBox(
            height: 260.h,
            child: Row(
              children: [
                Container(
                  width: 110.w,
                  decoration: BoxDecoration(
                    color: cs.secondaryContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      _LeftTab(
                        title: "Date",
                        selected: isDateSelected,
                        onTap: () {
                          setState(() {
                            isDateSelected = true;
                          });
                        },
                      ),
                      _LeftTab(
                        title: "Month",
                        selected: !isDateSelected,
                        onTap: () {
                          setState(() {
                            isDateSelected = false;
                            selectedDate = null;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 12.w),

                Expanded(
                  child: isDateSelected
                      ? _DateView(date: selectedDate, onTap: _pickDate)
                      : _MonthView(
                          months: last12Months,
                          selectedMonth: selectedMonth,
                          onSelect: (month) {
                            setState(() {
                              selectedMonth = month;
                            });
                          },
                        ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),

          Consumer<HomeViewmodel>(
            builder: (context, homevm, _) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cs.onPrimary,
                          foregroundColor: cs.tertiary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10).r,
                          ),
                        ),
                        onPressed: () {
                          homevm.resetFilters();
                          setState(() {
                            isDateSelected = true;
                            selectedDate = null;
                            selectedMonth = null;
                          });
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Clear All",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cs.tertiary,
                          foregroundColor: cs.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10).r,
                          ),
                        ),
                        onPressed: homevm.isFilteringTransactions
                            ? null
                            : () async {
                                String formattedDate = selectedDate != null
                                    ? DateFormat(
                                        'yyyy-MM-dd',
                                      ).format(selectedDate!)
                                    : '';

                                String formattedMonth = selectedMonth != null
                                    ? DateFormat(
                                        'MMMM-yyyy',
                                      ).format(selectedMonth!)
                                    : '';

                                await homevm.filterTransactions(
                                  context,
                                  '',
                                  formattedDate,
                                  formattedMonth,
                                );
                                Navigator.pop(context);
                              },
                        child: homevm.isFilteringTransactions
                            ? SizedBox(
                                height: 10.h,
                                width: 10.w,
                                child: CircularProgressIndicator(
                                  color: cs.onPrimary,
                                ),
                              )
                            : const Text(
                                "Apply",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LeftTab extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _LeftTab({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: selected ? cs.onPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selected ? cs.primary : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}

class _DateView extends StatelessWidget {
  final DateTime? date;
  final VoidCallback onTap;

  const _DateView({required this.date, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Text(
              "Choose Date From Calender",
              style: TextStyle(
                color: colorscheme.tertiary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              decoration: BoxDecoration(
                color: colorscheme.tertiary,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.calendar_today, color: colorscheme.onPrimary),
                  SizedBox(width: 10.w),
                  Text(
                    date == null
                        ? "Select Date"
                        : DateFormat('dd MMM yyyy').format(date!),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: colorscheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MonthView extends StatelessWidget {
  final List<DateTime> months;
  final DateTime? selectedMonth;
  final ValueChanged<DateTime> onSelect;

  const _MonthView({
    required this.months,
    required this.selectedMonth,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ListView.separated(
      itemCount: months.length,
      separatorBuilder: (_, __) => SizedBox(height: 8.h),
      itemBuilder: (context, index) {
        final month = months[index];
        final isSelected =
            selectedMonth != null &&
            selectedMonth!.year == month.year &&
            selectedMonth!.month == month.month;

        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: cs.tertiary, width: 0.5),
            ),
            tileColor: isSelected ? cs.tertiary : null,
            title: Text(
              DateFormat('MMMM-yyyy').format(month),
              style: TextStyle(
                color: isSelected ? cs.onPrimary : cs.tertiary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.bold,
              ),
            ),
            // trailing: isSelected ? Icon(Icons.check, color: cs.primary) : null,
            onTap: () => onSelect(month),
          ),
        );
      },
    );
  }
}
