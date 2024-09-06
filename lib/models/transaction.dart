import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contri_buter/models/contacts.dart';

class TransactionModel {
  final String id;
  final String title;
  final String category;
  final Map<String, dynamic> contributors;
  final DateTime dateTime;
  final double amount;
  final Map<String, dynamic> unpaidParticipants;


  TransactionModel({
    required this.id,
    required this.title,
    required this.category,
    required this.contributors,
    required this.dateTime,
    required this.amount,
    required this.unpaidParticipants,
  });

  // Factory method to create a Transaction from Firestore data
  factory TransactionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TransactionModel(
      id: doc.id,
      title: data['title'] ?? 'Unknown Title',
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
    return 'TransactionModel(id: $id, category: $category, contributors: $contributors, dateTime: $dateTime, amount: $amount, unpaidParticipants: $unpaidParticipants, title: $title)';
  }
  static Map<String,dynamic> peopleFromList(List<MyContact> contacts,double amount) {
    final Map<String,dynamic> res = {};
    for(MyContact contact in contacts) {
      res.addAll({
        "id":contact.phNo,
        "name":contact.name,
        "amount":amount,
      });
    }
    return res;
  }
}
