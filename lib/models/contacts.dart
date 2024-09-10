// import 'dart:math';
//
// import 'package:contri_buter/models/user.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_contacts/contact.dart';
//
// class MyContact {
//   String name;
//   String phNo;
//   int myIndex = Random().nextInt(Colors.primaries.length);
//   MyContact({required this.name, required this.phNo});
//
//   factory MyContact.fromJson(Map<String, dynamic> json) {
//     return MyContact(name: json['name'], phNo: json['ph_no']);
//   }
//
//   factory MyContact.fromContact(Contact contact) =>
//       MyContact(name: contact.displayName, phNo: contact.phones.first.normalizedNumber);
//   Map<String, dynamic> toJson() => {
//         'name': name,
//         'ph_no': phNo,
//       };
//   factory MyContact.fromUserModel(UserModel userModel) =>
//       MyContact(name: userModel.userName, phNo: userModel.phoneNumber);
// }
