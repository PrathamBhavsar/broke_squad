import 'package:contri_buter/providers/auth_provider.dart';
import 'package:contri_buter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class AppbarWidget extends StatefulWidget {
  const AppbarWidget({super.key});

  @override
  State<AppbarWidget> createState() => _AppbarWidgetState();
}

class _AppbarWidgetState extends State<AppbarWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.menu_rounded),
              onPressed: () {
                context.goNamed('menu');
              },
            ),
            Consumer<UserProvider>(
              builder: (context, homeProvider, child) {
                return FutureBuilder<String?>(
                  future: homeProvider.getProfileImage(),
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
                                child: Image.network(
                                  profileImageUrl,
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Icon(Icons.account_circle, size: 40),
                      );
                    } else {
                      return Icon(Icons.account_circle, size: 40);
                    }
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
