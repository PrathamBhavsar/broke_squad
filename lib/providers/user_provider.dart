import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchProfileImage(User user) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('profile_image')) {
      print('Profile image already fetched.');
      return; // Exit if the image is already fetched
    }

    try {
      DocumentSnapshot userDoc =
      await _firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        String? profileImageUrl = userDoc.get('profile_image');

        if (profileImageUrl != null) {
          await prefs.setString('profile_image', profileImageUrl);
          notifyListeners();
          print('Profile image fetched and saved to SharedPreferences.');
        } else {
          print('No profile image found in Firestore.');
        }
      } else {
        print('User document does not exist in Firestore.');
      }
    } catch (e) {
      print('Error fetching profile image: $e');
    }
  }

  Future<String?> getProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('profile_image');
  }
}
