import 'dart:math';

import 'package:contri_buter/models/contacts.dart';
import 'package:flutter/material.dart';

class ContactCircleAvatar extends StatelessWidget {
  ContactCircleAvatar({super.key, required this.contact}) {
    myIndex = Random().nextInt(Colors.primaries.length);
  }
  final MyContact contact;
  late final myIndex;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.primaries[contact.myIndex].withOpacity(0.3),
      child: Text(
        contact.name.substring(0, 2),
      ),
    );
  }
}
