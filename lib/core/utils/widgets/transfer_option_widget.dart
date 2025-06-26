

import 'package:fint/core/constants/exports.dart';

class TransferOptionWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const TransferOptionWidget({
    Key? key,
    required this.icon,
    required this.label,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;
    double boxSize = MediaQuery.of(context).size.height * 0.1;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8).r,
        width: boxSize,
        decoration: BoxDecoration(
          // color: colorScheme.primaryContainer,
          // borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(icon, size: 20.sp),
            SizedBox(height: 8.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}
