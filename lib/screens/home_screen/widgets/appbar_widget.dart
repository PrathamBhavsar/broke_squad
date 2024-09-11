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
  String? _profileImageUrl;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProfileImage();
  }

  Future<void> _fetchProfileImage() async {
    try {
      final profileImageUrl = await UserProvider.instance.getProfileImage();
      setState(() {
        _profileImageUrl = profileImageUrl;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen(),)),
          child: _isLoading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: ClipOval(
                    child: Container(
                      height: 40,
                      width: 40,
                      color: Colors.white,
                    ),
                  ),
                )
              : ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: _profileImageUrl ??
                        "https://firebasestorage.googleapis.com/v0/b/fitmotive-9564c.appspot.com/o/user-icon-on-transparent-background-free-png.webp?alt=media&token=60700768-4bc0-4883-9c4d-104e23fad732",
                    width: 50,
                    fit: BoxFit.cover,
                  ),
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
