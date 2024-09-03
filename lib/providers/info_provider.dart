import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfoProvider extends ChangeNotifier {
  bool _isLoading = true;
  // bool _isPicked = false; // Default to false
  String _profileImage = ''; // Store the image path

  bool get isLoading => _isLoading;



  setImage(String imageUrl) => _profileImage = imageUrl;
  // Future<void> pickImageFromCamera() async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? photo = await picker.pickImage(source: ImageSource.camera);
  //
  //   if (photo != null) {
  //     _profileImage = photo.path;
  //     _isPicked = true;
  //     notifyListeners();
  //   }
  // }

  // Future<void> pickImageFromGallery() async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (image != null) {
  //     _profileImage = image.path;
  //     _isPicked = true;
  //     notifyListeners();
  //   }
  // }

  // Future<String?> uploadImageToFirebase() async {
  //   if (_profileImage == null) return null;
  //
  //   try {
  //     final File file = File(_profileImage!);
  //     final String fileName = FirebaseAuth.instance.currentUser!.uid;
  //     final Reference storageRef = FirebaseStorage.instance
  //         .ref()
  //         .child('profile_images')
  //         .child(fileName);
  //
  //     final UploadTask uploadTask = storageRef.putFile(file);
  //     final TaskSnapshot snapshot = await uploadTask;
  //     final String downloadUrl = await snapshot.ref.getDownloadURL();
  //
  //     return downloadUrl;
  //   } catch (error) {
  //     print('Failed to upload image: $error');
  //     return null;
  //   }
  // }

  Future<void> editUserEntry(String userName, BuildContext context) async {
    final firestore = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    final userId = auth.currentUser!.uid;

    try {
      await firestore
          .collection('users')
          .doc(userId)
          .update({'user_name': userName, 'profile_image': _profileImage});
      print('User updated with ID: ${userId}');

      context.goNamed('home');
    } catch (error) {
      print('Update user error: $error');
    }
  }
}
