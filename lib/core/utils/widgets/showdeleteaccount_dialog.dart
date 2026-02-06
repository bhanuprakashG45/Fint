import 'package:fint/core/constants/exports.dart';

void showDeleteAccountDialog(BuildContext context) {
  final colorscheme = Theme.of(context).colorScheme;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Consumer<ProfileViewmodel>(
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
                Image.asset(
                  'assets/images/deleteaccount.png',
                  height: 100.h,
                  width: 100.w,
                  color: colorscheme.tertiary,
                ),
                SizedBox(height: 12.h),
                Text(
                  "Are you sure you want to delete your account?",
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
                      onPressed: provider.isAccountDeleting
                          ? null
                          : () async {
                              await provider.deleteAccount(context);
                            },
                      child: provider.isAccountDeleting
                          ? SizedBox(
                              height: 16.h,
                              width: 16.w,
                              child: CircularProgressIndicator(
                                color: colorscheme.primaryContainer,
                                strokeWidth: 2.w,
                              ),
                            )
                          : Text(
                              "Delete",
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
