import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class InfoProvider extends ChangeNotifier {
  bool _isLoading = true;
  bool _isPicked = true;
  final ImagePicker picker = ImagePicker();

  bool get isLoading => _isLoading;
  bool get isPicked => _isPicked;

  void toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }
  void togglePicked() {
    _isLoading = !_isLoading;
    notifyListeners();
  }
  Future<void> pickImageFromCamera() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      // Handle the selected image (e.g., upload or store locally)
      print('Image selected from camera: ${photo.path}');
    }
  }

  Future<void> pickImageFromGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Handle the selected image (e.g., upload or store locally)
      print('Image selected from gallery: ${image.path}');
    }
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
