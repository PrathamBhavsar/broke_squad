import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contri_buter/models/user.dart';

class TransactionModel {
  final String id;
  final String title;
  final String category;
  final Map<String, dynamic> contributors;
  final DateTime dateTime;
  final double amount;
  final Map<String, dynamic> unpaidParticipants;
  final String createdBy;

  TransactionModel({
    required this.id,
    required this.title,
    required this.category,
    required this.contributors,
    required this.dateTime,
    required this.amount,
    required this.unpaidParticipants,
    required this.createdBy,
  });

  toJson() => {
        'title': title,
        'category': category,
        'contributors': contributors,
        'unpaidParticipants': unpaidParticipants,
        'dateTime': dateTime,
        'amount': amount,
        'createdBy': createdBy,
      };
  // Factory method to create a Transaction from Firestore data
  factory TransactionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TransactionModel(
      id: doc.id,
      title: data['title'] ?? 'Unknown Title',
      category: data['category'] ?? 'Unknown Category',
      contributors: data['contributors'],
      unpaidParticipants: data['unpaidParticipants'],
      dateTime: (data['dateTime'] as Timestamp).toDate(),
      amount: data['amount'].toDouble(),
      createdBy: data['createdBy'],
    );
  }
  @override
  String toString() {
    return 'TransactionModel(id: $id, category: $category, contributors: $contributors, dateTime: $dateTime, amount: $amount, unpaidParticipants: $unpaidParticipants, title: $title)';
  }

  static Map<String, dynamic> peopleFromList(
      List<UserModel> contacts, double amount) {
    final Map<String, dynamic> res = {};
    for (UserModel contact in contacts) {
      res.putIfAbsent(
        contact.phoneNumber,
        () => {'name': contact.userName, 'amount': amount, 'profile_image':contact.profileImage},
      );
    }
    return res;
  }
}
