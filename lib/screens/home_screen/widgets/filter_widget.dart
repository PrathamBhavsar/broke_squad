import 'package:contri_buter/constants/UI.dart';
import 'package:contri_buter/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionFilterWidget extends StatefulWidget {
  final List<TransactionModel> transactions;
  final String selectedGroup; // Accept the selected group as a parameter
  final Function(String)
      onGroupSelected; // Callback to notify when a group is selected

  TransactionFilterWidget({
    required this.transactions,
    required this.selectedGroup, // Pass the selected group
    required this.onGroupSelected, // Pass the callback function
  });

  @override
  _TransactionFilterWidgetState createState() =>
      _TransactionFilterWidgetState();
}

class _TransactionFilterWidgetState extends State<TransactionFilterWidget> {
  @override
  Widget build(BuildContext context) {
    print('Transactions: ${widget.transactions}');

    final Set<String> groupNames =
        widget.transactions.map((transaction) => transaction.groupName).toSet();
    print('Group Names: $groupNames');

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
                  selected: widget.selectedGroup == 'All',
                  onSelected: (isSelected) {
                    widget.onGroupSelected('All'); // Notify parent widget
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
                        child: Text(groupName,
                            style: AppTextStyles.kTransactionSubtitleTextStyle),
                      ),
                      selected: widget.selectedGroup == groupName,
                      onSelected: (isSelected) {
                        widget
                            .onGroupSelected(groupName); // Notify parent widget
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
              if (widget.selectedGroup == 'All' ||
                  transaction.groupName == widget.selectedGroup) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.accentColor, width: 2),
                          borderRadius: BorderRadiusDirectional.circular(20)),
                      child: ListTile(
                        title: Text(
                          transaction.title,
                          style: AppTextStyles.kTransactionTitleTextStyle,
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${transaction.contributors.keys.join(", ")} paid for',
                                    style: AppTextStyles
                                        .kTransactionSubtitleTextStyle),
                                Text(
                                    '${transaction.unpaidParticipants.keys.join(", ")}',
                                    style: AppTextStyles
                                        .kTransactionSubtitleTextStyle),
                                Text('${transaction.dateTime.toLocal()}',
                                    style: AppTextStyles
                                        .kTransactionSubtitleTextStyle),
                              ],
                            ),
                            Text('\$${transaction.amount.toStringAsFixed(2)}',
                                style:
                                    AppTextStyles.kTransactionTitleTextStyle),
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
