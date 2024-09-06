import 'package:cached_network_image/cached_network_image.dart';
import 'package:contri_buter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class AppbarWidget extends StatefulWidget {
  const AppbarWidget({super.key});

  @override
  State<AppbarWidget> createState() => _AppbarWidgetState();
}

class _AppbarWidgetState extends State<AppbarWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FutureBuilder<String?>(
          future: UserProvider.instance.getProfileImage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: ClipOval(
                  child: Container(
                    height: 40,
                    width: 40,
                    color: Colors.white,
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Icon(Icons.error);
            } else if (snapshot.hasData) {
              final profileImageUrl = snapshot.data;
              return GestureDetector(
                onTap: () {
                  context.goNamed('profile');
                },
                child: profileImageUrl != null
                    ? ClipOval(
                    child: CachedNetworkImage(imageUrl: profileImageUrl,height: 50,width: 50,fit: BoxFit.cover,)
                )
                    : Icon(Icons.account_circle, size: 40),
              );
            } else {
              return Icon(Icons.account_circle, size: 40);
            }
          },
        ),
      ],
    );
  }
}
// Image.network(
// profileImageUrl,
// height: 40,
// width: 40,
// fit: BoxFit.cover,
// ),