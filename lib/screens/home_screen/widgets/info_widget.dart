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
    // Define a list of light colors
    final List<Color> lightColors = [
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

    // Random number generator for color selection
    final random = Random();

    return Container(
      height: 310,
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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double containerWidth = constraints.maxWidth;
                  final double containerHeight = constraints.maxHeight;
                  List<Positioned> circles = [];

                  // Calculate the center of the container
                  final centerX = containerWidth / 2;
                  final centerY = containerHeight / 2;

                  for (var entry in categoryTotals.entries) {
                    double size = (entry.value / maxAmount) * 80 +
                        40; // Original size calculation
                    Color color =
                        lightColors[random.nextInt(lightColors.length)];

                    // Generate position closer to the center
                    bool positionIsValid = false;
                    Offset position;

                    do {
                      // Generate position within 40% of the container size around the center
                      double x = centerX +
                          (random.nextDouble() - 0.5) * containerWidth * 0.4;
                      double y = centerY +
                          (random.nextDouble() - 0.5) * containerHeight * 0.4;

                      // Ensure the circle doesn't exceed the container bounds
                      x = x.clamp(size / 2, containerWidth - size / 2);
                      y = y.clamp(size / 2, containerHeight - size / 2);

                      position = Offset(x - size / 2, y - size / 2);

                      // Check for overlap
                      positionIsValid = circles.every((circle) {
                        double dx = (circle.left! + circle.width! / 2) -
                            (position.dx + size / 2);
                        double dy = (circle.top! + circle.height! / 2) -
                            (position.dy + size / 2);
                        double distance = sqrt(dx * dx + dy * dy);
                        return distance >=
                            (size / 2 +
                                (circle.width! / 2) +
                                2); // Further reduced minimum distance
                      });
                    } while (!positionIsValid);

                    // Add circle to the list
                    circles.add(Positioned(
                      left: position.dx,
                      top: position.dy,
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
                  }

                  return Stack(children: circles);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
