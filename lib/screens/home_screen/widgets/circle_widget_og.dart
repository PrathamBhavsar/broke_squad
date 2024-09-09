// import 'dart:math';
//
// import 'package:contri_buter/constants/UI.dart';
// import 'package:flutter/material.dart';
//
// class CirclesWidget extends StatelessWidget {
//   final Map<String, double> titleTotals;
//
//   // Controls the overall width of the widget
//   final double containerWidth;
//
//   // Controls the overall height of the widget
//   final double containerHeight;
//
//   // Controls how far the circles are from the center (0.0 to 1.0)
//   final double radiusRatio;
//
//   // Sets the minimum size for any circle
//   final double minCircleSize;
//
//   // Sets the maximum size for any circle
//   final double maxCircleSize;
//
//   // Defines the color palette for the circles
//   final List<Color> colorPalette;
//
//   // Controls the starting angle for circle placement (in radians)
//   final double startAngle;
//
//   // Controls the direction of circle placement (clockwise or counterclockwise)
//   final bool clockwise;
//
//   const CirclesWidget({
//     Key? key,
//     required this.titleTotals,
//     this.containerWidth = 250.0,
//     this.containerHeight = 210.0,
//     this.radiusRatio = 0.2,
//     this.minCircleSize = 60.0,
//     this.maxCircleSize = 110.0,
//     this.startAngle = 0.0,
//     this.clockwise = true,
//     this.colorPalette = const [
//       Color(0xFFD6CCFB), // Light purple
//       Color(0xFFFFD9A7), // Light orange
//       Color(0xFFBEF0CA), // Light green
//       Color(0xFFB7E8FF), // Light blue
//       Color(0xFFFFC4C4), // Light pink
//       Color(0xFFFFF59D), // Light yellow
//       Color(0xFFE6E6FA), // Lavender
//       Color(0xFFFAFAD2), // Light goldenrod yellow
//       Color(0xFFF0FFF0), // Honeydew
//       Color(0xFFE0FFFF), // Light cyan
//       Color(0xFFFFE4E1), // Misty rose
//       Color(0xFFF0F8FF), // Alice blue
//     ],
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // Determine maximum total to scale circle sizes
//     double maxAmount = titleTotals.isNotEmpty
//         ? titleTotals.values.reduce((a, b) => a > b ? a : b)
//         : 0;
//
//     // Set parameters for positioning
//     final double radius = min(containerWidth, containerHeight) * radiusRatio;
//     final double centerX = containerWidth / 2;
//     final double centerY = containerHeight / 2;
//
//     // Calculate positions and colors
//     final numTitles = titleTotals.length;
//     final angleStep = 2 * pi / numTitles;
//     double angle = startAngle;
//
//     List<Positioned> circles = [];
//     for (var entry in titleTotals.entries) {
//       double size =
//           (entry.value / maxAmount) * (maxCircleSize - minCircleSize) +
//               minCircleSize;
//       Color color = colorPalette[entry.key.hashCode % colorPalette.length];
//
//       // Calculate circle position
//       double x = centerX + (radius * cos(angle)) - size / 2;
//       double y = centerY + (radius * sin(angle)) - size / 2;
//
//       // Ensure circles stay within container bounds
//       x = x.clamp(0, containerWidth - size);
//       y = y.clamp(0, containerHeight - size);
//
//       // Add circle to the list
//       circles.add(Positioned(
//         left: x,
//         top: y,
//         width: size,
//         height: size,
//         child: Container(
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: color.withOpacity(0.9),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 spreadRadius: 1,
//                 blurRadius: 3,
//                 offset: Offset(0, 2),
//               ),
//             ],
//           ),
//           alignment: Alignment.center,
//           child: Text(
//             entry.key,
//             textAlign: TextAlign.center,
//             style: AppTextStyles.kTransactionSubtitleTextStyle,
//           ),
//         ),
//       ));
//
//       // Increment angle based on direction
//       angle += clockwise ? angleStep : -angleStep;
//     }
//
//     return Stack(
//       children: circles.isEmpty
//           ? [
//               Positioned(
//                 left: centerX - minCircleSize / 2,
//                 top: centerY - minCircleSize / 2,
//                 width: minCircleSize,
//                 height: minCircleSize,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: colorPalette[0].withOpacity(0.7),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         spreadRadius: 1,
//                         blurRadius: 3,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   alignment: Alignment.center,
//                   child: Text(
//                     "No Data",
//                     textAlign: TextAlign.center,
//                     style: AppTextStyles.kTransactionSubtitleTextStyle,
//                   ),
//                 ),
//               ),
//             ]
//           : circles,
//     );
//   }
// }
