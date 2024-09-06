import 'package:cloud_firestore/cloud_firestore.dart';

class Subscription {
  String id;
  String name;
  DateTime createdAt;
  DateTime expireAt;
  bool isActive;

  Subscription(
      {required this.id,
      required this.name,
      required this.createdAt,
      required this.expireAt,
      required this.isActive});

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
      id: json['id'],
      name: json['name'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      expireAt: (json['expireAt'] as Timestamp).toDate(),
      isActive: json['isActive']);
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'createdAt': createdAt,
        'expireAt': expireAt,
        'isActive': isActive,
      };
  static checkIsActive(Subscription subscription) => DateTime.now().isBefore(subscription.expireAt);
}
