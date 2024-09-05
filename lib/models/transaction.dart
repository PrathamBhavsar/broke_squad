import 'package:contri_buter/models/contacts.dart';

class Transaction {
  final String category;
  final List<MyContact> contributors;
  final DateTime dateTime;
  final double amount;
  final List<MyContact> unpaidParticipants;
  final String groupName;

  Transaction({
    required this.category,
    required this.contributors,
    required this.dateTime,
    required this.amount,
    required this.unpaidParticipants,
    required this.groupName,
  });
}
