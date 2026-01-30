import 'package:fint/core/constants/exports.dart';

class CouponClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double cutRadius = 14;

    final Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height / 2 - cutRadius);
    path.arcToPoint(
      Offset(size.width, size.height / 2 + cutRadius),
      radius: const Radius.circular(cutRadius),
      clockwise: false,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height / 2 + cutRadius);
    path.arcToPoint(
      Offset(0, size.height / 2 - cutRadius),
      radius: const Radius.circular(cutRadius),
      clockwise: false,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
