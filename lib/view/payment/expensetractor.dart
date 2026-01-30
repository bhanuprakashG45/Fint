import 'dart:math';
import 'package:fint/core/constants/exports.dart';
import 'package:fint/model/expensetracker_model/expensetrackernames_model.dart';

class ExpenseInputData {
  final String expenseId;
  final String amount;
  final String note;

  ExpenseInputData({
    required this.expenseId,
    required this.amount,
    required this.note,
  });
}

class ExpenseBridgeWithInput extends StatefulWidget {
  final List<ExpenseTrackerData> categories;

  final ValueChanged<String> onSelected;

  final ValueChanged<ExpenseInputData> onDataChanged;

  const ExpenseBridgeWithInput({
    super.key,
    required this.categories,
    required this.onSelected,
    required this.onDataChanged,
  });

  @override
  State<ExpenseBridgeWithInput> createState() => _ExpenseBridgeWithInputState();
}

class _ExpenseBridgeWithInputState extends State<ExpenseBridgeWithInput> {
  double _rotationAngle = 0.0;
  int _selectedIndex = 0;

  final int _visibleSegments = 3;
  late double _anglePerSegment;
  
  final TextEditingController _amountController = TextEditingController(
    text: "",
  );
  final TextEditingController _noteController = TextEditingController();
  final FocusNode _noteFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _anglePerSegment = pi / _visibleSegments;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.categories.isNotEmpty) {
        setState(() {
          _selectedIndex = _getCenterIndex();
        });
        _notifyParent();
      }
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    _noteFocusNode.dispose();
    super.dispose();
  }

  int get _centerSegmentIndex => _visibleSegments ~/ 2;

  int _getCenterIndex() {
    int moved = (-_rotationAngle / _anglePerSegment).round();
    int index = moved + _centerSegmentIndex;
    return index.clamp(0, widget.categories.length - 1);
  }

  double _minRotation() {
    int lastIndex = widget.categories.length - 1;
    int movedToLastCenter = lastIndex - _centerSegmentIndex;
    return -movedToLastCenter * _anglePerSegment;
  }

  double _maxRotation() {
    return _centerSegmentIndex * _anglePerSegment;
  }

  void _notifyParent() {
    if (widget.categories.isEmpty) return;

    final selectedId = widget.categories[_selectedIndex].id;

    widget.onSelected(selectedId);

    widget.onDataChanged(
      ExpenseInputData(
        expenseId: selectedId,
        amount: _amountController.text,
        note: _noteController.text,
      ),
    );
  }

  void _handlePanUpdate(DragUpdateDetails details, Size size) {
    if (widget.categories.length <= _visibleSegments) return;

    setState(() {
      double delta = (details.delta.dx / size.width) * pi * 1.5;
      _rotationAngle += delta;
      _rotationAngle = _rotationAngle.clamp(_minRotation(), _maxRotation());

      final newIndex = _getCenterIndex();
      if (newIndex != _selectedIndex) {
        _selectedIndex = newIndex;
        _notifyParent();
      }
    });
  }

  void _snapToNearest() {
    final int targetIndex = _getCenterIndex();

    final double targetRotation =
        -((targetIndex - _centerSegmentIndex) * _anglePerSegment);

    setState(() {
      _rotationAngle = targetRotation;
      _selectedIndex = targetIndex;
      _notifyParent();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;

        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onPanUpdate: (details) => _handlePanUpdate(details, size),
                onPanEnd: (_) => _snapToNearest(),

                child: SizedBox(
                  width: double.infinity,
                  height: 350,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        size: Size.infinite,
                        painter: _ScrollableSemiCirclePainter(
                          categories: widget.categories,
                          rotationAngle: _rotationAngle,
                          selectedIndex: _selectedIndex,
                          visibleSegments: _visibleSegments.toDouble(),
                          anglePerSegment: _anglePerSegment,
                        ),
                      ),
                      Positioned(
                        top: 100,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                "₹",
                                style: GoogleFonts.roboto(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF000033),
                                ),
                              ),
                              const SizedBox(width: 8),
                              IntrinsicWidth(
                                child: TextField(
                                  controller: _amountController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(6),
                                  ],
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF000033),
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "0",
                                    hintStyle: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                    ),
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  onChanged: (value) {
                                    if (value.isEmpty) {
                                      _amountController.text = "";
                                      _amountController.selection =
                                          TextSelection.fromPosition(
                                            TextPosition(
                                              offset:
                                                  _amountController.text.length,
                                            ),
                                          );
                                    }
                                    _notifyParent();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 160,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              _noteFocusNode.requestFocus();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(
                                    0xFF000033,
                                  ).withValues(alpha: 0.2),
                                  width: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              child: TextField(
                                focusNode: _noteFocusNode,
                                controller: _noteController,
                                maxLines: 3,
                                minLines: 1,
                                textInputAction: TextInputAction.done,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF000033),
                                  height: 1.3,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  hintText: _noteController.text.isEmpty
                                      ? "Add a note"
                                      : null,
                                  hintStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: colorscheme.onSecondary,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  counterText: "",
                                ),
                                onChanged: (value) {
                                  if (value.length > 50) {
                                    _noteController.text = value.substring(
                                      0,
                                      50,
                                    );
                                    _noteController.selection =
                                        const TextSelection.collapsed(
                                          offset: 50,
                                        );
                                  }
                                  _notifyParent();
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ScrollableSemiCirclePainter extends CustomPainter {
  final List<ExpenseTrackerData> categories;
  final double rotationAngle;
  final int selectedIndex;
  final double visibleSegments;
  final double anglePerSegment;

  _ScrollableSemiCirclePainter({
    required this.categories,
    required this.rotationAngle,
    required this.selectedIndex,
    required this.visibleSegments,
    required this.anglePerSegment,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (categories.isEmpty) return;

    final center = Offset(size.width / 2, size.height * 0.55);
    final outerRadius = size.width * 0.48;
    final innerRadius = outerRadius - 50;
    final textRadius = innerRadius + (outerRadius - innerRadius) / 2;

    final int centerIndex = (visibleSegments ~/ 2);

    /// ================= BORDER =================
    final borderPaint = Paint()
      ..color = const Color(0xFF000033)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final borderPath = Path()
      ..moveTo(center.dx - outerRadius, center.dy)
      ..arcTo(
        Rect.fromCircle(center: center, radius: outerRadius),
        pi,
        pi,
        false,
      )
      ..lineTo(center.dx + innerRadius, center.dy)
      ..arcTo(
        Rect.fromCircle(center: center, radius: innerRadius),
        0,
        -pi,
        false,
      )
      ..close();

    canvas.drawPath(borderPath, borderPaint);
    canvas.clipPath(borderPath);

    /// ================= FIXED CENTER HIGHLIGHT =================
    final centerStartAngle = pi + (centerIndex * anglePerSegment);

    final highlightPaint = Paint()
      ..color = const Color(0xFF000033)
      ..style = PaintingStyle.fill;

    final highlightPath = Path()
      ..arcTo(
        Rect.fromCircle(center: center, radius: outerRadius),
        centerStartAngle,
        anglePerSegment,
        false,
      )
      ..arcTo(
        Rect.fromCircle(center: center, radius: innerRadius),
        centerStartAngle + anglePerSegment,
        -anglePerSegment,
        false,
      )
      ..close();

    canvas.drawPath(highlightPath, highlightPaint);

    /// ================= ROTATING ITEMS =================
    for (int i = 0; i < categories.length; i++) {
      final startAngle = pi + (i * anglePerSegment) + rotationAngle;

      if (startAngle > 2 * pi + 0.1 ||
          startAngle + anglePerSegment < pi - 0.1) {
        continue;
      }

      final isSelected = i == selectedIndex;

      final midAngle = startAngle + anglePerSegment / 2;
      final tx = center.dx + textRadius * cos(midAngle);
      final ty = center.dy + textRadius * sin(midAngle);

      canvas.save();
      canvas.translate(tx, ty);
      canvas.rotate(midAngle + pi / 2);

      final textPainter = TextPainter(
        text: TextSpan(
          text: categories[i].name,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF000033),
            fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
            fontSize: isSelected ? 16 : 13,
            letterSpacing: isSelected ? 0.4 : 0,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: 80);

      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ScrollableSemiCirclePainter oldDelegate) {
    return oldDelegate.rotationAngle != rotationAngle ||
        oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.categories.length != categories.length;
  }
}

// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:fint/model/expensetracker_model/expensetrackernames_model.dart';
// class Expensetractor extends StatefulWidget {
//   final List<ExpenseTrackerData> categories;
//   final ValueChanged<String> onSelected;
//   const Expensetractor({
//     super.key,
//     required this.categories,
//     required this.onSelected,
//   });
//   @override
//   State<Expensetractor> createState() => _ExpensetractorState();
// }
// class _ExpensetractorState extends State<Expensetractor> {
//   double _rotationAngle = 0.0;
//   int _selectedIndex = 0;
//   final double _visibleSegments = 4.0;
//   late double _anglePerSegment;
//   @override
//   void initState() {
//     super.initState();
//     _anglePerSegment = pi / _visibleSegments;
//   }
//   void _handlePanUpdate(DragUpdateDetails details, Size size) {
//     if (widget.categories.length <= _visibleSegments) return;
//     setState(() {
//       double delta = (details.delta.dx / size.width) * pi * 1.5;
//       _rotationAngle += delta;
//       double minRotation =
//           -(widget.categories.length - _visibleSegments) * _anglePerSegment;
//       double maxRotation = 0.0;
//       _rotationAngle = _rotationAngle.clamp(minRotation, maxRotation);
//     });
//   }
//   void _handleTap(TapUpDetails details, Size size) {
//     final center = Offset(size.width / 2, size.height * 0.9);
//     final position = details.localPosition;
//     final dx = position.dx - center.dx;
//     final dy = position.dy - center.dy;
//     final distance = sqrt(dx * dx + dy * dy);
//     final outerRadius = size.width * 0.45;
//     final innerRadius = outerRadius - 60;
//     if (distance < innerRadius || distance > outerRadius) {
//       debugPrint("Tap outside ring (distance: ${distance.toStringAsFixed(1)})");
//       return;
//     }
//     double atanAngle = atan2(dy, dx);
//     double angle = (atanAngle + pi + 2 * pi) % (2 * pi);
//     double adjustedAngle = angle - _rotationAngle;
//     adjustedAngle = adjustedAngle % (2 * pi);
//     if (adjustedAngle < 0) adjustedAngle += 2 * pi;
//     if (adjustedAngle > pi) {
//       adjustedAngle = 2 * pi - adjustedAngle;
//     }
//     if (adjustedAngle < -0.05 || adjustedAngle > pi + 0.05) {
//       debugPrint(
//         "Adjusted angle outside [0, π]: ${adjustedAngle.toStringAsFixed(3)} → ignored",
//       );
//       return;
//     }
//     debugPrint('''
// Tap pos:      ${position.dx.toStringAsFixed(1)}, ${position.dy.toStringAsFixed(1)}
// dx/dy:        ${dx.toStringAsFixed(1)} / ${dy.toStringAsFixed(1)}
// atan2:        ${atanAngle.toStringAsFixed(3)}
// raw angle:    ${angle.toStringAsFixed(3)}
// adjusted:     ${adjustedAngle.toStringAsFixed(3)}
// segment:      ${_anglePerSegment.toStringAsFixed(4)}
// ''');
//     double biased = adjustedAngle + _anglePerSegment * 0.25;
//     int index = (biased / _anglePerSegment).floor();
//     debugPrint("→ Raw index: $index  (of ${widget.categories.length})");
//     if (index >= 0 && index < widget.categories.length) {
//       setState(() {
//         _selectedIndex = index;
//       });
//       widget.onSelected(widget.categories[index].id);
//       debugPrint(
//         "→ SELECTED: ${widget.categories[index].name} (ID: ${widget.categories[index].id})",
//       );
//     } else {
//       debugPrint("→ Index out of range");
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final size = constraints.biggest;
//         return GestureDetector(
//           behavior: HitTestBehavior.opaque,
//           onPanUpdate: (details) => _handlePanUpdate(details, size),
//           onTapUp: (details) => _handleTap(details, size),
//           child: Container(
//             width: double.infinity,
//             height: 220,
//             child: CustomPaint(
//               painter: _ScrollableSemiCirclePainter(
//                 categories: widget.categories,
//                 rotationAngle: _rotationAngle,
//                 selectedIndex: _selectedIndex,
//                 visibleSegments: _visibleSegments,
//                 anglePerSegment: _anglePerSegment,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// class _ScrollableSemiCirclePainter extends CustomPainter {
//   final List<ExpenseTrackerData> categories;
//   final double rotationAngle;
//   final int selectedIndex;
//   final double visibleSegments;
//   final double anglePerSegment;
//   _ScrollableSemiCirclePainter({
//     required this.categories,
//     required this.rotationAngle,
//     required this.selectedIndex,
//     required this.visibleSegments,
//     required this.anglePerSegment,
//   });
//   @override
//   void paint(Canvas canvas, Size size) {
//     if (categories.isEmpty) return;
//     final center = Offset(size.width / 2, size.height * 0.9);
//     final outerRadius = size.width * 0.45;
//     final innerRadius = outerRadius - 60;
//     final textRadius = innerRadius + (outerRadius - innerRadius) / 2;
//     final borderPaint = Paint()
//       ..color = Color(0xFF000033)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.5;
//     final clipPath = Path()
//       ..moveTo(center.dx - outerRadius, center.dy)
//       ..arcTo(
//         Rect.fromCircle(center: center, radius: outerRadius),
//         pi,
//         pi,
//         false,
//       )
//       ..lineTo(center.dx + innerRadius, center.dy)
//       ..arcTo(
//         Rect.fromCircle(center: center, radius: innerRadius),
//         0,
//         -pi,
//         false,
//       )
//       ..close();
//     canvas.clipPath(clipPath);
//     for (int i = 0; i < categories.length; i++) {
//       final startAngle = pi + (i * anglePerSegment) + rotationAngle;
//       if (startAngle > 2 * pi + 0.1 || startAngle + anglePerSegment < pi - 0.1)
//         continue;
//       final path = Path()
//         ..arcTo(
//           Rect.fromCircle(center: center, radius: outerRadius),
//           startAngle,
//           anglePerSegment,
//           false,
//         )
//         ..arcTo(
//           Rect.fromCircle(center: center, radius: innerRadius),
//           startAngle + anglePerSegment,
//           -anglePerSegment,
//           false,
//         )
//         ..close();
//       final isSelected = i == selectedIndex;
//       final fillPaint = Paint()
//         ..color = isSelected ? Color(0xFF000033) : Colors.white
//         ..style = PaintingStyle.fill;
//       canvas.drawPath(path, fillPaint);
//       canvas.drawPath(path, borderPaint);
//       canvas.save();
//       final midAngle = startAngle + anglePerSegment / 2;
//       final tx = center.dx + textRadius * cos(midAngle);
//       final ty = center.dy + textRadius * sin(midAngle);
//       canvas.translate(tx, ty);
//       canvas.rotate(midAngle + pi / 2);
//       final textPainter = TextPainter(
//         text: TextSpan(
//           text: categories[i].name,
//           style: TextStyle(
//             color: isSelected ? Colors.white : Color(0xFF000033),
//             fontWeight: isSelected ? FontWeight.bold : FontWeight.bold,
//             fontSize: 13,
//           ),
//         ),
//         textDirection: TextDirection.ltr,
//         textAlign: TextAlign.center,
//       )..layout(maxWidth: 60);
//       textPainter.paint(
//         canvas,
//         Offset(-textPainter.width / 2, -textPainter.height / 2),
//       );
//       canvas.restore();
//     }
//   }
//   @override
//   bool shouldRepaint(covariant _ScrollableSemiCirclePainter oldDelegate) =>
//       oldDelegate.rotationAngle != rotationAngle ||
//       oldDelegate.selectedIndex != selectedIndex ||
//       oldDelegate.categories.length != categories.length;
// }

// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:fint/model/expensetracker_model/expensetrackernames_model.dart';
// class Expensetractor extends StatefulWidget {
//   final List<ExpenseTrackerData> categories;
//   final ValueChanged<String> onSelected;
//   const Expensetractor({
//     super.key,
//     required this.categories,
//     required this.onSelected,
//   });
//   @override
//   State<Expensetractor> createState() => _ExpensetractorState();
// }
// class _ExpensetractorState extends State<Expensetractor> {
//   double _rotationAngle = 0.0;
//   int _selectedIndex = 0;
//   //  Only 3 segments visible initially
//   final double _visibleSegments = 3.0;
//   late double _anglePerSegment;
//   @override
//   void initState() {
//     super.initState();
//     _anglePerSegment = pi / _visibleSegments;
//     //  initially middle one selected
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (widget.categories.isNotEmpty) {
//         setState(() {
//           _selectedIndex = _getCenterIndex();
//         });
//         widget.onSelected(widget.categories[_selectedIndex].id);
//       }
//     });
//   }
//   ///  Get the index which is currently in the center segment
//   int _getCenterIndex() {
//     final int centerSegmentIndex = (_visibleSegments ~/ 2); // for 3 => 1
//     int moved = (-_rotationAngle / _anglePerSegment).round();
//     int index = moved + centerSegmentIndex;
//     return index.clamp(0, widget.categories.length - 1);
//   }
//   void _handlePanUpdate(DragUpdateDetails details, Size size) {
//     if (widget.categories.length <= _visibleSegments) return;
//     setState(() {
//       double delta = (details.delta.dx / size.width) * pi * 1.5;
//       _rotationAngle += delta;
//       double minRotation =
//           -(widget.categories.length - _visibleSegments) * _anglePerSegment;
//       double maxRotation = 0.0;
//       _rotationAngle = _rotationAngle.clamp(minRotation, maxRotation);
//       //  AUTO SELECT CENTER ITEM WHILE SCROLLING
//       final newIndex = _getCenterIndex();
//       if (newIndex != _selectedIndex) {
//         _selectedIndex = newIndex;
//         widget.onSelected(widget.categories[_selectedIndex].id);
//       }
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final size = constraints.biggest;
//         return GestureDetector(
//           behavior: HitTestBehavior.opaque,
//           onPanUpdate: (details) => _handlePanUpdate(details, size),
//           // Tap selection removed because selection is based on center scroll
//           // onTapUp: (details) => _handleTap(details, size),
//           child: SizedBox(
//             width: double.infinity,
//             height: 220,
//             child: CustomPaint(
//               painter: _ScrollableSemiCirclePainter(
//                 categories: widget.categories,
//                 rotationAngle: _rotationAngle,
//                 selectedIndex: _selectedIndex,
//                 visibleSegments: _visibleSegments,
//                 anglePerSegment: _anglePerSegment,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// class _ScrollableSemiCirclePainter extends CustomPainter {
//   final List<ExpenseTrackerData> categories;
//   final double rotationAngle;
//   final int selectedIndex;
//   final double visibleSegments;
//   final double anglePerSegment;
//   _ScrollableSemiCirclePainter({
//     required this.categories,
//     required this.rotationAngle,
//     required this.selectedIndex,
//     required this.visibleSegments,
//     required this.anglePerSegment,
//   });
//   @override
//   void paint(Canvas canvas, Size size) {
//     if (categories.isEmpty) return;
//     final center = Offset(size.width / 2, size.height * 0.9);
//     final outerRadius = size.width * 0.45;
//     final innerRadius = outerRadius - 60;
//     final textRadius = innerRadius + (outerRadius - innerRadius) / 2;
//     final borderPaint = Paint()
//       ..color = const Color(0xFF000033)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.5;
//     final clipPath = Path()
//       ..moveTo(center.dx - outerRadius, center.dy)
//       ..arcTo(
//         Rect.fromCircle(center: center, radius: outerRadius),
//         pi,
//         pi,
//         false,
//       )
//       ..lineTo(center.dx + innerRadius, center.dy)
//       ..arcTo(
//         Rect.fromCircle(center: center, radius: innerRadius),
//         0,
//         -pi,
//         false,
//       )
//       ..close();
//     canvas.clipPath(clipPath);
//     for (int i = 0; i < categories.length; i++) {
//       final startAngle = pi + (i * anglePerSegment) + rotationAngle;
//       // Only draw segments which are visible in semicircle area
//       if (startAngle > 2 * pi + 0.1 ||
//           startAngle + anglePerSegment < pi - 0.1) {
//         continue;
//       }
//       final path = Path()
//         ..arcTo(
//           Rect.fromCircle(center: center, radius: outerRadius),
//           startAngle,
//           anglePerSegment,
//           false,
//         )
//         ..arcTo(
//           Rect.fromCircle(center: center, radius: innerRadius),
//           startAngle + anglePerSegment,
//           -anglePerSegment,
//           false,
//         )
//         ..close();
//       final isSelected = i == selectedIndex;
//       final fillPaint = Paint()
//         ..color = isSelected ? const Color(0xFF000033) : Colors.white
//         ..style = PaintingStyle.fill;
//       canvas.drawPath(path, fillPaint);
//       canvas.drawPath(path, borderPaint);
//       //  Draw text in the middle of segment
//       canvas.save();
//       final midAngle = startAngle + anglePerSegment / 2;
//       final tx = center.dx + textRadius * cos(midAngle);
//       final ty = center.dy + textRadius * sin(midAngle);
//       canvas.translate(tx, ty);
//       canvas.rotate(midAngle + pi / 2);
//       final textPainter = TextPainter(
//         text: TextSpan(
//           text: categories[i].name,
//           style: TextStyle(
//             color: isSelected ? Colors.white : const Color(0xFF000033),
//             fontWeight: FontWeight.bold,
//             fontSize: 13,
//           ),
//         ),
//         textDirection: TextDirection.ltr,
//         textAlign: TextAlign.center,
//       )..layout(maxWidth: 60);
//       textPainter.paint(
//         canvas,
//         Offset(-textPainter.width / 2, -textPainter.height / 2),
//       );
//       canvas.restore();
//     }
//   }
//   @override
//   bool shouldRepaint(covariant _ScrollableSemiCirclePainter oldDelegate) =>
//       oldDelegate.rotationAngle != rotationAngle ||
//       oldDelegate.selectedIndex != selectedIndex ||
//       oldDelegate.categories.length != categories.length;
// }

// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:fint/model/expensetracker_model/expensetrackernames_model.dart';
// class Expensetractor extends StatefulWidget {
//   final List<ExpenseTrackerData> categories;
//   final ValueChanged<String> onSelected;
//   const Expensetractor({
//     super.key,
//     required this.categories,
//     required this.onSelected,
//   });
//   @override
//   State<Expensetractor> createState() => _ExpensetractorState();
// }
// class _ExpensetractorState extends State<Expensetractor> {
//   double _rotationAngle = 0.0;
//   int _selectedIndex = 0;
//   final double _visibleSegments = 4.0;
//   late double _anglePerSegment;
//   @override
//   void initState() {
//     super.initState();
//     _anglePerSegment = pi / _visibleSegments;
//   }
//   void _handlePanUpdate(DragUpdateDetails details, Size size) {
//     if (widget.categories.length <= _visibleSegments) return;
//     setState(() {
//       double delta = (details.delta.dx / size.width) * pi * 1.5;
//       _rotationAngle += delta;
//       double minRotation =
//           -(widget.categories.length - _visibleSegments) * _anglePerSegment;
//       double maxRotation = 0.0;
//       _rotationAngle = _rotationAngle.clamp(minRotation, maxRotation);
//     });
//   }
//   void _handleTap(TapUpDetails details, Size size) {
//     final center = Offset(size.width / 2, size.height * 0.9);
//     final position = details.localPosition;
//     final dx = position.dx - center.dx;
//     final dy = position.dy - center.dy;
//     final distance = sqrt(dx * dx + dy * dy);
//     final outerRadius = size.width * 0.45;
//     final innerRadius = outerRadius - 60;
//     if (distance < innerRadius || distance > outerRadius) {
//       return;
//     }
//     double atanAngle = atan2(dy, dx);
//     // Convert to 0..2π (0 = right, increasing counterclockwise)
//     double normalized = atanAngle < 0 ? atanAngle + 2 * pi : atanAngle;
//     // Correct: LEFT side = low angle (index 0), RIGHT side = high angle
//     // Matches painter: starts at π (left), increases clockwise
//     double angleFromLeft = (normalized + pi) % (2 * pi);  // ← this is the key fix
//     // Apply rotation compensation
//     double adjustedAngle = angleFromLeft - _rotationAngle;
//     adjustedAngle = adjustedAngle % (2 * pi);
//     if (adjustedAngle < 0) adjustedAngle += 2 * pi;
//     debugPrint('''
// Tap pos: ${position.dx.toStringAsFixed(1)}, ${position.dy.toStringAsFixed(1)}
// atan2:   ${atanAngle.toStringAsFixed(3)}
// norm:    ${normalized.toStringAsFixed(3)}
// fromLeft:${angleFromLeft.toStringAsFixed(3)}
// adjusted:${adjustedAngle.toStringAsFixed(3)}
// ''');
//     // Bias — helps reach later items when scrolled
//     double biased = adjustedAngle + _anglePerSegment * 0.55;
//     int index = (biased / _anglePerSegment).floor();
//     index = index.clamp(0, widget.categories.length - 1);
//     debugPrint("biased: ${biased.toStringAsFixed(3)} → index $index / ${widget.categories.length - 1}");
//     if (index >= 0 && index < widget.categories.length) {
//       setState(() {
//         _selectedIndex = index;
//       });
//       widget.onSelected(widget.categories[index].id);
//       debugPrint("→ SELECTED: ${widget.categories[index].name} (ID: ${widget.categories[index].id})");
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final size = constraints.biggest;
//         return GestureDetector(
//           behavior: HitTestBehavior.opaque,
//           onPanUpdate: (details) => _handlePanUpdate(details, size),
//           onTapUp: (details) => _handleTap(details, size),
//           child: Container(
//             width: double.infinity,
//             height: 220,
//             child: CustomPaint(
//               painter: _ScrollableSemiCirclePainter(
//                 categories: widget.categories,
//                 rotationAngle: _rotationAngle,
//                 selectedIndex: _selectedIndex,
//                 visibleSegments: _visibleSegments,
//                 anglePerSegment: _anglePerSegment,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// class _ScrollableSemiCirclePainter extends CustomPainter {
//   final List<ExpenseTrackerData> categories;
//   final double rotationAngle;
//   final int selectedIndex;
//   final double visibleSegments;
//   final double anglePerSegment;
//   _ScrollableSemiCirclePainter({
//     required this.categories,
//     required this.rotationAngle,
//     required this.selectedIndex,
//     required this.visibleSegments,
//     required this.anglePerSegment,
//   });
//   @override
//   void paint(Canvas canvas, Size size) {
//     if (categories.isEmpty) return;
//     final center = Offset(size.width / 2, size.height * 0.9);
//     final outerRadius = size.width * 0.45;
//     final innerRadius = outerRadius - 60;
//     final textRadius = innerRadius + (outerRadius - innerRadius) / 2;
//     final borderPaint = Paint()
//       ..color = Color(0xFF000033)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.5;
//     final clipPath = Path()
//       ..moveTo(center.dx - outerRadius, center.dy)
//       ..arcTo(
//         Rect.fromCircle(center: center, radius: outerRadius),
//         pi,
//         pi,
//         false,
//       )
//       ..lineTo(center.dx + innerRadius, center.dy)
//       ..arcTo(
//         Rect.fromCircle(center: center, radius: innerRadius),
//         0,
//         -pi,
//         false,
//       )
//       ..close();
//     canvas.clipPath(clipPath);
//     for (int i = 0; i < categories.length; i++) {
//       final startAngle = pi + (i * anglePerSegment) + rotationAngle;
//       if (startAngle > 2 * pi + 0.1 ||
//           startAngle + anglePerSegment < pi - 0.1) {
//         continue;
//       }
//       final path = Path()
//         ..arcTo(
//           Rect.fromCircle(center: center, radius: outerRadius),
//           startAngle,
//           anglePerSegment,
//           false,
//         )
//         ..arcTo(
//           Rect.fromCircle(center: center, radius: innerRadius),
//           startAngle + anglePerSegment,
//           -anglePerSegment,
//           false,
//         )
//         ..close();
//       final isSelected = i == selectedIndex;
//       final fillPaint = Paint()
//         ..color = isSelected ? Color(0xFF000033) : Colors.white
//         ..style = PaintingStyle.fill;
//       canvas.drawPath(path, fillPaint);
//       canvas.drawPath(path, borderPaint);
//       canvas.save();
//       final midAngle = startAngle + anglePerSegment / 2;
//       final tx = center.dx + textRadius * cos(midAngle);
//       final ty = center.dy + textRadius * sin(midAngle);
//       canvas.translate(tx, ty);
//       canvas.rotate(midAngle + pi / 2);
//       final textPainter = TextPainter(
//         text: TextSpan(
//           text: categories[i].name,
//           style: TextStyle(
//             color: isSelected ? Colors.white : Color(0xFF000033),
//             fontWeight: FontWeight.bold,
//             fontSize: 13,
//           ),
//         ),
//         textDirection: TextDirection.ltr,
//         textAlign: TextAlign.center,
//       )..layout(maxWidth: 60);
//       textPainter.paint(
//         canvas,
//         Offset(-textPainter.width / 2, -textPainter.height / 2),
//       );
//       canvas.restore();
//     }
//   }
//   @override
//   bool shouldRepaint(covariant _ScrollableSemiCirclePainter oldDelegate) =>
//       oldDelegate.rotationAngle != rotationAngle ||
//       oldDelegate.selectedIndex != selectedIndex ||
//       oldDelegate.categories.length != categories.length;
// }
