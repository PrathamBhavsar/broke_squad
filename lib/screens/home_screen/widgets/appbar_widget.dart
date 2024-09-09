import 'package:cached_network_image/cached_network_image.dart';
import 'package:contri_buter/providers/user_provider.dart';
import 'package:contri_buter/screens/home_screen/profile_screen.dart';
import 'package:contri_buter/utils.dart';
import 'package:flutter/material.dart';
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
        InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen(),)),
          child: FutureBuilder<String?>(
            future: UserProvider.instance.getProfileImage(),
            builder: (context, snapshot) {
              logEvent(str: snapshot.data.toString());
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
                return ClipOval(
                    child: CachedNetworkImage(
                  imageUrl: profileImageUrl ??
                      "https://firebasestorage.googleapis.com/v0/b/fitmotive-9564c.appspot.com/o/user-icon-on-transparent-background-free-png.webp?alt=media&token=60700768-4bc0-4883-9c4d-104e23fad732",
                  width: 50,
                  fit: BoxFit.cover,
                ));
              } else {
                return Icon(Icons.account_circle, size: 40);
              }
            },
          ),
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
