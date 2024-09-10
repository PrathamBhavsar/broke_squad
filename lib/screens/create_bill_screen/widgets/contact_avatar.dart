import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:contri_buter/models/user.dart';
import 'package:flutter/material.dart';

class ContactCircleAvatar extends StatelessWidget {
  ContactCircleAvatar({super.key, required this.contact}) {
    myIndex = Random().nextInt(Colors.primaries.length);
  }
  final UserModel contact;
  late final myIndex;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: CachedNetworkImageProvider(contact.profileImage),
    );
  }
}
