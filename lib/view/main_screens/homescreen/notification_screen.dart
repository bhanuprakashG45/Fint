import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NOTIFICATIONS ",
          style: TextStyle(
            color: colorscheme.primary,
            fontSize: 20.0.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorscheme.primaryContainer,
      ),
      backgroundColor: colorscheme.secondaryContainer,
      body: Center(child: Text("Notifications Screen")),
    );
  }
}
