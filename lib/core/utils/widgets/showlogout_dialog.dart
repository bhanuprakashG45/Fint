import 'package:fint/core/constants/exports.dart';

void showLogoutPopup(BuildContext context) {
  final colorscheme = Theme.of(context).colorScheme;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Consumer<LogoutViewmodel>(
        builder: (context, provider, _) {
          return AlertDialog(
            backgroundColor: colorscheme.primaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12).r,
            ),
            contentPadding: EdgeInsets.all(20).r,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.logout, size: 100.sp, color: colorscheme.tertiary),
                SizedBox(height: 12.h),
                Text(
                  "Are you sure you want to Logout?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorscheme.primaryContainer,
                        foregroundColor: colorscheme.tertiary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8).r,
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorscheme.tertiary,
                        foregroundColor: colorscheme.primaryContainer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: provider.isLogoutLoading
                          ? null
                          : () async {
                              await provider.userLogout(context);
                            },
                      child: provider.isLogoutLoading
                          ? SizedBox(
                              height: 16.h,
                              width: 16.w,
                              child: CircularProgressIndicator(
                                color: colorscheme.onPrimaryContainer,
                                strokeWidth: 2.w,
                              ),
                            )
                          : Text(
                              "Log out",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
