import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdDialog extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const AdDialog({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    double height = MediaQuery.of(context).size.height;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10).r),
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: SizedBox(
        height: height * 0.4,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(8).r,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10).r,
                    child: imagePath.isNotEmpty
                        ? Image.network(
                            imagePath,
                            height: height * 0.22,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Center(
                          child: Icon(
                              Icons.image_not_supported,
                              color: cs.tertiary,
                              size: height*0.2,
                            ),
                        ),
                  ),

                  SizedBox(height: 5.h),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: cs.tertiary,
                    ),
                  ),

                  SizedBox(height: 5.h),

                  Expanded(
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: cs.secondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  SizedBox(height: 5.h),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cs.tertiary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10).r,
                      ),
                      minimumSize: Size(double.infinity, 45.h),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Close",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: cs.onPrimary,
                      ),
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
