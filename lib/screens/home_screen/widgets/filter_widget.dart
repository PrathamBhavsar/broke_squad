import 'package:contri_buter/constants/UI.dart';
import 'package:contri_buter/controllers/firebase_controller.dart';
import 'package:contri_buter/models/transaction.dart';
import 'package:contri_buter/providers/user_provider.dart';
import 'package:contri_buter/screens/create_bill_screen/widgets/contact_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

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
  String formatDate(DateTime dateTime) {
    String daySuffix = getDaySuffix(dateTime.day);
    return '${dateTime.day}$daySuffix ${DateFormat('MMM').format(dateTime)}, ${dateTime.year}';
  }

  String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Set<String> groupNames =
        widget.transactions.map((transaction) => transaction.category).toSet();

    _handleTap(TransactionModel transaction, bool isPaid) async {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
                side: BorderSide(
                    color: isPaid ? Colors.green : Colors.red, width: 2)),
            title: Text(
              'Details',
              style: AppTextStyles.kTransactionTitleTextStyle,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  transaction.amount.toString(),
                  style: AppTextStyles.kTransactionSubtitleTextStyle,
                ),
                Text(
                  transaction.category,
                  style: AppTextStyles.kTransactionSubtitleTextStyle,
                ),
                Text(
                  transaction.createdBy.userName,
                  style: AppTextStyles.kTransactionSubtitleTextStyle,
                ),
                Text(
                  transaction.dateTime.toString(),
                  style: AppTextStyles.kTransactionSubtitleTextStyle,
                ),
                Text(
                  '${isPaid ? 'You Didn\'t' : 'Did you'} pay \$${(transaction.amount / transaction.members.length).toStringAsFixed(2)} to ${transaction.createdBy.userName}?',
                  style: AppTextStyles.kTransactionSubtitleTextStyle,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await FirebaseController.instance
                      .updateTransaction(transaction, isPaid);

                  Navigator.pop(context);
                },
                child: Text(
                  'Yes',
                  style: AppTextStyles.kTransactionTitleTextStyle
                      .copyWith(color: Colors.green),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'No',
                  style: AppTextStyles.kTransactionTitleTextStyle
                      .copyWith(color: Colors.red),
                ),
              )
            ],
          );
        },
      ).whenComplete(
        () => setState(() {}),
      );
    }

    final Set<String> displayedTransactionIds = {};

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
                      style: AppTextStyles.kTransactionLargerSubtitleTextStyle,
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
                            style: AppTextStyles
                                .kTransactionLargerSubtitleTextStyle),
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
              bool isPaid = transaction.members[
                          '${UserProvider.instance.user!.phoneNumber}'] !=
                      null
                  ? transaction
                          .members['${UserProvider.instance.user!.phoneNumber}']
                      ['isPaid']
                  : false;

              // Check if the current user's phone number is part of the transaction
              if (transaction.members
                  .containsKey(UserProvider.instance.user!.phoneNumber)) {
                if (widget.selectedGroup == 'All' ||
                    transaction.category == widget.selectedGroup) {
                  // Ensure the transaction is displayed only once
                  if (!displayedTransactionIds.contains(transaction.id)) {
                    displayedTransactionIds.add(transaction.id);
                    return GestureDetector(
                      onTap: () async => await _handleTap(transaction, isPaid),
                      child: MyTransactionTile(
                        isPaid: isPaid,
                        transaction: transaction,
                        formatDate: formatDate,
                      ),
                    );
                  }
                }
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}

class MyTransactionTile extends StatelessWidget {
  const MyTransactionTile(
      {super.key, this.transaction, this.isPaid, this.formatDate});
  final transaction;
  final isPaid;
  final formatDate;

  String _getPaidMembers(Map<String, dynamic> members) {
    // Extract members whose 'isPaid' is true
    final paidMembers = members.entries
        .where((member) => member.value['isPaid'] == true)
        .map((member) => member.value['displayName'])
        .toList();

    // Join the names with commas and return the string
    return paidMembers.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      shadowColor: isPaid ? Colors.green : Colors.red,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(20.r),
          side:
              BorderSide(color: isPaid ? Colors.green : Colors.red, width: 2)),
      color: AppColors.kAuthTextFieldColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: isPaid ? Colors.green : Colors.red,
                          width: 2,
                        ),
                        shape: BoxShape.circle),
                    width: 50.w,
                    height: 50.h,
                    child: ContactCircleAvatar(
                      contact: transaction.createdBy,
                      isFirebaseContact: true,
                    )),
                SizedBox(
                  width: 12.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: transaction.title,
                            style: AppTextStyles.kTransactionTitleTextStyle,
                          ),
                          TextSpan(
                            text:
                                '\n${_getPaidMembers(transaction.members)} paid on\n',
                            style: AppTextStyles.kTransactionSubtitleTextStyle,
                          ),
                          TextSpan(
                            text: formatDate(transaction.dateTime.toLocal()),
                            style: AppTextStyles.kTransactionSubtitleTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.kAuthTextFieldColor,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isPaid ? Colors.green : Colors.red,
                          width: 2,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      child: Text(
                        isPaid ? 'Paid' : 'UnPaid',
                        style: AppTextStyles.poppins.copyWith(
                            color: isPaid ? Colors.green : Colors.red,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text('\$${transaction.amount.toStringAsFixed(2)}',
                        style: AppTextStyles.kTransactionTitleTextStyle),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
