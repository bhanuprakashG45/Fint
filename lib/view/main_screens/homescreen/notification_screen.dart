import 'package:fint/core/constants/exports.dart';
import 'package:fint/view_model/home_viewmodel/home_viewmodel.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<HomeViewmodel>(context, listen: false);
      await provider.fetchNotifications(context);

      if (provider.isNotificationsLoading) return;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NOTIFICATIONS",
          style: TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorscheme.tertiary,
        foregroundColor: colorscheme.onPrimary,
        surfaceTintColor: colorscheme.tertiary,
      ),
      backgroundColor: colorscheme.secondaryContainer,
      body: SafeArea(
        top: false,
        child: Consumer<HomeViewmodel>(
          builder: (context, provider, child) {
            if (provider.notificationData.isEmpty) {
              return Center(
                child: Text(
                  "No Notifications",
                  style: TextStyle(
                    color: colorscheme.onSecondary,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            return Skeletonizer(
              enabled: provider.isNotificationsLoading,
              child: ListView.separated(
                padding: EdgeInsets.all(12.w),
                itemCount: provider.notificationData.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final notification = provider.notificationData[index];
                  return Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: colorscheme.surface,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.asset(
                            'assets/images/applogo.png',
                            height: 60.h,
                            width: 60.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification.title,
                                style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: colorscheme.onSurface,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                notification.body,
                                style: GoogleFonts.poppins(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: colorscheme.secondary,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                DateFormat(
                                  'dd MMM yyyy • hh:mm a',
                                ).format(notification.createdAt),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: colorscheme.onSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
