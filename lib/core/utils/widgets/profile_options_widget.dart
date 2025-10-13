import 'package:fint/core/constants/exports.dart';

class ProfileOptionsWidget extends StatelessWidget {
  final IconData leadingIcon;
  final String text;
  final IconData? trailingIcon;
  final Widget? trailingWidget;
  final VoidCallback? onTap;
  final Color? iconColor;
  final TextStyle? textStyle;

  const ProfileOptionsWidget({
    Key? key,
    required this.leadingIcon,
    required this.text,
    this.trailingIcon,
    this.trailingWidget,
    this.onTap,
    this.iconColor,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
        child: Row(
          children: [
            Icon(
              leadingIcon,
              color: iconColor ?? theme.iconTheme.color,
              size: 24.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),
            if (trailingWidget != null)
              trailingWidget!
            else if (trailingIcon != null)
              Icon(
                trailingIcon,
                color: iconColor ?? theme.iconTheme.color,
                size: 20.sp,
              ),
          ],
        ),
      ),
    );
  }
}
