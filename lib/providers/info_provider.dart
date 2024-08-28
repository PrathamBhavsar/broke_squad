import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contri_buter/constants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'navigation_provider.dart';

class InfoProvider extends ChangeNotifier {
  bool _isLoading = true;
  bool _isPicked = false; // Default to false
  String? _profileImage; // Store the image path

  bool get isLoading => _isLoading;
  bool get isPicked => _isPicked;
  String? get profileImage => _profileImage;

  void toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void togglePicked() {
    _isPicked = !_isPicked;
    notifyListeners();
  }

  Future<void> pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      _profileImage = photo.path;
      _isPicked = true;
      notifyListeners();
    }
  }

  Future<void> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      _profileImage = image.path;
      _isPicked = true;
      notifyListeners();
    }
  }

  Future<String?> uploadImageToFirebase() async {
    if (_profileImage == null) return null;

    try {
      final File file = File(_profileImage!);
      final String fileName = FirebaseAuth.instance.currentUser!.uid;
      final Reference storageRef = FirebaseStorage.instance.ref().child('profile_images').child(fileName);

      final UploadTask uploadTask = storageRef.putFile(file);
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (error) {
      print('Failed to upload image: $error');
      return null;
    }
  }

  Future<void> editUserEntry(String userName, BuildContext context) async {
    final firestore = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    final userId = auth.currentUser!.uid;

    try {
      String? profileImageUrl = await uploadImageToFirebase();

      await firestore
          .collection('users')
          .doc(userId)
          .update({'user_name': userName, 'profile_image': profileImageUrl});
      print('User updated with ID: ${userId}');


      Provider.of<NavigationProvider>(context, listen: false)
          .navigateTo(context, Routes.home);
    } catch (error) {
      print('Update user error: $error');
    }
  }
}
