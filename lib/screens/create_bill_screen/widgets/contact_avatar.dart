import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:contri_buter/models/user.dart';
import 'package:flutter/material.dart';

class ContactCircleAvatar extends StatelessWidget {
  ContactCircleAvatar({
    Key? key,
    required this.contact,
    required this.isFirebaseContact,
  }) : super(key: key);

  final UserModel contact; // Using UserModel
  final bool isFirebaseContact; // To identify if contact exists on Firebase

  Color _getColor(String userName) {
    // Generate a consistent color based on the user's name
    final int hash = userName.hashCode;
    final int index = hash % Colors.primaries.length;
    return Colors.primaries[index].withOpacity(0.3);
  }

  @override
  Widget build(BuildContext context) {
    return isFirebaseContact
        ? CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(contact.profileImage),
            backgroundColor:
                Colors.transparent, // No random color for Firebase contacts
          )
        : CircleAvatar(
            backgroundColor: _getColor(contact.userName), // Use fixed color
            child: Text(
              contact.userName
                  .substring(0, 2)
                  .toUpperCase(), // Initials for non-Firebase contacts
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
