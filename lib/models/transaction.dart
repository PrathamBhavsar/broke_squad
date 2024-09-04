import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String title;
  final String category;
  final Map<String, double> contributors;
  final DateTime dateTime;
  final double amount;
  final Map<String, double> unpaidParticipants;
  final String groupName;

  TransactionModel({
    required this.id,
    required this.title,
    required this.category,
    required this.contributors,
    required this.dateTime,
    required this.amount,
    required this.unpaidParticipants,
    required this.groupName,
  });

  // Factory method to create a Transaction from Firestore data
  factory TransactionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TransactionModel(
      id: doc.id,
      title: data['title'] ?? 'Unknown Title',
      groupName: data['groupName'] ?? 'Unknown Group',
      category: data['category'] ?? 'Unknown Category',
      contributors: (data['contributors'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, (value as num).toDouble())),
      unpaidParticipants: (data['unpaidParticipants'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, (value as num).toDouble())),
      dateTime: (data['dateTime'] as Timestamp).toDate(),
      amount: data['amount'].toDouble(),
    );
  }
  @override
  String toString() {
    return 'TransactionModel(id: $id, category: $category, contributors: $contributors, dateTime: $dateTime, amount: $amount, unpaidParticipants: $unpaidParticipants, groupName: $groupName, title: $title)';
  }
}
