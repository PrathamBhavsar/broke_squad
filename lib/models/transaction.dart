import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contri_buter/models/user.dart';


class TransactionModel {
  final String id;
  final String title;
  final String category;
  final Map<String, dynamic> members;
  final DateTime dateTime;
  final double amount;
  // final Map<String, dynamic> unpaidParticipants;
  final UserModel createdBy;

  TransactionModel({
    required this.id,
    required this.title,
    required this.category,
    required this.members,
    required this.dateTime,
    required this.amount,
    // required this.unpaidParticipants,
    required this.createdBy,
  });

  toJson() => {
        'title': title,
        'category': category,
        'members': members,
        // 'unpaidParticipants': unpaidParticipants,
        'dateTime': dateTime,
        'amount': amount,
        'createdBy': createdBy.toJson(),
      };
  // Factory method to create a Transaction from Firestore data
  factory TransactionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TransactionModel(
      id: doc.id,
      title: data['title'] ?? 'Unknown Title',
      category: data['category'] ?? 'Unknown Category',
      members: data['members'],
      // unpaidParticipants: data['unpaidParticipants'],
      dateTime: (data['dateTime'] as Timestamp).toDate(),
      amount: data['amount'].toDouble(),
      createdBy: UserModel.fromJson(data['createdBy']),
    );
  }
  @override
  String toString() {
    return 'TransactionModel(id: $id, category: $category, contributors: $members, dateTime: $dateTime, amount: $amount, title: $title)';
  }

  static Map<String, dynamic> peopleFromList(List<UserModel> contacts, double amount) {
    final Map<String, dynamic> res = {};
    for (UserModel contact in contacts) {
      res.putIfAbsent(
        contact.phoneNumber,
        () => {'name': contact.userName, 'amount': amount, 'profile_image': contact.profileImage},
      );
    }
    return res;
  }
}
