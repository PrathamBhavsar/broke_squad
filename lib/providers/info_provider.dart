import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:contri_buter/models/user.dart';

class InfoProvider extends ChangeNotifier {
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  void toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  Future<void> editUserEntry(String userName, String profileImage) async {
    final firestore = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    final userId = auth.currentUser!.uid;

    // Insert the user into the Firestore users collection
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .update({'user_name': userName, 'profile_image': profileImage});
      print('User created with ID: ${userId}');
    } catch (error) {
      // Handle error
      print('Insert user error: $error');
    }
  }
}
