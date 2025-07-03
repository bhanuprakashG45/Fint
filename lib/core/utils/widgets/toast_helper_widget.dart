import 'package:fint/core/constants/exports.dart';
class ToastHelper {
  static void show(
    BuildContext context,
    String message, {
    required ToastificationType? type,
    Duration? duration,
  }) {
    toastification.show(
      context: context,
      title: Text(
        message,
        style: TextStyle(fontSize: 18.0.sp, fontWeight: FontWeight.bold),
      ),
      type: type,
      autoCloseDuration: duration,
      alignment: Alignment.topRight,
      icon: Icon(_getIconForType(type!), color: Colors.white, size: 20.0.sp),
      style: ToastificationStyle.fillColored,
      showProgressBar: true,
    );
  }

  static IconData _getIconForType(ToastificationType type) {
    switch (type) {
      case ToastificationType.error:
        return Icons.error;
      case ToastificationType.info:
        return Icons.info;
      case ToastificationType.warning:
        return Icons.warning;
      case ToastificationType.success:
      default:
        return Icons.check_circle;
    }
  }
}
