import 'package:contri_buter/constants/UI.dart';
import 'package:contri_buter/models/transaction.dart';
import 'package:flutter/material.dart';

import 'circle_widget.dart';

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
    // Calculate total amount per category
    Map<String, double> titleTotals = {};
    for (var transaction in transactions) {
      if (selectedGroup == 'All' || transaction.title == selectedGroup) {
        titleTotals.update(
          transaction.category,
          (existingValue) => existingValue + transaction.amount,
          ifAbsent: () => transaction.amount,
        );
      }
    }

    final double containerWidth = 400.0;
    final double containerHeight = 310.0;

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
              "\$${titleTotals.values.fold(0.0, (sum, value) => sum + value).toStringAsFixed(2)}",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Expanded(
                child: Container(
              child: Center(
                child: BarChartWidget(titleTotals: titleTotals),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
