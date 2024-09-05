import 'package:contri_buter/models/contacts.dart';
import 'package:flutter/material.dart';

class ContactCircleAvatar extends StatelessWidget {
  const ContactCircleAvatar({super.key, required this.contact});
  final Contact contact;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text(
        contact.name.substring(0, 2),
      ),
    );
  }
}
