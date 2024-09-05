import 'package:contri_buter/constants/UI.dart';
import 'package:contri_buter/models/transaction.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class InfoWidget extends StatelessWidget {
  final List<TransactionModel> transactions;
  final String selectedGroup;

  const InfoWidget({
    super.key,
    required this.transactions,
    required this.selectedGroup,
  });

  @override
  Widget build(BuildContext context) {
    // Define a list of fixed colors based on category name hash
    final List<Color> colorPalette = [
      Color(0xFFD6CCFB), // Light purple
      Color(0xFFFFD9A7), // Light orange
      Color(0xFFBEF0CA), // Light green
      Color(0xFFB7E8FF), // Light blue
      Color(0xFFFFC4C4), // Light pink
      Color(0xFFFFF59D), // Light yellow
      Color(0xFFE6E6FA), // Lavender
      Color(0xFFFAFAD2), // Light goldenrod yellow
      Color(0xFFF0FFF0), // Honeydew
      Color(0xFFE0FFFF), // Light cyan
      Color(0xFFFFE4E1), // Misty rose
      Color(0xFFF0F8FF), // Alice blue
    ];

    // Calculate total amount per category
    Map<String, double> categoryTotals = {};
    for (var transaction in transactions) {
      if (selectedGroup == 'All' || transaction.groupName == selectedGroup) {
        categoryTotals.update(
          transaction.category,
          (existingValue) => existingValue + transaction.amount,
          ifAbsent: () => transaction.amount,
        );
      }
    }

    // Determine maximum total to scale circle sizes
    double maxAmount = categoryTotals.isNotEmpty
        ? categoryTotals.values.reduce((a, b) => a > b ? a : b)
        : 0;

    // Set parameters for positioning
    final double containerWidth = 400.0; // Width of the container
    final double containerHeight = 310.0; // Height of the container
    final double radius = min(containerWidth, containerHeight) *
        0.3; // Radius for positioning circles
    final double centerX = containerWidth / 2; // Center X coordinate
    final double centerY = containerHeight / 2; // Center Y coordinate

    // Calculate positions and colors
    final numCategories = categoryTotals.length;
    final angleStep = 2 * pi / numCategories;
    double angle = 0.0;

    List<Positioned> circles = [];
    for (var entry in categoryTotals.entries) {
      double size = (entry.value / maxAmount) * 80 + 40;
      Color color = colorPalette[entry.key.hashCode % colorPalette.length];

      // Calculate circle position
      double x = centerX + (radius * cos(angle)) - size / 2;
      double y = centerY + (radius * sin(angle)) - size / 2;

      // Ensure circles stay within container bounds
      x = x.clamp(0, containerWidth - size);
      y = y.clamp(0, containerHeight - size);

      // Add circle to the list
      circles.add(Positioned(
        left: x,
        top: y,
        width: size,
        height: size,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.7),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            entry.key,
            textAlign: TextAlign.center,
            style: AppTextStyles.kTransactionSubtitleTextStyle,
          ),
        ),
      ));

      angle += angleStep; // Increment angle
    }

    return Container(
      height: containerHeight,
      width: containerWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.accentColor,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "You're owed",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            Text(
              "\$${categoryTotals.values.fold(0.0, (sum, value) => sum + value).toStringAsFixed(2)}",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Stack(
                children: circles.isEmpty
                    ? [
                        Positioned(
                          left: centerX - 40, // Center the single circle
                          top: centerY - 40,
                          width: 80,
                          height: 80,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorPalette[0].withOpacity(0.7),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "No Data",
                              textAlign: TextAlign.center,
                              style:
                                  AppTextStyles.kTransactionSubtitleTextStyle,
                            ),
                          ),
                        ),
                      ]
                    : circles,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
