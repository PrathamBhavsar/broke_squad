import 'package:contri_buter/constants/UI.dart';
import 'package:contri_buter/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionFilterWidget extends StatefulWidget {
  final List<Transaction> transactions;

  TransactionFilterWidget({required this.transactions});

  @override
  _TransactionFilterWidgetState createState() => _TransactionFilterWidgetState();
}

class _TransactionFilterWidgetState extends State<TransactionFilterWidget> {
  String selectedGroup = 'All';

  @override
  Widget build(BuildContext context) {
    final Set<String> groupNames =
        widget.transactions.map((transaction) => transaction.groupName ?? 'Unknown Group').toSet();

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                FilterChip(
                  showCheckmark: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  side: BorderSide(
                    color: AppColors.accentColor,
                    width: 2,
                  ),
                  label: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Text(
                      'All',
                      style: AppTextStyles.kTransactionSubtitleTextStyle,
                    ),
                  ),
                  selected: selectedGroup == 'All',
                  onSelected: (isSelected) {
                    setState(() {
                      selectedGroup = 'All';
                    });
                  },
                ),
                ...groupNames.map((groupName) => FilterChip(
                      showCheckmark: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      side: BorderSide(
                        color: AppColors.accentColor,
                        width: 2,
                      ),
                      label: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Text(groupName, style: AppTextStyles.kTransactionSubtitleTextStyle),
                      ),
                      selected: selectedGroup == groupName,
                      onSelected: (isSelected) {
                        setState(() {
                          selectedGroup = groupName;
                        });
                      },
                    )),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),

        // Filtered transaction list
        Expanded(
          child: ListView.builder(
            itemCount: widget.transactions.length,
            itemBuilder: (context, index) {
              final transaction = widget.transactions[index];
              // Null-safe check for group name comparison
              if (selectedGroup == 'All' || transaction.groupName == selectedGroup) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.accentColor, width: 2),
                          borderRadius: BorderRadiusDirectional.circular(20)),
                      child: ListTile(
                        title: Text(
                          transaction.category ?? 'Unknown Category',
                          style: AppTextStyles.kTransactionTitleTextStyle,
                        ), // Null-safe access
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var element in transaction.contributors)
                                  Text('${element.name} paid for',
                                      style: AppTextStyles.kTransactionSubtitleTextStyle),
                                for (var element in transaction.unpaidParticipants)
                                Text('${element.name}',
                                    style: AppTextStyles.kTransactionSubtitleTextStyle),
                                Text('${transaction.dateTime.toLocal()}',
                                    style: AppTextStyles.kTransactionSubtitleTextStyle),
                              ],
                            ),
                            Text('\$${transaction.amount.toStringAsFixed(2)}',
                                style: AppTextStyles.kTransactionTitleTextStyle),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ),
      ],
    );
  }
}
